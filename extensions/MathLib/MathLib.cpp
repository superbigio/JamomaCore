/* 
 * MathLib
 * Extension Class for Jamoma DSP
 * Copyright © 2009, Timothy Place
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#include "TTDSP.h"
#include "TTOperator.h"
#include "TTMatrix.h"
#include "TTMatrixMixer.h"


extern "C" TT_EXTENSION_EXPORT TTErr loadTTExtension(void)
{
	TTDSPInit();

	TTOperator::registerClass();
	TTMatrix::registerClass();	
	TTMatrixMixer::registerClass();	
	
	return kTTErrNone;
}

