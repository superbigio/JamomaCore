/* 
 * An Application Manager Object
 * Copyright © 2010, Théo de la Hogue
 * 
 * License: This code is licensed under the terms of the "New BSD License"
 * http://creativecommons.org/licenses/BSD/
 */

#include "TTApplicationManager.h"
#include "Plugin.h"

#define thisTTClass			TTApplicationManager
#define thisTTClassName		"ApplicationManager"
#define thisTTClassTags		"application, manager"

TT_MODULAR_CONSTRUCTOR,
mApplications(NULL),
mApplicationNames(kTTValNONE),
mPluginNames(kTTValNONE),
mCurrentApplication(NULL),
mApplicationObservers(NULL),
mApplicationObserversMutex(NULL)
{		
	addAttribute(Applications, kTypePointer);
	addAttributeProperty(applications, readOnly, YES);
	addAttributeProperty(applications, hidden, YES);
	
	addAttributeWithGetter(ApplicationNames, kTypeLocalValue);
	addAttributeProperty(applicationNames, readOnly, YES);
	
	registerAttribute(TT("localApplicationName"), kTypeSymbol, kTTSym_localApplicationName, (TTGetterMethod)& TTApplicationManager::getLocalApplicationName, (TTSetterMethod)& TTApplicationManager::setLocalApplicationName);
	
	addAttributeWithGetter(PluginNames, kTypeLocalValue);
	addAttributeProperty(pluginNames, readOnly, YES);
	
	addMessageWithArgument(ApplicationAdd);
	addMessageWithArgument(ApplicationRemove);
	
	addMessageWithArgument(ApplicationDiscover);
	addMessageProperty(ApplicationDiscover, hidden, YES);
	
	addMessageWithArgument(ApplicationGet);
	addMessageProperty(ApplicationGet, hidden, YES);
	
	addMessageWithArgument(ApplicationSet);
	addMessageProperty(ApplicationSet, hidden, YES);
	
	addMessageWithArgument(ApplicationListen);
	addMessageProperty(ApplicationListen, hidden, YES);
	
	addMessageWithArgument(ApplicationListenAnswer);
	addMessageProperty(ApplicationListenAnswer, hidden, YES);
	
	addMessageWithArgument(PluginScan);
	addMessageWithArgument(PluginRun);
	addMessageWithArgument(PluginStop);
	
	// needed to be handled by a TTXmlHandler
	addMessageWithArgument(WriteAsXml);
	addMessageProperty(WriteAsXml, hidden, YES);
	
	addMessageWithArgument(ReadFromXml);
	addMessageProperty(ReadFromXml, hidden, YES);
	
	mApplications = new TTHash();
	mPlugins = new TTHash();
	
	// create a ApplicationObservers table and protect it from multithreading access
	// why ? because observers could disappear when they know an application is destroyed
	mApplicationObservers = new TTHash();
	mApplicationObservers->setThreadProtection(true);
	mApplicationObserversMutex = new TTMutex(true);
	
	// Instantiate all existing plugins (all ready loaded by Foundation framework)
	TTValue pluginNames;
	PluginLib::getPluginNames(pluginNames);
	if (pluginNames.getSize()) {
		
		TTSymbolPtr pluginName = NULL;
		PluginPtr	aPluginObject = NULL;
		TTValue		args;
		TTErr		err;
		
		// for each plugin name
		for (TTUInt32 i=0; i<pluginNames.getSize(); i++) {
			
			pluginNames.get(i, &pluginName);
			
			// create an instance of a Plugin object
			err = PluginLib::createPlugin(pluginName, &aPluginObject, (TTObjectPtr)this);
			
			if (!err) {
				// add it to Modular plugins table
				args = TTValue((TTPtr)aPluginObject);
				mPlugins->append(pluginName, args);
				
				TTLogDebug("%s plugin loaded", pluginName->getCString());
			}
			else
				TTLogDebug("%s plugin can't be loaded ", pluginName->getCString());
				
		}
	}
}

