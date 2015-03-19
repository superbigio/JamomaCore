/** @file TTLimits.h
 *
 * @ingroup foundationLibrary
 *
 * @brief Limiting and Constraining Utilities

 * @details Defines several functions for constraining values within specified boundaries and preventing unwanted values. A variety of behaviors are offered, including clipping, wrapping and folding. Functions for handling <a href="http://en.wikipedia.org/wiki/Denormal_number">denormal values</a> are also defined. @n@n
 * Exercise caution when using the functions defined here with unsigned values. Negative, signed integers have the potential to become very large numbers when casting to unsigned integers. This can cause errors during a boundary check, such as values clipping to the high boundary instead of the low boundary or numerous iterations of loop to bring a wrapped value back into the acceptable range.
 * 
 * @author Timothy Place & Tristan Matthews
 *
 * @copyright Copyright © 2009, Timothy Place & Tristan Matthews @n
 * This code is licensed under the terms of the "New BSD License" @n
 * http://creativecommons.org/licenses/BSD/
 */

#pragma once

#include <limits>
#include <cmath>


/** Filter out denormaled values, which can make processing extremely slow when present.  
	Calculation is performed in-place.
 
	When SSE3 is available, then we rely on the denormals being turned-off using a bit in the processor's control register
	http://software.intel.com/sites/products/documentation/studio/composer/en-us/2011/compiler_c/fpops/common/fpops_set_ftz_daz.htm

	Otherwise you need to define the preprocessor macro TT_ZERO_DENORMALS for manual denormal suppression.
	See #56.
 
	@seealso	TTAntiDenormal
 */
template<class T>
static void TTZeroDenormal(T& value)
{
#ifdef TT_ZERO_DENORMALS
	if (!std::isnormal(value))
		value = 0;
#endif
}


/** @fn T TTAntiDenormal(const T input)
 @memberof TTLimits.h
 @brief Filter out denormaled values, which can make processing extremely slow when present.
 @seealso	TTZeroDenormal
 */
template<class T>
static T TTAntiDenormal(const T input)
{
	T output = input;
	TTZeroDenormal(output);
	return output;
}


/** Constrain a number to within a range.  Calculation is performed in-place.
	@seealso	TTClip()
 */
template<class T>
static void TTLimit(T& value, const T lowBound, const T highBound)
{
	if (value < lowBound)
		value = lowBound;
	else if (value > highBound)
		value = highBound;
}


/** Constrain a number to within a range.
 @seealso	TTLimit()
 */
template<class T>
static T TTClip(const T input, const T lowBound, const T highBound)
{
	T output = input;
	TTLimit(output, lowBound, highBound);
	return output;
}


/** A fast routine for clipping a number to a maximum range.  The bottom end of the range is not checked.  This routine does not use branching. */
template<class T>
static void TTLimitMax(T& value, const T highBound)
{
	if (value > highBound)
		value = highBound;
}


/** A fast routine for clipping a number on it's low range.  The high end of the range is not checked.
	This routine does not use branching. */
template<class T>
static void TTLimitMin(T& value, const T lowBound)
{
	if (value < lowBound)
		value = lowBound;
}


/**	Limit input to power-of-two values.
	Non-power-of-two values are increased to the next-highest power-of-two upon return.
	Only works for ints up to 32-bits.
	@seealso http://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
 */
template<class T>
static void TTLimitPowerOfTwo(T& value)
{
	value--;
	value |= value >> 1;
	value |= value >> 2;
	value |= value >> 4;
	value |= value >> 8;
	value |= value >> 16;
	value++;
}


/**	Determine id a value is a power-of-two. Only works for ints. */
template<class T>
static TTBoolean TTIsPowerOfTwo(T value)
{
	return (value > 0) && ((value & (value-1)) == 0);
}


/** A fast routine for wrapping around the range once.  This is faster than doing an expensive module, where you know the range of the input
 	will not equal or exceed twice the range. */
