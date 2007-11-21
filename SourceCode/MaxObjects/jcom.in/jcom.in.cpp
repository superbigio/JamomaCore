/* 
 * jcom.in~
 * External for Jamoma: manage audio inputs for a module
 * By Tim Place, Copyright � 2006
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */


/*
	The user specifies @channel_config mono or @channel_config stereo 
	as arg to the module.  That makes the hub responsible for cleaning
	up any unused inlets and outlets for the configuration.  
	
	It may also signal to the module to handle the poly differently,
	i.e. if the algorithm should be true stereo instead of multi-mono
	
	This all means that we need this object to subscribe to the hub.
*/

#include "Jamoma.h"
#include "jcom.in.h"

// Globals
t_class		*in_class;					// Required. Global pointing to this class
t_atom		ga_zero;


/************************************************************************************/
// Main() Function

int main(void)				// main recieves a copy of the Max function macros table
{
	long 		attrflags = 0;
	t_class 	*c;
	t_object 	*attr;
	long		offset;
	
	jamoma_init();

	// Define our class
#ifdef JCOM_IN_TILDE
	c = class_new("jcom.in~",(method)in_new, (method)in_free, (short)sizeof(t_in), (method)0L, A_GIMME, 0);
#else
	c = class_new("jcom.in",(method)in_new, (method)in_free, (short)sizeof(t_in), (method)0L, A_GIMME, 0);
#endif

	offset = calcoffset(t_in, common);
	class_obexoffset_set(c, offset + calcoffset(t_jcom_core_subscriber_common, obex));

	// Make methods accessible for our class: 
	class_addmethod(c, (method)in_dispatched,			"dispatched",			A_GIMME, 0L);
	class_addmethod(c, (method)in_algorithm_message,	"algorithm_message",	A_GIMME, 0L);
	class_addmethod(c, (method)in_view_internals,		"open",					A_GIMME, 0L);	// method used to view algorithm
	class_addmethod(c, (method)in_link,					"link_out",				A_CANT, 0L);	// maybe used to forward messages in jmod.in
	class_addmethod(c, (method)in_unlink,				"unlink_out",			0L);
#ifdef JCOM_IN_TILDE
	class_addmethod(c, (method)in_dsp,					"dsp", 					A_GIMME, 0L);
	class_addmethod(c, (method)in_remoteaudio,			"remoteaudio",			A_CANT, 0);
#else
	class_addmethod(c, (method)in_bang,					"bang", 				0L);
	class_addmethod(c, (method)in_int,					"int", 					A_LONG, 0L);
	class_addmethod(c, (method)in_float,				"float", 				A_FLOAT, 0L);
	class_addmethod(c, (method)in_anything,				"list", 				A_GIMME, 0L);
	class_addmethod(c, (method)in_anything,				"anything",				A_GIMME, 0L);	
#endif
	class_addmethod(c, (method)in_release,				"release",				A_CANT, 0L);	// notification of hub being freed
    class_addmethod(c, (method)in_assist,				"assist", 				A_CANT, 0L);

	jcom_core_subscriber_classinit_common(c, attr, offset);	
	
	// ATTRIBUTE: algorithm_type
	attr = attr_offset_new("algorithm_type", _sym_symbol, attrflags,
		(method)0, (method)0, calcoffset(t_in, attr_algorithm_type));
	class_addattr(c, attr);
	
	// ATTRIBUTE: num_inputs
	attr = attr_offset_new("num_inputs", _sym_long, attrflags,
		(method)0, (method)0, calcoffset(t_in, num_inputs));
	class_addattr(c, attr);	

#ifdef JCOM_IN_TILDE
//	// ATTRIBUTE: manage_channels
//	attr = attr_offset_new("manage_channels", _sym_long, attrflags,
//		(method)0, (method)0, calcoffset(t_in, attr_manage_channels));
//	class_addattr(c, attr);
	
	// Setup our class to work with MSP
	class_dspinit(c);
#endif

	// Finalize our class
	class_register(CLASS_BOX, c);
	in_class = c;

	jcom_core_init();
	atom_setlong(&ga_zero, 0);
	return 0;
}


/************************************************************************************/
// Object Life