TTApplicationManager::~TTApplicationManager()
{
	TTValue				v, allPluginNames;
	TTSymbolPtr			pluginName;
	PluginPtr	aPlugin;
	TTErr				err;
	
	delete mApplications;
	
	// destroy each plugin
	mPlugins->getKeys(allPluginNames);
	for (TTUInt16 i=0; i<allPluginNames.getSize(); i++) {
		
		allPluginNames.get(i, &pluginName);
		err = mPlugins->lookup(pluginName, v);
		
		if (!err) {
			v.get(0, (TTPtr*)&aPlugin);
			TTObjectRelease(TTObjectHandle(&aPlugin));
		}
	}
}

TTErr TTApplicationManager::getApplicationNames(TTValue& value)
{
	return mApplications->getKeys(value);
}

TTErr TTApplicationManager::getLocalApplicationName(TTValue& value)
{
	value = kTTSym_localApplicationName;
	return kTTErrNone;
}

TTErr TTApplicationManager::setLocalApplicationName(TTValue& value)
{
	TTValue				v;
	TTApplicationPtr	localApplication = NULL;
	TTErr				err;
	
	// get the local application
	err = mApplications->lookup(kTTSym_localApplicationName, v);
	
	// if the local application exists
	// rename it and remove it
	if (!err) {
		v.get(0, (TTPtr*)&localApplication);
		localApplication->setAttributeValue(kTTSym_name, value);
		mApplications->remove(kTTSym_localApplicationName);
	}
	
	// in any case change localApplicacationName
	kTTSym_localApplicationName = value;
	
	// if the local application exists
	// register it to using the new name
	if (!err)
		mApplications->append(kTTSym_localApplicationName, v);
	
	return kTTErrNone;
}

TTErr TTApplicationManager::getPluginNames(TTValue& value)
{
	return mPlugins->getKeys(value);
}

TTErr TTApplicationManager::ApplicationAdd(const TTValue& value)
{
	TTValue				v, args, allPluginNames;
	TTSymbolPtr			applicationName;
	TTApplicationPtr	anApplication;
	
	value.get(0, &applicationName);
	
	// if no given application, instantiate it
	if (value.getSize() == 2)
		value.get(1, (TTPtr*) &anApplication);
	else {
		anApplication = NULL;
		args.append(applicationName);
		args.append(TT("unknown version"));
		TTObjectInstantiate(TT("Application"), TTObjectHandle(&anApplication), args);
	}
	
	// add application to the manager
	mApplications->append(applicationName, (TTPtr)anApplication);
	
	// TODO : notify distant application creation observers
	if (applicationName != kTTSym_localApplicationName)
		;
	
	// notify applications observer that an application has been added
	notifyApplicationObservers(applicationName, anApplication, kApplicationAdded);
	
	return kTTErrNone;
}

TTErr TTApplicationManager::ApplicationRemove(const TTValue& value)
{	
	TTValue				v;
	TTSymbolPtr			applicationName;
	TTApplicationPtr	anApplication;
	TTErr				err;

	value.get(0, &applicationName);
	
	err = mApplications->lookup(applicationName, v);
	
	if (!err) {
		v.get(0, (TTPtr*)&anApplication);
		
		// notify applications observer that an application will be removed
		notifyApplicationObservers(applicationName, anApplication, kApplicationAdded);
		
		mApplications->remove(applicationName);
		return TTObjectRelease(TTObjectHandle(&anApplication));
	}
	
	return kTTErrGeneric;
}

TTErr TTApplicationManager::PluginScan(const TTValue& value)
{
	TTValue v, allPluginNames;
	TTSymbolPtr pluginName;
	PluginPtr aPlugin;
	TTErr				err;
	
	// if no name do it for all plugin
	if (value.getSize()) {
		
		value.get(0, &pluginName);
		
		if (!mPlugins->lookup(pluginName, v)) {
			v.get(0, (TTPtr*)&aPlugin);
			aPlugin->sendMessage(TT("Scan"));
		}
	}
	else {
		// Scan each plugin
		mPlugins->getKeys(allPluginNames);
		for (TTUInt16 i=0; i<allPluginNames.getSize(); i++) {
			
			allPluginNames.get(i, &pluginName);
			err = mPlugins->lookup(pluginName, v);
			
			if (!err) {
				v.get(0, (TTPtr*)&aPlugin);
				aPlugin->sendMessage(TT("Scan"));
			}
		}
	}
	
	return kTTErrNone;
}

