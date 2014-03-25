/** @file
 *
 * @ingroup dspLibrary
 *
 * @brief Container for an array of #TTAudioSignal pointers.
 *
 * @details TODO: put more info here
 *
 * @see TTAudioSignal
 *
 * @authors Tim Place
 *
 * @copyright Copyright © 2008 by Timothy Place @n
 * This code is licensed under the terms of the "New BSD License" @n
 * http://creativecommons.org/licenses/BSD/
 */

#include "TTDSP.h"

#define thisTTClass			TTAudioSignalArray
#define thisTTClassName		"audiosignalarray"
#define thisTTClassTags		"dspLibrary, audio, processor, dynamics, envelope"


/****************************************************************************************************/

TT_OBJECT_CONSTRUCTOR, 
	mAudioSignals(NULL),
	mAudioSignalMaxCount(0),
	numAudioSignals(0)
{
	TTUInt16 initialMaxNumAudioSignals = arguments;
	
	// TT_ASSERT(audio_signal_array_has_valid arg, initialMaxNumAudioSignals > 0);
	// Can't assert because, for example, an audio graph can have objects with no inlets
	// So we just enforce a lower-limit of 1:

	if (initialMaxNumAudioSignals < 1)
		initialMaxNumAudioSignals = 1;
	setMaxNumAudioSignals(initialMaxNumAudioSignals);
	numAudioSignals = initialMaxNumAudioSignals;
}


TTAudioSignalArray::~TTAudioSignalArray()
{
	chuck();
}


void TTAudioSignalArray::chuck()
{
	for (TTUInt16 i=0; i<mAudioSignalMaxCount ;i++) {
		if (mAudioSignals[i])
			ttEnvironment->releaseInstance((TTObjectBase**)&mAudioSignals[i]);
	}
	delete[] mAudioSignals;
}


void TTAudioSignalArray::init()
{
	mAudioSignals = new TTAudioSignalPtr[mAudioSignalMaxCount];
	for (TTUInt16 i=0; i<mAudioSignalMaxCount ;i++)
		mAudioSignals[i] = NULL;
	numAudioSignals = 0;
}


void TTAudioSignalArray::releaseAll()
{
	for (TTUInt16 i=0; i<mAudioSignalMaxCount; i++)
		TTObjectBaseRelease(&mAudioSignals[i]);
}

void TTAudioSignalArray::allocAllWithVectorSize(TTUInt16 vs)
{
	for (TTUInt16 i=0; i<mAudioSignalMaxCount; i++)
		mAudioSignals[i]->allocWithVectorSize(vs);
}

TTUInt16 TTAudioSignalArray::getVectorSize()
{
	return mAudioSignals[0]->getVectorSizeAsInt();
}

void TTAudioSignalArray::setAllMaxNumChannels(TTUInt16 newMaxNumChannels)
{
	for (TTUInt16 i=0; i<mAudioSignalMaxCount; i++)
		mAudioSignals[i]->setMaxNumChannels(newMaxNumChannels);
}

void TTAudioSignalArray::setAllNumChannels(TTUInt16 newNumChannels)
{
	for (TTUInt16 i=0; i<mAudioSignalMaxCount; i++)
		mAudioSignals[i]->setNumChannels(newNumChannels);
}