// Create
void *in_new(t_symbol *s, long argc, t_atom *argv)
{
	long 		attrstart = attr_args_offset(argc, argv);		// support normal arguments
	t_in 		*x = (t_in *)object_alloc(in_class);
	short 		i;
		
	if(x){
		x->dumpout = outlet_new(x, NULL);
		x->algout = outlet_new(x, NULL);
		
		object_obex_store((void *)x, ps_dumpout, (object *)x->dumpout);		// setup the dumpout

		x->num_inputs = 0;
		x->attr_algorithm_type = _sym_nothing;
		x->attr_bypass = 0;
		x->attr_mute = 0;
		x->attr_freeze = 0;
		x->vector_size = 0;  // reset cached vector size

		if(attrstart > 0){
			int argument = atom_getlong(argv);
			x->num_inputs = tt_audio_base::clip(argument, 0, MAX_NUM_CHANNELS);
		} 
		else
			x->outlet[0] = x->algout;  // no arguments send any input out the first outlet

#ifdef JCOM_IN_TILDE
		if(x->num_inputs > 0)
			dsp_setup((t_pxobject *)x, x->num_inputs);		// Create Object and Inlets
		else
			dsp_setup((t_pxobject *)x, 1);					// Create Object and Inlet

		x->common.ob.z_misc = Z_NO_INPLACE | Z_PUT_FIRST;
		
		for(i=0; i < (x->num_inputs); i++)
			outlet_new((t_pxobject *)x, "signal");			// Create a signal outlet   		
		for(i=0; i < MAX_NUM_CHANNELS; i++)
			x->signal_in[i] = new tt_audio_signal;			// Storage for the signal (accessed by jcom.out~)
		in_alloc(x, sys_getblksize());						// allocates the vectors for the audio signals
#else
		for(i = x->num_inputs-1; i >= 1; i--)
			x->inlet[i] = proxy_new(x, i, 0L);
		for(i = x->num_inputs-1; i >= 0; i--)
			x->outlet[i] = outlet_new(x, 0L);

#endif
		jcom_core_subscriber_new_common(&x->common, ps__jcom_in__, ps_subscribe_in);
		jcom_core_subscriber_setcustomsubscribe_method(&x->common, &in_subscribe);
		attr_args_process(x, argc, argv);					// handle attribute args				
		defer_low(x, (method)jcom_core_subscriber_subscribe, 0, 0, 0);
	}
	return (x);												// Return the pointer
}


// deferred function for registering with the jcom.hub object
void in_subscribe(void *z)
{
	long		argc;
	t_atom		a;
	t_atom		*argv = &a;
	t_symbol	*result;
	t_symbol	*modtype;
	t_in		*x = (t_in *)z;
	
	//x->common.hub = jcom_core_subscribe(x, x->common.attr_name, x->common.container, ps_subscribe_in);
	if(x->common.hub != NULL){
		//object_attr_getvalueof(x->common.hub, ps_name, &argc, &argv);
		//x->common.module_name = atom_getsym(argv);
		
		// Find out what type of algorithm this is supposed to control
		object_attr_getvalueof(x->common.hub, ps_algorithm_type, &argc, &argv);
		result = atom_getsym(argv);
		if(result == ps_default){
			object_attr_getvalueof(x->common.hub, ps_module_type, &argc, &argv);
			modtype = atom_getsym(argv);
			
			if(modtype == ps_audio)
				x->attr_algorithm_type = ps_poly;
			else if(modtype == ps_video)
				x->attr_algorithm_type = ps_jitter;
			else
				x->attr_algorithm_type = ps_control;
		}
		else
			x->attr_algorithm_type = result;
	}
}


// Destroy
void in_free(t_in *x)
{
#ifdef JCOM_IN_TILDE
	short i;
	
	dsp_free((t_pxobject *)x);			// Always call dsp_free first in this routine
	for(i=0; i < MAX_NUM_CHANNELS; i++)
		delete x->signal_in[i];
#endif
	jcom_core_subscriber_common_free(&x->common);
}


// Notification that the hub no longer exists
void in_release(t_in *x)
{
	jcom_core_subscriber_hubrelease(&x->common);
	x->out_object = NULL;
}


/************************************************************************************/
// Methods bound to input/inlets

// Method for Assistance Messages
void in_assist(t_in *x, void *b, long msg, long arg, char *dst)
{
	if(msg==1) 	// Inlets
		strcpy(dst, "(signal) input to the module");
	else if(msg==2){ // Outlets
		if(arg < x->num_inputs) 
			strcpy(dst, "(signal) connect to the algorithm");
		else if(arg == x->num_inputs) 
			strcpy(dst, "connect to algorithm");
		else 
			strcpy(dst, "dumpout");
	}
}


// messages received from jcom.hub for the algorithm
void in_algorithm_message(t_in *x, t_symbol *msg, long argc, t_atom *argv)
{
	char		namestring[256];
	t_symbol	*osc;

	if((argv->a_w.w_sym == ps_audio_mute) || (argv->a_w.w_sym == ps_slash_audio_mute)){
		x->attr_mute = atom_getlong(argv+1);
		outlet_anything(x->algout, ps_mute, argc-1, argv+1);
	}
	else if((argv->a_w.w_sym == ps_video_mute) || (argv->a_w.w_sym == ps_slash_video_mute))
		x->attr_mute = atom_getlong(argv+1);
	else if((argv->a_w.w_sym == ps_video_bypass) || (argv->a_w.w_sym == ps_slash_video_bypass))
		x->attr_bypass = atom_getlong(argv+1);
	else if((argv->a_w.w_sym == ps_video_freeze) || (argv->a_w.w_sym == ps_slash_video_freeze))
		x->attr_freeze = atom_getlong(argv+1);
	
	strcpy(namestring, "/");						// perhaps we could optimize this operation
	strcat(namestring, argv->a_w.w_sym->s_name);	//	by creating a table when the param is bound
	osc = gensym(namestring);						//	then we could look-up the symbol instead of using gensym()

	outlet_anything(x->algout, osc, argc-1, argv+1);
}