TTErr TTApplicationManager::PluginRun(const TTValue& value)
{
	TTValue				v, allPluginNames, allApplicationNames;
	TTSymbolPtr			pluginName, applicationName, appPluginName;
	PluginPtr	aPlugin;
	TTApplicationPtr	anApplication;
	TTErr				err;
	
	// if no name do it for all plugin
	if (value.getSize()) {
		
		value.get(0, &pluginName);
		
		if (!mPlugins->lookup(pluginName, v)) {
			v.get(0, (TTPtr*)&aPlugin);
			aPlugin->sendMessage(TT("Run"));
		}
	}
	else {
		
		// Run each plugin
		mPlugins->getKeys(allPluginNames);
		for (TTUInt16 i=0; i<allPluginNames.getSize(); i++) {
			
			allPluginNames.get(i, &pluginName);
			this->PluginRun(pluginName);
		}
		
		return kTTErrNone;
	}
	
	// notify application obervers for application that use this plugin
	mApplications->getKeys(allApplicationNames);
	for (TTUInt16 j=0; j<allApplicationNames.getSize(); j++) {
		
		allApplicationNames.get(j, &applicationName);
		
		if (applicationName != kTTSym_localApplicationName) {
			err = mApplications->lookup(applicationName, v);
			
			if (!err) {
				v.get(0, (TTPtr*)&anApplication);
				
				anApplication->getAttributeValue(TT("pluginNames"), v); 
				v.get(0, &appPluginName);
				
				if (appPluginName == pluginName)
					notifyApplicationObservers(applicationName, anApplication, kApplicationPluginStarted);
			}
		}
	}
	
	return kTTErrNone;
}

TTErr TTApplicationManager::PluginStop(const TTValue& value)
{
	TTValue				v, allPluginNames, allApplicationNames;
	TTSymbolPtr			pluginName, applicationName, appPluginName;
	PluginPtr	aPlugin;
	TTApplicationPtr	anApplication;
	TTErr				err;
	
	// if no name do it for all plugin
	if (value.getSize()) {
		
		value.get(0, &pluginName);
		
		if (!mPlugins->lookup(pluginName, v)) {
			v.get(0, (TTPtr*)&aPlugin);
			aPlugin->sendMessage(TT("Stop"));
		}
	}
	else {
		
		// Stop each plugin
		mPlugins->getKeys(allPluginNames);
		for (TTUInt16 i=0; i<allPluginNames.getSize(); i++) {
			
			allPluginNames.get(i, &pluginName);
			this->PluginStop(pluginName);
		}
		
		return kTTErrNone;
	}
	
	// notify application obervers for application that use this plugin
	mApplications->getKeys(allApplicationNames);
	for (TTUInt16 j=0; j<allApplicationNames.getSize(); j++) {
		
		allApplicationNames.get(j, &applicationName);
		
		if (applicationName != kTTSym_localApplicationName) {
			err = mApplications->lookup(applicationName, v);
			
			if (!err) {
				v.get(0, (TTPtr*)&anApplication);
				
				anApplication->getAttributeValue(TT("pluginNames"), v); 
				v.get(0, &appPluginName);
				
				if (appPluginName == pluginName)
					notifyApplicationObservers(applicationName, anApplication, kApplicationPluginStopped);
			}
		}
	}

	return kTTErrNone;
}

