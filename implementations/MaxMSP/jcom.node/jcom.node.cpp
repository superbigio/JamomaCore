/* 
 *	jcom.node
 *	External object
 *	Copyright © 2010 by Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */

#include "TTModularClassWrapperMax.h"

#define address_out 0
#define data_out 1

// Definitions
void		WrapTTContainerClass(WrappedClassPtr c);
void		WrappedContainerClass_new(TTPtr self, AtomCount argc, AtomPtr argv);

t_max_err	node_notify(TTPtr self, t_symbol *s, t_symbol *msg, void *sender, void *data);
void		node_assist(TTPtr self, void *b, long msg, long arg, char *dst);

void		node_list(TTPtr self, t_symbol *msg, long argc, t_atom *argv);

void		node_share_context_node(TTPtr self, TTNodePtr *contextNode);

void		node_return_address(TTPtr self, t_symbol *msg, long argc, t_atom *argv);
void		node_return_value(TTPtr self, t_symbol *msg, long argc, t_atom *argv);

void		node_build(TTPtr self, SymbolPtr address);


int TTCLASSWRAPPERMAX_EXPORT main(void)
{
	ModularSpec *spec = new ModularSpec;
	spec->_wrap = &WrapTTContainerClass;
	spec->_new = &WrappedContainerClass_new;
	spec->_any = NULL;
	
	return wrapTTModularClassAsMaxClass(TT("Container"), "jcom.node", NULL, spec);
}

void WrapTTContainerClass(WrappedClassPtr c)
{
	class_addmethod(c->maxClass, (method)node_notify,					"notify",				A_CANT, 0);
	class_addmethod(c->maxClass, (method)node_assist,					"assist",				A_CANT, 0L);
	
	class_addmethod(c->maxClass, (method)node_share_context_node,		"share_context_node",	A_CANT,	0);
	
	class_addmethod(c->maxClass, (method)node_return_address,			"return_address",		A_CANT, 0);
	class_addmethod(c->maxClass, (method)node_return_value,				"return_value",			A_CANT, 0);
	
	class_addmethod(c->maxClass, (method)node_list,						"anything",				A_GIMME, 0L);
	
}

void WrappedContainerClass_new(TTPtr self, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	SymbolPtr					address;
 	long						attrstart = attr_args_offset(argc, argv);			// support normal arguments
	
	// A Modular object needs an address argument
	if (attrstart && argv) 
		address = atom_getsym(argv);
	else
		address = _sym_nothing;
	
	// create the container
	jamoma_container_create((ObjectPtr)x, &x->wrappedObject);
	
	// The following must be deferred because we have to interrogate our box,
	// and our box is not yet valid until we have finished instantiating the object.
	// Trying to use a loadbang method instead is also not fully successful (as of Max 5.0.6)
	defer_low((ObjectPtr)x, (method)node_build, address, 0, 0);
	
	// Make two outlets
	x->outlets = (TTHandle)sysmem_newptr(sizeof(TTPtr) * 2);
	x->outlets[address_out] = outlet_new(x, NULL);					// anything outlet to output address
	x->outlets[data_out] = outlet_new(x, NULL);						// anything outlet to output data

}

void node_build(TTPtr self, SymbolPtr address)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue						v, args;
	TTNodePtr					node = NULL;
	TTBoolean					newInstance;
	TTSymbolPtr					nodeAddress, relativeAddress;
	TTPtr						context;
	
	jamoma_subscriber_create((ObjectPtr)x, x->wrappedObject, address, &x->subscriberObject);
	
	// if the subscription is successful
	if (x->subscriberObject) {
		
		// Is a new instance have been created ?
		x->subscriberObject->getAttributeValue(TT("NewInstanceCreated"), v);
		v.get(0, newInstance);
		
		if (newInstance) {
			x->subscriberObject->getAttributeValue(TT("RelativeAddress"), v);
			v.get(0, &relativeAddress);
			object_warn((t_object*)x, "Jamoma cannot create multiple jcom.node with the same OSC identifier (%s).  Using %s instead.", address->s_name, relativeAddress->getCString());
		}
		
		// Set the Address attribute of the Container
		x->subscriberObject->getAttributeValue(TT("NodeAddress"), v);
		x->wrappedObject->setAttributeValue(kTTSym_Address, v);
		
		// debug
		v.get(0, &nodeAddress);
		object_post((ObjectPtr)x, "address = %s", nodeAddress->getCString());
		
		// get the Node
		x->subscriberObject->getAttributeValue(TT("Node"), v);
		v.get(0, (TTPtr*)&node);
		
		// attach to the patcher to be notified of his destruction
		 node->getAttributeValue(TT("Context"), v);
		v.get(0, (TTPtr*)&context);
		object_attach_byptr_register(x, context, _sym_box);

	}
}

t_max_err node_notify(TTPtr self, t_symbol *s, t_symbol *msg, void *sender, void *data)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue	v;
	ObjectPtr context;
	x->subscriberObject->getAttributeValue(TT("Context"), v);
	v.get(0, (TTPtr*)&context);
	
	// if the patcher is deleted
	if (sender == context)
		if (msg == _sym_free) {
			
			// delete
			TTObjectRelease(TTObjectHandle(&x->subscriberObject));
			
			// no more notification
			object_detach_byptr((ObjectPtr)x, context);
		}
	
	return MAX_ERR_NONE;
}

// Method for Assistance Messages
void node_assist(TTPtr self, void *b, long msg, long arg, char *dst)
{
	if (msg==1)			// Inlets
		strcpy(dst, "");		
	else if (msg==2)		// Outlets
		strcpy(dst, "");
}

void node_list(TTPtr self, t_symbol *msg, long argc, t_atom *argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	
	jamoma_container_send((TTContainerPtr)x->wrappedObject, msg, argc, argv);
}

void node_return_address(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	outlet_anything(x->outlets[address_out], msg, argc, argv);
}

void node_return_value(TTPtr self, SymbolPtr msg, AtomCount argc, AtomPtr argv)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	outlet_anything(x->outlets[data_out], msg, argc, argv);
}

void node_share_context_node(TTPtr self, TTNodePtr *contextNode)
{
	WrappedModularInstancePtr	x = (WrappedModularInstancePtr)self;
	TTValue	v;
	
	if (x->subscriberObject) {
		
		x->subscriberObject->getAttributeValue(TT("ContextNode"), v);
		v.get(0, TTObjectHandle(contextNode));
	}
	else
		*contextNode = NULL;
}