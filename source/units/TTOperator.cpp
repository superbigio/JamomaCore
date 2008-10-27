/* 
 * TTBlue Operator Object
 * Copyright © 2008, Timothy Place
 * 
 * License: This code is licensed under the terms of the GNU LGPL
 * http://www.gnu.org/licenses/lgpl.html 
 */

#include "TTOperator.h"
#define thisTTClass TTOperator


TTOperator::TTOperator(TTUInt16 newMaxNumChannels)
	: TTAudioObject("audio.operator", newMaxNumChannels)
{
	registerAttribute(TT("operator"), kTypeSymbol, &operatorAttribute, (TTSetterMethod)&TTOperator::setoperator);
	registerAttributeWithSetter(operand, kTypeFloat64);
	
	// Set Defaults...
	setAttributeValue(TT("operator"),	TT("+"));
	setAttributeValue(TT("operand"),	1.0);
}


TTOperator::~TTOperator()
{
	;
}


TTErr TTOperator::setoperator(const TTValue& newValue)
{
	operatorAttribute = newValue;
	if(operatorAttribute == TT("+")){
		setProcess((TTProcessMethod)&TTOperator::processAddConstant);
		setProcessWithSidechain((TTProcessWithSidechainMethod)&TTOperator::processAddSignal);
	}
	else if(operatorAttribute == TT("-")){
		setProcess((TTProcessMethod)&TTOperator::processSubtractConstant);
		setProcessWithSidechain((TTProcessWithSidechainMethod)&TTOperator::processSubtractSignal);
	}
	else if(operatorAttribute == TT("*")){
		setProcess((TTProcessMethod)&TTOperator::processMultiplyConstant);
		setProcessWithSidechain((TTProcessWithSidechainMethod)&TTOperator::processMultiplySignal);
	}
	else if(operatorAttribute == TT("/")){
		setProcess((TTProcessMethod)&TTOperator::processDivideConstant);
		setProcessWithSidechain((TTProcessWithSidechainMethod)&TTOperator::processDivideSignal);
	}
	else if(operatorAttribute == TT("%")){
		setProcess((TTProcessMethod)&TTOperator::processModuloConstant);
		setProcessWithSidechain((TTProcessWithSidechainMethod)&TTOperator::processModuloSignal);
	}
	else
		return kTTErrInvalidValue;
	
	return kTTErrNone;
}


TTErr TTOperator::setoperand(const TTValue& newValue)
{	
	TTInt64		i;
	TTUInt32	count;
	
	operand = newValue;
	operandIsPowerOfTwo = false;
	
	i = (TTInt64)operand;
	if(i - operand)
		operandIsInteger = false;
	else
		operandIsInteger = true;
	
	if(operandIsInteger){
		for(count = 0; i != 0; count++)
			i &= i-1;
		if(count == 1)
			operandIsPowerOfTwo = true;		
	}
	return kTTErrNone;
}



TTErr TTOperator::processAddConstant(TTAudioSignal& in, TTAudioSignal& out)
{
	TTUInt16		vs;
	TTSampleValue	*inSample,
					*outSample;
	TTUInt16		numchannels = TTAudioSignal::getMinChannelCount(in, out);
	TTUInt16		channel;

	for(channel=0; channel<numchannels; channel++){
		inSample = in.sampleVectors[channel];
		outSample = out.sampleVectors[channel];
		vs = in.getVectorSize();
		while(vs--)
			*outSample++ = *inSample++ + operand;
	}
	return kTTErrNone;
}


TTErr TTOperator::processSubtractConstant(TTAudioSignal& in, TTAudioSignal& out)
{
	TTUInt16		vs;
	TTSampleValue	*inSample,
					*outSample;
	TTUInt16		numchannels = TTAudioSignal::getMinChannelCount(in, out);
	TTUInt16		channel;

	for(channel=0; channel<numchannels; channel++){
		inSample = in.sampleVectors[channel];
		outSample = out.sampleVectors[channel];
		vs = in.getVectorSize();
		while(vs--)
			*outSample++ = *inSample++ - operand;
	}
	return kTTErrNone;
}


TTErr TTOperator::processMultiplyConstant(TTAudioSignal& in, TTAudioSignal& out)
{
	TTUInt16		vs;
	TTSampleValue	*inSample,
					*outSample;
	TTUInt16		numchannels = TTAudioSignal::getMinChannelCount(in, out);
	TTUInt16		channel;

	for(channel=0; channel<numchannels; channel++){
		inSample = in.sampleVectors[channel];
		outSample = out.sampleVectors[channel];
		vs = in.getVectorSize();
		while(vs--)
			*outSample++ = *inSample++ * operand;
	}
	return kTTErrNone;
}


TTErr TTOperator::processDivideConstant(TTAudioSignal& in, TTAudioSignal& out)
{
	TTUInt16		vs;
	TTSampleValue	*inSample,
					*outSample;
	TTUInt16		numchannels = TTAudioSignal::getMinChannelCount(in, out);
	TTUInt16		channel;

	for(channel=0; channel<numchannels; channel++){
		inSample = in.sampleVectors[channel];
		outSample = out.sampleVectors[channel];
		vs = in.getVectorSize();
		while(vs--)
			*outSample++ = *inSample++ / operand;
	}
	return kTTErrNone;
}