TTErr TTApplicationManager::ApplicationDiscover(TTValue& value)
{
	TTNodeDirectoryPtr	directory;
	TTNodeAddressPtr	whereToDiscover;
	TTValuePtr			returnedChildrenNames;
	TTValuePtr			returnedChildrenTypes;
	TTValuePtr			returnedAttributes;
	
	value.get(0, &whereToDiscover);
	value.get(1, (TTPtr*)&returnedChildrenNames);
	value.get(2, (TTPtr*)&returnedChildrenTypes);
	value.get(3, (TTPtr*)&returnedAttributes);
	
	TTLogDebug("TTApplicationManager::Discover");
	
	TTList				nodeList, childList;
	TTNodePtr			firstNode, aNode;
	TTNodeAddressPtr	nodeAddress;
	TTSymbolPtr			objectType;
	TTObjectPtr			anObject;
	TTErr				err;
	
	directory = getDirectoryFrom(whereToDiscover);
	if (!directory)
		return kTTErrGeneric;
	
	err = directory->Lookup(whereToDiscover, nodeList, &firstNode);
	
	if (!err) {
		
		firstNode->getChildren(S_WILDCARD, S_WILDCARD, childList);
		
		// fill returned attributes
		if (anObject = firstNode->getObject())
			anObject->getAttributeNames(*returnedAttributes);
		
		// fill returned children names and types value
		for (childList.begin(); childList.end(); childList.next()) {
			
			// get the returned node
			childList.current().get(0, (TTPtr*)&aNode);
			
			// get the relative address
			aNode->getAddress(&nodeAddress, whereToDiscover);
			returnedChildrenNames->append(nodeAddress);
			
			// add the type of each refered object
			if (anObject = aNode->getObject()) {
				objectType = anObject->getName();
				
				if (objectType != kTTSymEmpty)
					returnedChildrenTypes->append(objectType);
				else
					returnedChildrenTypes->append(kTTSym_none);
			}
			else
				returnedChildrenTypes->append(kTTSym_none);
		}
		
		return kTTErrNone;
	} 
	
	return kTTErrGeneric;
}

TTErr TTApplicationManager::ApplicationGet(TTValue& value)
{
	TTNodeDirectoryPtr	directory;
	TTNodeAddressPtr	whereToGet;
	TTValuePtr			returnedValue;
	
	value.get(0, &whereToGet);
	value.get(1, (TTPtr*)&returnedValue);
	
	TTLogDebug("TTApplicationManager::Get");
	
	TTNodePtr			nodeToGet;
	TTObjectPtr			anObject;
	TTErr				err;
	
	directory = getDirectoryFrom(whereToGet);
	if (!directory)
		return kTTErrGeneric;
	
	// can't allow to use wilcards here because one value is returned
	err = directory->getTTNode(whereToGet, &nodeToGet);
	
	if (!err)
		if (anObject = nodeToGet->getObject())
			return anObject->getAttributeValue(whereToGet->getAttribute(), *returnedValue);

	return kTTErrGeneric;
}

TTErr TTApplicationManager::ApplicationSet(TTValue& value)
{
	TTNodeDirectoryPtr	directory;
	TTNodeAddressPtr	whereToSet;
	TTValuePtr			newValue;
	
	value.get(0, &whereToSet);
	value.get(1, (TTPtr*)&newValue);
	
	TTLogDebug("TTApplicationManager::Set");
	
	TTList				aNodeList;
	TTNodePtr			nodeToSet;
	TTSymbolPtr			objectType;
	TTObjectPtr			anObject;
	TTErr				err;
	
	directory = getDirectoryFrom(whereToSet);
	if (!directory)
		return kTTErrGeneric;
	
	// allow to use wilcards
	err = directory->Lookup(whereToSet, aNodeList, &nodeToSet);
	
	if (!err) {
		
		for (aNodeList.begin(); aNodeList.end(); aNodeList.next())
		{
			// get a node from the selection
			aNodeList.current().get(0,(TTPtr*)&nodeToSet);
			
			anObject = nodeToSet->getObject();
			objectType = anObject->getName();
			
			// TTData case : for value attribute use Command message
			if (objectType == TT("Data")) {
				
				if (whereToSet->getAttribute() == kTTSym_value)
					anObject->sendMessage(kTTSym_Command, *newValue);
				else
					return anObject->setAttributeValue(whereToSet->getAttribute(), *newValue);
			}
			else 
				return anObject->setAttributeValue(whereToSet->getAttribute(), *newValue);
		}
	}
	
	return kTTErrGeneric; // TODO : return an error notification
}

