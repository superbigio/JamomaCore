// External Object for Jamoma: duplicate filter
// By Timothy Place, Copyright � 2005
// License: GNU LGPL

#include "ext.h"					// Max Header
#include "ext_strings.h"			// String Functions
#include "commonsyms.h"				// Common symbols used by the Max 4.5 API
#include "ext_obex.h"				// Max Object Extensions (attributes) Header
#define MAX_LIST_SIZE 256

// Data Structure for this object
typedef struct _change			// Data Structure for this object
{
	t_object		ob;	
	void			*obex;
	void 			*change_Out[2];					// outlets
	void			*inlet_right;					// 2nd inlet
	long			inletnum;						// proxy input inlet number	
	short 			last_argc;
	t_atom 			*last_argv;
	Symbol 			*last_input_symbol;
	t_atom			last_input_list[MAX_LIST_SIZE];	// 
	long			last_input_int;
	float			last_input_float;
} t_change;

// Prototypes for methods
void change_assist(t_change *x, void *b, long m, long a, char *s);		// Assistance Method
void *change_new(void);													// New Object Creation Method
void change_anything(t_change *x, Symbol *msg, short argc, Atom *argv);	// Symbol method
void change_int(t_change *x, long value);
void change_float(t_change *x, float value);
float atom_getvalue(long index, short argc, t_atom *argv);
void atom_copy(t_atom *dst, t_atom *src);
bool atom_compare(Atom *in1, Atom *in2);

// Globals
t_class *change_class;			// Required. Global pointing to this class


/************************************************************************************/
// Main() Function

void main(void)				// main recieves a copy of the Max function macros table
{
	long attrflags = 0;
	t_class *c;
	t_object *attr;
	
	common_symbols_init();

	// Define our class
	c = class_new("jmod.change",(method)change_new, (method)0L, (short)sizeof(t_change), (method)0L, 0L, 0);
	class_obexoffset_set(c, calcoffset(t_change, obex));

	// Make methods accessible for our class: 
	class_addmethod(c, (method)change_int,				"int", A_GIMME, 0L);
	class_addmethod(c, (method)change_float,			"float", A_GIMME, 0L);
	class_addmethod(c, (method)change_anything,			"list",	A_GIMME, 0L);
	class_addmethod(c, (method)change_anything,			"anything", A_GIMME, 0L);
    class_addmethod(c, (method)change_assist, 			"assist", A_CANT, 0L); 
    class_addmethod(c, (method)object_obex_dumpout, 	"dumpout", A_CANT,0);  
    class_addmethod(c, (method)object_obex_quickref,	"quickref", A_CANT, 0);

	// Finalize our class
	class_register(CLASS_BOX, c);
	change_class = c;
}


/************************************************************************************/
// Object Life

void *change_new(void)
{
	short i;
	t_change *x;									// Declare an object (based on our struct)
	x = (t_change *)object_alloc(change_class);		// Create object, store pointer to it (get 1 inlet free)
	if(x){
		object_obex_store((void *)x, _sym_dumpout, (object *)outlet_new(x,NULL));	// dumpout	
		x->change_Out[1] = bangout(x);				// Create Outlets (right to left order)
	    x->change_Out[0] = outlet_new(x, 0);		//	...

	// Create Right Inlet (inletnum == 1)
		x->inlet_right = proxy_new(x, 1, &x->inletnum);

	// Init the temp storage
	for(i=0; i<MAX_LIST_SIZE; i++)
		atom_setsym(&(x->last_input_list[i]), _sym_nothing);			
	}
	return (x);										// Return pointer to our instance
}


/************************************************************************************/
// Methods bound to input/inlets

// Method for Assistance Messages
void change_assist(t_change *x, void *b, long msg, long arg, char *dst)
{
	if(msg==1) 							// Inlets
		strcpy(dst, "Input");
	else if(msg==2){ 					// Outlets
		switch(arg){
			case 0: strcpy(dst, "Repetition Filtered Output"); break;
			case 1: strcpy(dst, "(bang) input is the same as the last input"); break;
			case 2: strcpy(dst, "dumpout"); break;
 		}
 	}
}


