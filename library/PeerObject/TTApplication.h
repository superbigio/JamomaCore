/* 
 * TTObject to handle application data structure
 * like a TTNodeDirectory and a hash tables of names
 *
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#ifndef __TT_APPLICATION_H__
#define __TT_APPLICATION_H__

#include "TTModular.h"
#include "Plugin.h"
#include "TTMirror.h"

/** TTApplication ... TODO : an explanation
 
 
 */
class TTApplication;
typedef TTApplication* TTApplicationPtr;

class TTApplicationManager;
typedef TTApplicationManager* TTApplicationManagerPtr;

class Plugin;
typedef Plugin* PluginPtr;

class TTMirror;
typedef TTMirror* TTMirrorPtr;

// Macro to have a direct acces to a directory
#define	getDirectoryFrom(anAddress) TTApplicationGetDirectory(anAddress)

// Macro to have a direct acces to the local application directory
#define	getLocalDirectory TTApplicationGetDirectory(kTTAdrsRoot)

// Macro to convert a TTValue with tt names inside into a value with local application names inside.
#define	ToAppNames(ttNames) \
		TTApplicationManagerGetApplication(kTTSym_localApplicationName)->sendMessage(kTTSym_ConvertToAppName, ttNames); \

// Macro to convert a TTValue with local application names inside into a value with tt names inside.
#define	ToTTNames(appNames) \
		TTApplicationManagerGetApplication(kTTSym_localApplicationName)->sendMessage(kTTSym_ConvertToTTName, appNames); \

// Macro to convert a local application TTSymbol into a tt name
#define	ToAppName(ttName) \
		TTApplicationConvertTTNameToAppName(ttName) \

// Macro to convert a tt name TTSymbol into a local application name
#define	ToTTName(appName) \
		TTApplicationConvertAppNameToTTName(appName) \
		

class TTMODULAR_EXPORT TTApplication : public TTDataObject
{
	TTCLASS_SETUP(TTApplication)

private:
	TTNodeDirectoryPtr			mDirectory;			///< ATTRIBUTE : the namespace directory of the application

	TTSymbolPtr					mName;				///< ATTRIBUTE : the name of the application
	TTSymbolPtr					mVersion;			///< ATTRIBUTE : the version of the application
	TTSymbolPtr					mNamespaceFile;		///< ATTRIBUTE : the namespace file to load (default : <empty>)
	
	TTValue						mPluginNames;		///< ATTRIBUTE : names of all plugins used by the application
	
	TTHashPtr					mDirectoryListenersCache;	///< a hash table containing all <address, Listener> for quick access
	TTHashPtr					mAttributeListenersCache;	///< a hash table containing all <address:attribute, Listener> for quick access
	
	TTHashPtr					mAppToTT;			///< Hash table to convert Application names into TT names
	TTValue						mAllAppNames;		///< All Application names
	TTHashPtr					mTTToApp;			///< Hash table to convert TT names into Application names
	TTValue						mAllTTNames;		///< All TT names
	
	TTNodeAddressPtr			mTempAddress;		///< a temporary address to parse opml file
	
	/** Set name of the application (and his directory) */
	TTErr setName(TTValue& value);
	
	/** Get all plugin names use by the application */
	TTErr getPluginNames(TTValue& value);
	
	/** Get all AppNames */
	TTErr getAllAppNames(TTValue& value);
	
	/** Get all AppNames */
	TTErr getAllTTNames(TTValue& value);
	
	/** Convert TTName into AppName */
	TTErr ConvertToAppName(TTValue& value);
	
	/** Convert AppName into TTName */
	TTErr ConvertToTTName(TTValue& value);
	
	/** Add Directory observer */
	TTErr AddDirectoryListener(const TTValue& value);
	
	/** Add Attribute observer */
	TTErr AddAttributeListener(const TTValue& value);
	
	/** Remove Directory observer */
	TTErr RemoveDirectoryListener(const TTValue& value);
	
	/** Remove Attribute observer */
	TTErr RemoveAttributeListener(const TTValue& value);
	
	/** Update Directory (usually for distant application) */
	TTErr UpdateDirectory(const TTValue& value);
	
	/** Update Attribute value (usually for Mirror objects) */
	TTErr UpdateAttribute(const TTValue& value);
	
	/** needed to be handled by a TTXmlHandler 
		read/write plugin parameters */
	TTErr WriteAsXml(const TTValue& value);
	TTErr ReadFromXml(const TTValue& value);
	
	/** needed to be handled by a TTOpmlHandler 
		read a directory description */
	TTErr ReadFromOpml(const TTValue& value);
	
	friend TTNodeDirectoryPtr TTMODULAR_EXPORT TTApplicationGetDirectory(TTNodeAddressPtr anAddress);
	friend TTSymbolPtr TTMODULAR_EXPORT TTApplicationConvertAppNameToTTName(TTSymbolPtr anAppName);
	friend TTSymbolPtr TTMODULAR_EXPORT TTApplicationConvertTTNameToAppName(TTSymbolPtr aTTName);
};



/**	To get an application's directory with an address
 note : it uses the extern TTModularApplications variable
 @param						..
 @return					a TTNodeDirectoryPtr */
TTNodeDirectoryPtr TTMODULAR_EXPORT TTApplicationGetDirectory(TTNodeAddressPtr anAddress);

/**	To convert an application name into standard TT name
 @param						a TTsymbol
 @return					a TTsymbol */
TTSymbolPtr TTMODULAR_EXPORT TTApplicationConvertAppNameToTTName(TTSymbolPtr anAppName);

/**	To convert standard TT name into an application name
 @param						a TTsymbol
 @return					a TTsymbol */
TTSymbolPtr TTMODULAR_EXPORT TTApplicationConvertTTNameToAppName(TTSymbolPtr aTTName);

#endif // __TT_APPLICATION_H__