TTErr TTApplicationManager::ApplicationListen(TTValue& value)
{
	TTNodeAddressPtr	whereToListen;
	TTSymbolPtr			appToNotify, pluginName;
	TTBoolean			enableListening;
	
	value.get(0, &pluginName);
	value.get(1, &appToNotify);
	value.get(2, &whereToListen);
	value.get(3, enableListening);
	
	TTLogDebug("TTApplicationManager::Listen");
	
	TTApplicationPtr	appWhereToListen;
	PluginPtr			aPlugin;
	TTValue				v, args;
	TTErr				err;
	
	appWhereToListen = getApplicationFrom(whereToListen);
	err = mPlugins->lookup(pluginName, v);
	
	if (!err && appWhereToListen) 
	{
		v.get(0, (TTPtr*)&aPlugin);
		
		// add observer
		if (enableListening) {
			
			args.append((TTPtr)aPlugin);
			args.append(appToNotify);
			args.append(whereToListen);
			
			// start directory listening
			if (whereToListen->getAttribute() == TT("life")) // TODO : find a better name
				return appWhereToListen->sendMessage(TT("AddDirectoryListener"), args);
	
			// start attribute listening
			else 
				return appWhereToListen->sendMessage(TT("AddAttributeListener"), args);
		}
		// remove listener
		else {
			
			args.append(appToNotify);
			args.append(whereToListen);
			
			// stop directory listening
			if (whereToListen->getAttribute() == TT("life")) // TODO : find a better name
				return appWhereToListen->sendMessage(TT("RemoveDirectoryListener"), args);

			// stop attribute listening
			else
				return appWhereToListen->sendMessage(TT("RemoveAttributeListener"), args);
		}
	}	

	return kTTErrGeneric;
}

TTErr TTApplicationManager::ApplicationListenAnswer(TTValue& value)
{
	TTSymbolPtr			appAnswering;
	TTNodeAddressPtr	whereComesFrom;
	TTValuePtr			newValue;
	TTValue				args;
	
	value.get(0, &appAnswering);
	value.get(1, &whereComesFrom);
	value.get(2, (TTPtr*)&newValue);
	
	TTLogDebug("TTApplicationManager::ListenAnswer");
	
	args.append(whereComesFrom);
	args.append((TTPtr)newValue);
	
	// notify directory updates
	if (whereComesFrom->getAttribute() == TT("life")) // TODO : find a better name
		return getApplication(appAnswering)->sendMessage(TT("UpdateDirectory"), args);
	
	// notify attribute updates
	else 
		return getApplication(appAnswering)->sendMessage(TT("UpdateAttribute"), args);
	
	return kTTErrGeneric;	
}

TTErr TTApplicationManager::WriteAsXml(const TTValue& value)
{
	TTXmlHandlerPtr		aXmlHandler;
	TTSymbolPtr			applicationName, version;
	TTApplicationPtr	anApplication;
    TTValue				keys, v;
	
	value.get(0, (TTPtr*)&aXmlHandler);
	
    xmlTextWriterWriteComment(aXmlHandler->mWriter, BAD_CAST "TODO : a TTApplication Manager comment");
	
	// For each application
	mApplications->getKeys(keys);
	for (TTUInt16 i=0; i<keys.getSize(); i++) {
		
		keys.get(i, &applicationName);
		mApplications->lookup(applicationName, v);
		v.get(0, (TTPtr*)&anApplication);
		
		// Start "application" xml node
		xmlTextWriterStartElement(aXmlHandler->mWriter, BAD_CAST "application");
		xmlTextWriterWriteFormatAttribute(aXmlHandler->mWriter, BAD_CAST "name", "%s", BAD_CAST applicationName->getCString());
		
		anApplication->getAttributeValue(TT("version"), v);
		v.get(0, &version);
		xmlTextWriterWriteFormatAttribute(aXmlHandler->mWriter, BAD_CAST "version", "%s", BAD_CAST version->getCString());
		
		v = TTValue(TTPtr(anApplication));
		aXmlHandler->setAttributeValue(kTTSym_object, v);
		aXmlHandler->sendMessage(TT("Write"));
		
		// End "application" xml node
		xmlTextWriterEndElement(aXmlHandler->mWriter);
	}
	
	return kTTErrNone;
}