TTErr TTOperator::processModuloConstant(TTAudioSignal& in, TTAudioSignal& out)
{
	TTUInt16		vs;
	TTSampleValue*	inSample;
	TTSampleValue*	outSample;
	TTUInt16		numchannels = TTAudioSignal::getMinChannelCount(in, out);
	TTUInt16		channel;
	TTUInt64		temp;
	TTUInt64		operander = (TTUInt64)operand;
	
	for(channel=0; channel<numchannels; channel++){
		inSample = in.sampleVectors[channel];
		outSample = out.sampleVectors[channel];
		vs = in.getVectorSize();
		
		if(operandIsPowerOfTwo){
			while(vs--){
				temp = TTUInt64(*inSample++);
				*outSample++ = TTSampleValue(temp & operander);
			}
		}
		else{
			while(vs--)
				*outSample++ = fmod(*inSample++, operander);		
		}
	}
	return kTTErrNone;
}




TTErr TTOperator::processAddSignal(TTAudioSignal& in1, TTAudioSignal& in2, TTAudioSignal& out, TTAudioSignal&)
{
	TTUInt16		vs;
	TTSampleValue	*in1Sample,
					*in2Sample,
					*outSample;
	TTUInt16		numChannels;
	TTUInt16		channel;

	if(in2.getNumChannels() == 1){				// If the operand signal is one only channel, then we apply that to all channels of in1
		numChannels = in2.getNumChannels();
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[0];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ + *in2Sample++;
		}		
	}
	else{										// Otherwise we apply channel 1 to channel 1, channel 2 to channel 2, etc.
		numChannels = TTAudioSignal::getMinChannelCount(in1, out);
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[channel];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ + *in2Sample++;
		}
	}
	return kTTErrNone;
}


TTErr TTOperator::processSubtractSignal(TTAudioSignal& in1, TTAudioSignal& in2, TTAudioSignal& out, TTAudioSignal&)
{
	TTUInt16		vs;
	TTSampleValue	*in1Sample,
					*in2Sample,
					*outSample;
	TTUInt16		numChannels;
	TTUInt16		channel;

	if(in2.getNumChannels() == 1){				// If the operand signal is one only channel, then we apply that to all channels of in1
		numChannels = in2.getNumChannels();
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[0];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ - *in2Sample++;
		}		
	}
	else{										// Otherwise we apply channel 1 to channel 1, channel 2 to channel 2, etc.
		numChannels = TTAudioSignal::getMinChannelCount(in1, out);
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[channel];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ - *in2Sample++;
		}
	}
	return kTTErrNone;
}


TTErr TTOperator::processMultiplySignal(TTAudioSignal& in1, TTAudioSignal& in2, TTAudioSignal& out, TTAudioSignal&)
{
	TTUInt16		vs;
	TTSampleValue	*in1Sample,
					*in2Sample,
					*outSample;
	TTUInt16		numChannels;
	TTUInt16		channel;

	if(in2.getNumChannels() == 1){				// If the operand signal is one only channel, then we apply that to all channels of in1
		numChannels = in2.getNumChannels();
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[0];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ * *in2Sample++;
		}		
	}
	else{										// Otherwise we apply channel 1 to channel 1, channel 2 to channel 2, etc.
		numChannels = TTAudioSignal::getMinChannelCount(in1, out);
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[channel];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ * *in2Sample++;
		}
	}
	return kTTErrNone;
}


TTErr TTOperator::processDivideSignal(TTAudioSignal& in1, TTAudioSignal& in2, TTAudioSignal& out, TTAudioSignal&)
{
	TTUInt16		vs;
	TTSampleValue	*in1Sample,
	*in2Sample,
	*outSample;
	TTUInt16		numChannels;
	TTUInt16		channel;
	
	if(in2.getNumChannels() == 1){				// If the operand signal is one only channel, then we apply that to all channels of in1
		numChannels = in2.getNumChannels();
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[0];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ / *in2Sample++;
		}		
	}
	else{										// Otherwise we apply channel 1 to channel 1, channel 2 to channel 2, etc.
		numChannels = TTAudioSignal::getMinChannelCount(in1, out);
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[channel];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			while(vs--)
				*outSample++ = *in1Sample++ / *in2Sample++;
		}
	}
	return kTTErrNone;
}


TTErr TTOperator::processModuloSignal(TTAudioSignal& in1, TTAudioSignal& in2, TTAudioSignal& out, TTAudioSignal&)
{
	TTUInt16		vs;
	TTSampleValue*	in1Sample;
	TTSampleValue*	in2Sample;
	TTSampleValue*	outSample;
	TTUInt16		numChannels;
	TTUInt16		channel;
	TTUInt64		temp;
	TTUInt64		intOperand;
	
	if(in2.getNumChannels() == 1){				// If the operand signal is one only channel, then we apply that to all channels of in1
		numChannels = in2.getNumChannels();
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[0];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();
			
			if(operandIsPowerOfTwo){
				while(vs--){
					temp = TTUInt64(*in1Sample++);
					intOperand = TTUInt64(*in2Sample++);
					*outSample++ = TTSampleValue(temp & intOperand);
				}
			}
			else{
				while(vs--)
					*outSample++ = fmod(*in1Sample++, *in2Sample++);		
			}
		}		
	}
	else{										// Otherwise we apply channel 1 to channel 1, channel 2 to channel 2, etc.
		numChannels = TTAudioSignal::getMinChannelCount(in1, out);
		for(channel=0; channel<numChannels; channel++){
			in1Sample = in1.sampleVectors[channel];
			in2Sample = in2.sampleVectors[channel];
			outSample = out.sampleVectors[channel];
			vs = in1.getVectorSize();

			if(operandIsPowerOfTwo){
				while(vs--){
					temp = TTUInt64(*in1Sample++);
					intOperand = TTUInt64(*in2Sample++);
					*outSample++ = TTSampleValue(temp & intOperand);
				}
			}
			else{
				while(vs--)
					*outSample++ = fmod(*in1Sample++, *in2Sample++);		
			}
		}
	}
	return kTTErrNone;
}