// INPUT: INT/FLOAT
void change_int(t_change *x, long value)
{
	if(x->inletnum == 0){
		if(value != x->last_input_int)
			outlet_int(x->change_Out[0], value);
		else
			outlet_bang(x->change_Out[1]);
	}
	x->last_input_int = value;		
}

void change_float(t_change *x, double value)
{
	if(x->inletnum == 0){
		if(value != x->last_input_float)
			outlet_float(x->change_Out[0], value);
		else
			outlet_bang(x->change_Out[1]);
	}
	x->last_input_float = value;		
}


// INPUT: LIST/SYMBOL
void change_anything(t_change *x, t_symbol *msg, short argc, t_atom *argv)
{	
	short 	i;
	bool	match = false;
	bool	mismatch = false;
	
	if(argc){		// list input
		if(x->inletnum == 0){
			if(msg == x->last_input_symbol){	// if the symbol is the same, check the args...
				for(i=0; i<argc; i++){
					match = atom_compare(&(x->last_input_list[i]), argv+i);			
					if(!match) mismatch = true;
				}
			}
			else
				mismatch = true;				// first symbol was different
			
			if(mismatch)
				outlet_anything(x->change_Out[0], msg, argc, argv);		// output the input
			else								// All elements are the same
				outlet_bang(x->change_Out[1]);		
		}		
		x->last_input_symbol = msg;						// Make copies of the input for the next time
		for(i=0;i<argc;i++)
			atom_copy(&(x->last_input_list[i]), argv+i);
	}
	
	else{									// symbol input
		if(x->inletnum == 0){
			if((msg != x->last_input_symbol) || (argc != x->last_argc) || (argv != x->last_argv))
				outlet_anything(x->change_Out[0], msg, argc, argv);		// output the result
			else
				outlet_bang(x->change_Out[1]);	
		}
		x->last_input_symbol = msg;
		x->last_argc = argc;
		x->last_argv = argv;	
	}
}




// Utility function for getting the value of a Max atom
float atom_getvalue(long index, short argc, t_atom *argv)
{
	float	val = 0;
	if(argc && argv){
		if(index < argc){
			switch(argv[index].a_type){
				case A_LONG:
					val = atom_getlong(argv+index);
					break;
				case A_FLOAT:
					val = atom_getfloat(argv+index);
					break;
			}
		}	
	}
	return val;
}


// A utility for copying an atom
void atom_copy(t_atom *dst, t_atom *src)
{
	//dst[0].a_type = src[0].a_type;
	switch(src[0].a_type){
		case A_LONG:
			//dst[0].a_w.w_long = src[0].a_w.w_long;
			atom_setlong(dst, atom_getlong(src));
			break;
		case A_FLOAT:
			//dst[0].a_w.w_float = src[0].a_w.w_float;
			atom_setfloat(dst, atom_getfloat(src));
			break;
		case A_SYM:
			//dst[0].a_w.w_sym = src[0].a_w.w_sym;
			atom_setsym(dst, atom_getsym(src));
			break;
		default:
			error("could not copy atom!");
			break;	
	}
}


// A utility for comparing two atoms
bool atom_compare(Atom *in1, Atom *in2)
{
	if((in1[0].a_type == A_LONG) && (in2[0].a_type == A_LONG)){
		//if(in1[0].a_w.w_long == in2[0].a_w.w_long)
		if((atom_getlong(in1))==(atom_getlong(in2)))
			return true;
	}
	else if((in1[0].a_type == A_FLOAT) && (in2[0].a_type == A_FLOAT)){
		if((atom_getfloat(in1))==(atom_getfloat(in2)))
		//if(in1[0].a_w.w_float == in2[0].a_w.w_float)
			return true;
	}
	else if((in1[0].a_type == A_SYM) && (in2[0].a_type == A_SYM)){
		if((atom_getsym(in1))==(atom_getsym(in2)))
		//if(in1[0].a_w.w_sym == in2[0].a_w.w_sym)
			return true;
	}
	return false;
}