TTErr TTApplicationManager::ReadFromXml(const TTValue& value)
{
	TTXmlHandlerPtr		aXmlHandler = NULL;	
	TTSymbolPtr			applicationName, currentApplicationName, version;
	TTApplicationPtr	anApplication;
	TTValue				v, args, allAppNames;
	TTErr				err;
	
	value.get(0, (TTPtr*)&aXmlHandler);
	if (!aXmlHandler)
		return kTTErrGeneric;
	
	// switch on the name of the XML node
	
	// starts reading
	if (aXmlHandler->mXmlNodeName == TT("start")) {
		
		mCurrentApplication = NULL;
		
		// stop plugin reception threads
		PluginStop(v);
		
		// remove all applications except the local one
		mApplications->getKeys(allAppNames);
		for (TTUInt16 i=0; i<allAppNames.getSize(); i++) {
			
			allAppNames.get(i, &applicationName);
			err = mApplications->lookup(applicationName, v);
			
			if (!err && applicationName != kTTSym_localApplicationName) {
				v.get(0, (TTPtr*)&anApplication);
				TTObjectRelease(TTObjectHandle(&anApplication));
				mApplications->remove(applicationName);
			}
		}
		
		return kTTErrNone;
	}
	
	// ends reading
	if (aXmlHandler->mXmlNodeName == TT("end")) {
		
		// start plugin reception threads
		PluginRun(v);
		
		return kTTErrNone;
	}
	
	// comment node
	if (aXmlHandler->mXmlNodeName == TT("#comment"))
		return kTTErrNone;
	
	// application node
	if (aXmlHandler->mXmlNodeName == TT("application")) {
		
		// get the application name 
		xmlTextReaderMoveToAttribute(aXmlHandler->mReader, (const xmlChar*)("name"));
		aXmlHandler->fromXmlChar(xmlTextReaderValue(aXmlHandler->mReader), v);
		if (v.getType() == kTypeSymbol) {
			v.get(0, &applicationName);
		}
		
		// if it is the end of a "application" xml node
		if (mCurrentApplication) {
			mCurrentApplication->getAttributeValue(kTTSym_name, v);
			v.get(0, &currentApplicationName);
			
			if (applicationName == currentApplicationName) {
				
				// if the application is not registered : add it
				if (mApplications->lookup(applicationName, v)) {
					v = TTValue(applicationName);
					v.append((TTPtr)mCurrentApplication);
					ApplicationAdd(v);
				}
				
				mCurrentApplication = NULL;
				return kTTErrNone;
			}
		}
		
		// get the application version 
		xmlTextReaderMoveToAttribute(aXmlHandler->mReader, (const xmlChar*)("version"));
		aXmlHandler->fromXmlChar(xmlTextReaderValue(aXmlHandler->mReader), v);
		if (v.getType() == kTypeSymbol) {
			v.get(0, &version);
		}
		
		// if the application exists : get it
		if (!mApplications->lookup(applicationName, v))
			v.get(0, (TTPtr*)&anApplication);
		
		// else create one
		else {
			anApplication = NULL;
			args = TTValue(applicationName);
			args.append(version);
			TTObjectInstantiate(TT("Application"), TTObjectHandle(&anApplication), args);
		}
		
		mCurrentApplication = anApplication;
		
		return kTTErrNone;
	}
	
	if (!mCurrentApplication) 
		return kTTErrNone;
	
	// pass the current application to the XmlHandler to fill plugin parameters
	v = TTValue((TTPtr)mCurrentApplication);
	aXmlHandler->setAttributeValue(kTTSym_object, v);
	return aXmlHandler->sendMessage(TT("Read"));
}

TTErr TTApplicationManager::notifyApplicationObservers(TTSymbolPtr anApplicationName, TTApplicationPtr anApplication, TTApplicationNotificationFlag flag)
{
	unsigned int i;
	TTValue hk, lk, o, f, data;
	TTSymbolPtr key;
	TTListPtr lk_o;
	TTCallbackPtr anObserver;
	bool foundObsv = false;
	
	// if there are observers
	if (!mApplicationObservers->isEmpty()) {
		
		// enable observers protection
		mApplicationObserversMutex->lock();
		
		this->mApplicationObservers->getKeys(hk);
		
		// for each key of mObserver tab
		for (i=0; i<hk.getSize(); i++) {
			
			hk.get(i, &key);
			
			// compare the key with the applicationName
			if (key == anApplicationName){
				
				// get the Observers list
				mApplicationObservers->lookup(key, lk);
				lk.get(0,(TTPtr*)&lk_o);
				
				if (!lk_o->isEmpty()) {
					for (lk_o->begin(); lk_o->end(); lk_o->next())
					{
						anObserver = NULL;
						lk_o->current().get(0, TTObjectHandle(&anObserver));
						TT_ASSERT("TTApplication observer list member is not NULL", anObserver);
						data.append(anApplicationName);
						data.append((TTPtr*)anApplication);
						data.append((TTInt8)flag);
						data.append((TTPtr*)anObserver);
						anObserver->notify(data);
					}
					
					foundObsv = true;
				}
			}
		}
		
		// disable observers protection
		mApplicationObserversMutex->unlock();
		
		if (foundObsv)
			return kTTErrNone;
		else
			return kTTErrGeneric;
	}
	else
		return kTTErrGeneric;
}