template<class T>
static T TTOneWrap(T value, T low_bound, T high_bound)
{
	if ((value >= low_bound) && (value < high_bound))
		return value;
	else if (value >= high_bound)
		return((low_bound - 1) + (value - high_bound));
	else
		return((high_bound + 1) - (low_bound - value));
}
/** this routine wrapping around the range as much as necessary, Nils Peters, Nov. 2008 */
template<class T>
static T TTInfWrap(T value, T low_bound, T high_bound)
{
	if ((value >= low_bound) && (value < high_bound))
		return value; //nothing to wrap
	/* let's wrap it */
	else if (value - low_bound >= 0)
		return(fmod((double)value  - low_bound, fabs((double)low_bound - high_bound)) + low_bound);
	else
		return(-1.0 * fmod(-1.0 * (value  - low_bound), fabs((double)low_bound - high_bound)) + high_bound);
}

/** this routine folds numbers into the data range, Nils Peters, Nov. 2008 */
template<class T>
static T TTFold(T value, T low_bound, T high_bound)
{
	double foldRange;

	if ((value >= low_bound) && (value <= high_bound))
		return value; //nothing to fold
	else {
		foldRange = 2 * fabs((double)low_bound - high_bound);
		return fabs(remainder(value - low_bound, foldRange)) + low_bound;
	}
}



/** A utility for scaling one range of values onto another range of values. */
template<class T>
static T TTScale(T value, T inlow, T inhigh, T outlow, T outhigh)
{
	double inscale, outdiff;

	inscale = 1 / (inhigh - inlow);
	outdiff = outhigh - outlow;

	value = (value - inlow) * inscale;
	value = (value * outdiff) + outlow;
	return(value);
}

/** Rounding utility. */
template<class T>
static TTInt32 TTRound(T value)
{
	if (value > 0)
		return((TTInt32)(value + 0.5));
	else
		return((TTInt32)(value - 0.5));
}


template <class T>
static T limitMin(T value, T low_bound)
{
    value -= low_bound;
#ifdef TT_PLATFORM_MAC
    value += fabs(value);
#else
    value = T(value + fabs((double)value));
#endif
    value = T(value * 0.5);
    value = T(value + low_bound);
    return value;
}

// template specialization for the unsigned case in limitMin, as per http://redmine.jamoma.org/issues/show/300
// otherwise the algorithm can wrap around (below zero) and produce unexpected results

template <class T>
static TTUInt8 limitMin(TTUInt8 value, TTUInt8 low_bound)
{
    value -= std::min(low_bound, value); // so 0 at lowest
#ifdef TT_PLATFORM_MAC
    value += fabs(value);
#else
    value = TTUInt8(value + fabs((double)value));
#endif
    value = TTUInt8(value * 0.5);
    value = TTUInt8(value + low_bound);
    return value;
}

template <class T>
static TTUInt16 limitMin(TTUInt16 value, TTUInt16 low_bound)
{
    value -= std::min(low_bound, value); // so 0 at lowest
#ifdef TT_PLATFORM_MAC
    value += fabs(value);
#else
    value = TTUInt16(value + fabs((double)value));
#endif
    value = TTUInt16(value * 0.5);
    value = TTUInt16(value + low_bound);
    return value;
}

template <class T>
static TTUInt32 limitMin(TTUInt32 value, TTUInt32 low_bound)
{
    value -= std::min(low_bound, value); // so 0 at lowest
#ifdef TT_PLATFORM_MAC
    value += fabs(value);
#else
    value = TTUInt32(value + fabs((double)value));
#endif
 value = TTUInt32(value * 0.5);
 value = TTUInt32(value + low_bound);
 return value;
}


template <class T>
static TTUInt64 limitMin(TTUInt64 value, TTUInt64 low_bound)
{
	value -= std::min(low_bound, value); // so 0 at lowest
#ifdef TT_PLATFORM_MAC
	value += fabs(value);
#else
  value = TTUInt64(value + fabs((double)value));
#endif
	value = TTUInt64(value * 0.5);
	value = TTUInt64(value + low_bound);
	return value;
}


