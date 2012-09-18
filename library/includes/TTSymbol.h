/* 
 * TTBlue Class for representing Symbols
 * Copyright © 2008, Timothy Place
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __TT_SYMBOL_H__
#define __TT_SYMBOL_H__

#include "TTBase.h"
#include "TTString.h"

/****************************************************************************************************/
// Class Specification

/**
	The TTSymbol class is used to represent a string and efficiently pass and compare that string.
	At the moment the implementation is somewhat crude and really slow and it should be improved in the future.
 
	Note that generally speaking you should not directly create a TTSymbol!
	Instead, TTSymbol objects should only by created by the TTSymbolTable that you are using.  
	Because of this we *always* pass TTSymbols as references (#TTSymbolRef) into the symbol table rather than as pointers or copies.
 
	Also, if you don't need the fast lookup capabilities of the symbol table (such as for message or attribute lookup)
	then consider passing a #TTString instead.
*/
class TTFOUNDATION_EXPORT TTSymbol : public TTBase {
protected:


	const TTPtrSizedInt	mSymbolTableId;		///< a unique identifier for the symbol table that owns this symbol
	const TTUInt32		mSymbolId;			///< a unique identifier for the given string
	const TTString		mString;			///< the actual string represented by this symbol


	/** used by the constructors to create the new symbol */
	//void init(const TTString& newString, TTPtrSizedInt newSymbolTableId, TTInt32 newId);
	void init(const TTString& newString, TTPtrSizedInt newSymbolTableId, TTInt32 newSymbolId);

	
public:
		
	/** The constructor is intended only for use by the TTSymbolTable object when creating new symbols
		in the table.  Perhaps this could be made private and then the class made a friend... */
	TTSymbol(const TTString& newString, TTPtrSizedInt newSymbolTableId, TTInt32 newSymbolId);

	
	virtual	~TTSymbol();
	
	
	/** Copy Constructor */
	TTSymbol(const TTSymbol& oldSymbol);
	
	
	/**	Return a pointer to the internal string as a C-string. */
	const char* getCString() const
	{
		return mString.c_str();
	}
	
	
	const TTString& string() const
	{
		return mString;
	}
	
	
	/**	Return this symbol's unique id. */
	/*const*/ TTUInt32 getSymbolId() const
	{
		return mSymbolId;
	}
	
	
	/** Compare two symbols for equality. */
	inline friend bool operator == (const TTSymbol& symbol1, const TTSymbol& symbol2)
	{
		if (symbol1.mSymbolTableId == symbol2.mSymbolTableId) {
			// both symbols are in the same symbol table 
			// this should typically be the case and we optimize for this	
			return (symbol1.mSymbolId == symbol2.mSymbolId);
		}
		else {
			// hopefully this won't happen, but it could if there are libs statically linked and communicate with each other
			return (symbol1.mString == symbol2.mString);
		}
	}
	
	
	/** Cast a symbol to a C-string. */
	operator const char*() const
	{
		return mString.c_str();
	}

	
	/** Cast a symbol to a TTStringRef. */
	operator const TTString&() const
	{
		return mString;
	}

	
	/** Generate a pseudo-random symbol */
	static TTSymbol& random();

};


/**	A reference to a symbol.  This is the way symbols are typically communicated throughout the environment. */
typedef TTSymbol& TTSymbolRef;


#endif // __TT_SYMBOL_H__