void in_view_internals(t_in *x, t_symbol *msg, long argc, t_atom *argv)
{
	outlet_anything(x->algout, ps_open, 0, 0L);
}


// messages received from jcom.hub for various reasons
void in_dispatched(t_in *x, t_symbol *msg, long argc, t_atom *argv)
{
	;
}


// set pointer to the out object so we can forward messages to it 
void in_link(t_in *x, t_object *y)
{
	x->out_object = y;
}


void in_unlink(t_in *x)
{
	x->out_object = NULL;
}




void in_bang(t_in *x)
{
	if(x->attr_mute)
		;
	else if(x->attr_freeze)
		object_method(x->out_object, ps_sendlastvalue);
	else if(x->attr_bypass)
		object_method(x->out_object, ps_sendbypassedvalue, proxy_getinlet((t_object *)x), _sym_bang, 0, NULL);
	else
		outlet_bang(x->outlet[proxy_getinlet((t_object *)x)]);
}


void in_int(t_in *x, long value)
{
	if(x->attr_mute)
		;
	else if(x->attr_freeze)
		object_method(x->out_object, ps_sendlastvalue);
	else if(x->attr_bypass){
		t_atom a;
		atom_setlong(&a, value);
		object_method(x->out_object, ps_sendbypassedvalue, proxy_getinlet((t_object *)x), _sym_int, 1, &a);
	}
	else
		outlet_int(x->outlet[proxy_getinlet((t_object *)x)], value);
}


void in_float(t_in *x, double value)
{
	if(x->attr_mute)
		;
	else if(x->attr_freeze)
		object_method(x->out_object, ps_sendlastvalue);
	else if(x->attr_bypass){
		t_atom a;
		atom_setfloat(&a, value);
		object_method(x->out_object, ps_sendbypassedvalue, proxy_getinlet((t_object *)x), _sym_float, 1, &a);
	}
	else
		outlet_float(x->outlet[proxy_getinlet((t_object *)x)], value);
}


void in_anything(t_in *x, t_symbol *msg, long argc, t_atom *argv)
{
	if(x->attr_mute)
		;
	else if(x->attr_freeze)
		object_method(x->out_object, ps_sendlastvalue);
	else if(x->attr_bypass)
		object_method(x->out_object, ps_sendbypassedvalue, proxy_getinlet((t_object *)x), msg, argc, argv);
	else
		outlet_anything(x->outlet[proxy_getinlet((t_object *)x)], msg, argc, argv);
}


// Perform Method - just pass the whole vector straight through
// (the work is all done in the dsp method)
t_int *in_perform(t_int *w)
{
  	t_in 	*x 		= (t_in *)(w[1]);		// Instance
	short	i		= (short)(w[2]);		// Channel Number
	t_float *in 	= (t_float *)(w[3]);	// Input
	t_float *out 	= (t_float *)(w[4]);	// Output
	long	n		= (long)(w[5]);			// vectorsize 
	short	j		= 0;

	while(n--){
		x->signal_in[i]->vector[j] = *in;
		*out++ = *in++;
		j++;
	}
	return(w+6);
}


t_int *in_perform_zero(t_int *w)
{
  	t_in 	*x 		= (t_in *)(w[1]);		// Instance
	short	i		= (short)(w[2]);		// Channel Number
  	t_float *out 	= (t_float *)(w[3]);	// Output
	long	n		= (long)(w[4]);			// vectorsize
	short	j		= 0;

	while(n--){
		x->signal_in[i]->vector[j] = 0;	
		*out++ = 0;
		j++;
	}
	return(w+5);
}


// TODO: We are not guaranteed that this will be called after in_perform, right?
// If that is so then our mixing is bogus, and perform needs to perform mixing too...
void in_remoteaudio(t_in *x, float *audioVectors[], long numAudioVectors)
{
	short	i, j;
	float	*vector;
	long	n;
	
	for(i=0; i<numAudioVectors; i++){
		vector = audioVectors[i];
		n = x->vector_size;
		j = 0;
		
		while(n--){
			x->signal_in[i]->vector[j] += *vector++;
			j++;
		}
	}
}


// DSP Method
void in_dsp(t_in *x, t_signal **sp, short *count)
{
	short 	i;
	int 	vs = sp[0]->s_n;			// Vector Size

	in_alloc(x, vs);	

	for(i=0; i < x->num_inputs; i++){	//take a look at each
		if(count[i]){
			dsp_add(in_perform, 5, x, i, sp[i]->s_vec, sp[x->num_inputs + i]->s_vec, sp[i]->s_n);
		}
		else
			dsp_add(in_perform_zero, 4, x, i, sp[x->num_inputs + i]->s_vec, sp[i]->s_n);
	}
}


void in_alloc(t_in *x, int vector_size)
{
	short i;
	
	if(vector_size != x->vector_size) {
		x->vector_size = vector_size;
		for(i=0; i < MAX_NUM_CHANNELS; i++) {
			x->signal_in[i]->alloc(vector_size);
		}
	}
}