#if 0
#pragma mark -
#pragma mark Some Methods
#endif

TTApplicationPtr TTApplicationManagerGetApplication(TTSymbolPtr applicationName)
{
	TTValue				v;
	TTApplicationPtr	anApplication;
	TTErr				err;
	
	if (TTModularApplications) {
		
		err = TTModularApplications->mApplications->lookup(applicationName, v);
		
		if (!err) {
			v.get(0, (TTPtr*)&anApplication);
			return anApplication;
		}
	}
	
	return NULL;
}

TTApplicationPtr TTApplicationManagerGetApplicationFrom(TTNodeAddressPtr anAddress)
{
	TTSymbolPtr			applicationName;
	TTApplicationPtr	anApplication;
	
	if (TTModularApplications) {
		
		applicationName = anAddress->getDirectory();
		
		if (applicationName != NO_DIRECTORY)
			anApplication = TTApplicationManagerGetApplication(applicationName);
		else
			anApplication = TTApplicationManagerGetApplication(kTTSym_localApplicationName);
		
		return anApplication;
	}
	
	return NULL;
}

TTObjectPtr TTApplicationManagerGetPlugin(TTSymbolPtr pluginName)
{
	TTValue		v;
	PluginPtr	aPlugin;
	TTErr		err;
	
	if (TTModularApplications) {
		
		err = TTModularApplications->mPlugins->lookup(pluginName, v);
		
		if (!err) {
			v.get(0, (TTPtr*)&aPlugin);
			return (TTObjectPtr)aPlugin;
		}
	}
	
	return NULL;
}

TTErr TTApplicationManagerAddApplicationObserver(TTSymbolPtr anApplicationName, const TTObject& anObserver)
{
	TTErr		err;
	TTValue		lk;
	TTValue		o = anObserver;
	TTListPtr	lk_o;
	
	if (TTModularApplications) {
		
		// enable observers protection
		TTModularApplications->mApplicationObserversMutex->lock();
		
		// is the key already exists ?
		err = TTModularApplications->mApplicationObservers->lookup(anApplicationName, lk);
		
		// create a new observers list for this address
		if(err == kTTErrValueNotFound){
			lk_o = new TTList();
			lk_o->appendUnique(o);
			
			TTModularApplications->mApplicationObservers->append(anApplicationName, TTValue(lk_o));
		}
		// add it to the existing list
		else{
			lk.get(0,(TTPtr*)&lk_o);
			lk_o->appendUnique(o);
		}
		
		// disable observers protection
		TTModularApplications->mApplicationObserversMutex->unlock();
		
		return kTTErrNone;
	}
	
	return kTTErrGeneric;
}

TTErr TTApplicationManagerRemoveApplicationObserver(TTSymbolPtr anApplicationName, const TTObject& anObserver)
{
	TTErr			err;
	TTValue			lk, o, v;
	TTListPtr		lk_o;
	
	if (TTModularApplications) {
		
		// enable observers protection
		TTModularApplications->mApplicationObserversMutex->lock();
		
		// is the key exists ?
		err = TTModularApplications->mApplicationObservers->lookup(anApplicationName, lk);
		
		if(err != kTTErrValueNotFound){
			// get the observers list
			lk.get(0,(TTPtr*)&lk_o);
			
			// is observer exists ?
			o = TTValue(anObserver);
			err = lk_o->findEquals(o, v);
			if(!err)
				lk_o->remove(v);
			
			// was it the last observer ?
			if(lk_o->getSize() == 0) {
				// remove the key
				TTModularApplications->mApplicationObservers->remove(anApplicationName);
			}
		}
		
		// disable observers protection
		TTModularApplications->mApplicationObserversMutex->unlock();
		
		return err;
		
	}
	
	return kTTErrGeneric;
}