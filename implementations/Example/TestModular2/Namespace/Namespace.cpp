/* 
 * Namespace.h v0.1
 * interface for creating and managing namespaces
 *
 * Based on TTModular & TTFoundation libraries developped by Theo de la Hogue & Tim Place
 * and DeviceManager developped by Laurent Garnier & Theo de la Hogue, copyright LaBRI - Blue Yeti - GMEA
 *
 * Author: Laurent Garnier, 2010
 *
 * Copyright Galamus Software. All rights reserved.
 *
 */

#include "Namespace.h"

#define PLUGINS_PATH	"DeviceManager\\Plugins"
#define XML_CONFIG_PATH "DeviceManager\\Config.xml"

Namespace::Namespace(std::string appName, std::string appVersion, std::string creatorName)
{
	m_appName = appName;
	m_appVersion = appVersion;
	m_creatorName = creatorName;
}

Namespace::~Namespace(void)
{
}

NSPStatus
Namespace::namespaceInit(bool useDeviceManager)
{
	// Initialise TT environments
	TTModularInit(m_appName);
	if (TTModularDirectory == NULL) {
		return NSP_INIT_ERROR;
	}

	if (useDeviceManager) {
		// Initialise DeviceManager if wanted
		TTDeviceManagerPtr m_deMan = NULL;
		TTValue	args;
		
		// Make a TTDeviceManager object
		args.append(TTModularDirectory);
		args.append(TT(m_appName));
		
		TTObjectInstantiate(TT("DeviceManager"), TTObjectHandle(&m_deMan), args);
		
		// Load plugins and config with xml
		TTValue value;
		value.append(TT(PLUGINS_PATH));
		value.append(TT(XML_CONFIG_PATH));
		m_deMan->LoadPlugins(value);

		// Load devices with xml
		m_deMan->LoadDeviceXmlConfig(TT(XML_CONFIG_PATH));
	}

	return NSP_NO_ERROR;
}

NSPStatus
Namespace::namespaceFree(void)
{
	if(TTObjectRelease(TTObjectHandle(&TTModularDirectory)) != kTTErrNone) {
		return NSP_RELEASE_ERROR;
	}

	return NSP_NO_ERROR;
}

void 
Namespace::namespaceMapperCreate(void (*returnValueCallback)	(TTPtr, TTValue&))
{
	// Create a TTMapper
	TTMapperPtr	mapper = NULL;
	TTCallbackPtr	p_returnValueCallback = NULL;
	TTValuePtr		p_returnValueBaton;
	
	// prepare arguments : see TTMapper.h to know which args are needed
	TTValue args;
	args.clear();
	TTObjectInstantiate(TT("Callback"), TTObjectHandle(&p_returnValueCallback), kTTValNONE);
	p_returnValueBaton = new TTValue(NULL);		// Here it is NULL but it could be usefull to pass 
												// an object in order to process the returned value
	p_returnValueCallback->setAttributeValue(TT("Baton"), TTPtr(p_returnValueBaton));
	p_returnValueCallback->setAttributeValue(TT("Function"), returnValueCallback);
	args.append(p_returnValueCallback);
	
	// create an instance of TTMapper
	TTObjectInstantiate(TT("Mapper"), TTObjectHandle(&mapper), args);

	//mapper->setInput("/coordinates/cartesian/xposition");
	//mapper->mInput = TT("/coordinates/cartesian/xposition");
	mapper->setAttributeValue(TT("Input"), "/coordinates/cartesian/xposition");
	mapper->setAttributeValue(TT("Output"), "/xposition");
	mapper->setAttributeValue(TT("InputMin"), 0.);
	mapper->setAttributeValue(TT("InputMax"), 100.);
	mapper->setAttributeValue(TT("OutputMin"), 0.);
	mapper->setAttributeValue(TT("OutputMax"), 1.);

}

NSPStatus
Namespace::namespaceParameterCreate(std::string address, void* object, void (*returnValueCallback)	(TTPtr, TTValue&)
																	 , void (*returnAddressCallback)(TTPtr, TTValue&))
{
	// Create a TTParameter
	TTParameterPtr	parameter = NULL;
	TTCallbackPtr	p_returnValueCallback = NULL;
	TTValuePtr		p_returnValueBaton;
	
	// prepare arguments : see TTParameter.h to know which args are needed
	TTValue args;
	args.clear();
	TTObjectInstantiate(TT("Callback"), TTObjectHandle(&p_returnValueCallback), kTTValNONE);
	p_returnValueBaton = new TTValue(TTPtr(object));		// Here it is NULL but it could be usefull to pass 
															// an object in order to process the returned value
	p_returnValueCallback->setAttributeValue(TT("Baton"), TTPtr(p_returnValueBaton));
	p_returnValueCallback->setAttributeValue(TT("Function"), returnValueCallback);
	args.append(p_returnValueCallback);
	
	// create an instance of TTParameter
	TTObjectInstantiate(TT("Parameter"), TTObjectHandle(&parameter), args);

	// Register a TTObject into the TTModularDirectory
	//TTLogMessage("\n*** Register a parameter into the TTModularDirectory *** \n");
	TTNodePtr		returnedNode;
	TTBoolean		newInstanceCreated;

	TTModularDirectory->TTNodeCreate(TT(address), (TTObjectPtr)parameter, NULL, &returnedNode, &newInstanceCreated);
	// note : our myRegistrationObserver is informed if declared 

	return NSP_NO_ERROR;
}

NSPStatus 
Namespace::namespaceAttributeSet(std::string address, TTSymbolPtr attribute, TTValue value)
{
	TTErr err, err1;
	TTList returnedTTNodes;
	TTNodePtr firstReturnedTTNode;

	if(TTModularDirectory){
		err = TTModularDirectory->Lookup(TT(address), returnedTTNodes, &firstReturnedTTNode);
		if (err != kTTErrNone) {
			return NSP_INVALID_ADDRESS;
		}

		TTParameterPtr param;
		TTValue v;
		firstReturnedTTNode->getAttributeValue(kTTSym_Object, v);
		v.get(0, (TTPtr*)&param);

		err1 = param->setAttributeValue(attribute, value);

		if (err1 != kTTErrNone) {
			return NSP_INVALID_ATTRIBUTE;
		}

		//TTLogMessage("\n*** Set Attribute *** \n");
		return NSP_NO_ERROR;
	}

	return NSP_INIT_ERROR;
}

NSPStatus 
Namespace::namespaceAttributeGet(std::string address, TTSymbolPtr attribute, TTValue& value)
{
	// get the node which represent our parameter
	TTList			aNodeList;
	TTNodePtr		aNode;
	TTModularDirectory->Lookup(TT(address), aNodeList, &aNode);

	// get the object stored in the node
	TTParameterPtr	anObject;
	aNode->getAttributeValue(kTTSym_Object, value);
	value.get(0, (TTPtr*)&anObject);

	if (anObject == NULL) {
		//TTLogMessage("anObject isnot Parameter \n");
		return NSP_INVALID_ADDRESS;
	}

	// get the attribute value of the parameter
	value.clear();
	TTErr err = anObject->getAttributeValue(attribute, value);
	if (err != kTTErrNone) {
		return NSP_INVALID_ATTRIBUTE;
	}

	return NSP_NO_ERROR;
}

NSPStatus 
Namespace::namespaceObserverCreate(std::string address, TTSymbolPtr attribute, void* object, void (*returnValueCallback)	(TTPtr, TTValue&)
																						   , void (*returnAddressCallback)	(TTPtr, TTValue&))
{
	TTReceiverPtr	myReceiver = NULL;
	TTCallbackPtr	r_returnAddressCallback = NULL; 
	TTCallbackPtr	r_returnValueCallback = NULL;
	TTValuePtr		r_returnAddressBaton, r_returnValueBaton;
	
	// prepare arguments : see TTReceiver.h to know which args are needed
	TTValue args;
	args.clear();
	args.append(TTModularDirectory);
	args.append(TT(address));
	args.append(attribute);
		
	TTObjectInstantiate(TT("Callback"), TTObjectHandle(&r_returnAddressCallback), kTTValNONE);
	r_returnAddressBaton = new TTValue(TTPtr(object));		// Here it is NULL but it could be usefull to pass 
															// an object in order to process the returned value
	r_returnAddressCallback->setAttributeValue(TT("Baton"), TTPtr(r_returnAddressBaton));
	r_returnAddressCallback->setAttributeValue(TT("Function"), returnAddressCallback);
	args.append(r_returnAddressCallback);
	

	TTObjectInstantiate(TT("Callback"), TTObjectHandle(&r_returnValueCallback), kTTValNONE);
	r_returnValueBaton = new TTValue(TTPtr(object));		// Here it is NULL but it could be usefull to pass 
															// an object in order to process the returned address;
	r_returnValueCallback->setAttributeValue(TT("Baton"), TTPtr(r_returnValueBaton));
	r_returnValueCallback->setAttributeValue(TT("Function"), TTPtr(returnValueCallback));
	args.append(r_returnValueCallback);
		
	TTObjectInstantiate(TT("Receiver"), TTObjectHandle(&myReceiver), args);

	return NSP_NO_ERROR;
}

NSPStatus 
Namespace::namespaceValueSend(std::string address, TTSymbolPtr attribute, TTValue value)
{
	TTSenderPtr	sender = NULL;
	
	// prepare arguments : see TTSender.h to know which args are needed
	TTValue args;
	args.clear();
	args.append(TTModularDirectory);
	args.append(TT(address));
	args.append(attribute);
		
	TTObjectInstantiate(TT("Sender"), TTObjectHandle(&sender), args);

	sender->sendMessage(kTTSym_send, value);
	// note : the value is returned by the Parameter and the Receiver

	TTObjectRelease(TTObjectHandle(&sender));

	return NSP_NO_ERROR;
}

void addAttributeToXml(TTParameterPtr param, XMLNode xmlNode, TTSymbolPtr attrName)
{
	TTValue		v;
	TTString	s;

	// get the Value of an attribute and format to string
	param->getAttributeValue(attrName, v);
	v.toString();
	v.get(0, s);

	// add this attribute in xml tree
	xmlNode.addAttribute_(attrName->getCString(), s.c_str());
}

// method to extract a substring safely
char *str_sub (const char *s, unsigned int start, unsigned int end)
{
   char *new_s = NULL;

   if (s != NULL && start < end)
   {
/* (1)*/
      new_s = (char*) malloc (sizeof (*new_s) * (end - start + 2));
      if (new_s != NULL)
      {
         unsigned int i;

/* (2) */
         for (i = start; i <= end; i++)
         {
/* (3) */
            new_s[i-start] = s[i];
         }
         new_s[i-start] = '\0';
      }
      else
      {
         fprintf (stderr, "Memoire insuffisante\n");
         exit (EXIT_FAILURE);
      }
   }
   return new_s;
}

void snapshot(XMLNode xmlNode, TTNodePtr ttNode)
{
	TTSymbolPtr OSCaddress;
	TTValue		v;
	TTList		childList;
	TTNodePtr	p_node;
	TTString	s;
	
	ttNode->getOscAddress(&OSCaddress);
	ttNode->getChildren(S_WILDCARD, S_WILDCARD, childList);

	const char* address = OSCaddress->getCString();
	const char* nodeName;

	XMLNode childNode = xmlNode;

	// get the substring representing the last node name
	if (strlen(address) > 1) {
		const char* c = strrchr(address, '/');
		int start = c-address+1;
		int end = strlen(address)-1;

		nodeName = str_sub(address, start, end);

		childNode = xmlNode.addChild(nodeName);
	}

	if (childList.isEmpty()) {

		// get the Parameter object of the Node
		TTParameterPtr param;
		ttNode->getAttributeValue(kTTSym_Object, v);
		v.get(0, (TTPtr*)&param);

		addAttributeToXml(param, childNode, kTTSym_Type);
		addAttributeToXml(param, childNode, kTTSym_Value);
		addAttributeToXml(param, childNode, kTTSym_ValueDefault);
		addAttributeToXml(param, childNode, kTTSym_RangeBounds);      //TODO : get the Range and format it into string
		addAttributeToXml(param, childNode, kTTSym_RangeClipmode);
		addAttributeToXml(param, childNode, kTTSym_ValueStepsize);
		addAttributeToXml(param, childNode, kTTSym_Priority);
		addAttributeToXml(param, childNode, kTTSym_Description);
		addAttributeToXml(param, childNode, kTTSym_RepetitionsAllow);
		addAttributeToXml(param, childNode, kTTSym_Readonly);

	}

	// repeat recursively for each child
	for (childList.begin(); childList.end(); childList.next()) {
		childList.current().get(0,(TTPtr*)&p_node);
		snapshot(childNode, p_node);
	}
	
}

NSPStatus 
Namespace::namespaceSaveToXml(std::string filepath)
{
	// add xml header
	XMLNode xMainNode = XMLNode::createXMLTopNode("xml", true);
    xMainNode.addAttribute_("version", "1.0");
	XMLNode node = xMainNode.addChild("namespaceXML");
	node.addAttribute_("version", "0.1.1");
	node.addAttribute_("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");

	node = xMainNode.addChild("namespace");
	node.addAttribute_("appName", m_appName.data());
	node.addAttribute_("appVersion", m_appVersion.data());
	node.addAttribute_("creatorName", m_creatorName.data());
	
	TTNodePtr root = TTModularDirectory->getRoot();
	
	// recursive method to get the namespace and build the xml tree
	snapshot(node, root);
	
	// write the datas in xml file
	xMainNode.writeToFile(filepath.c_str(), "ISO-8859-1");

	return NSP_NO_ERROR;
}

void 
Namespace::parseXmlParameters(XMLNode xmlNode, std::string address)
{
	int nChild = xmlNode.nChildNode();

	// for each child of the node
	for (int i = 0; i < nChild; i++) {
		XMLNode child = xmlNode.getChildNode(i);

		const char* childName = child.getName();
		std::string name = (std::string)childName;
		
		std::string absoluteAddress;
		if (address == "/")
			absoluteAddress = address + name;
		else
			absoluteAddress = address + "/" + name;

		// check if it is a Parameter i.e. a leaf
		if (child.nChildNode() == 0) {
			
			// create the Parameter in the namespace tree
			namespaceParameterCreate(absoluteAddress, NULL);

			int nAttrChild = child.nAttribute();

			const char* type = child.getAttribute("Type");
			
			// get all it attributes
			TTValue value;
			for (int j = 0; j < nAttrChild; j++) {

				const char* attrName = child.getAttributeName(j);

				value.clear();
				
				// convert attribute values from const char* to their real types
				if (strcmp(attrName, NSPAttr_TYPE->getCString())			== 0 
					|| strcmp(attrName, NSPAttr_RANGE->getCString())		== 0
					|| strcmp(attrName, NSPAttr_PRIORITY->getCString())		== 0 
					|| strcmp(attrName, NSPAttr_DESCRIPTION->getCString())  == 0
					|| strcmp(attrName, NSPAttr_RANGECLIPMODE->getCString())  == 0) 
				{

					const char* type = child.getAttributeValue(j);
					value = TTValue(TT(type));
					
				}
				if (strcmp(attrName, NSPAttr_VAL->getCString())				== 0 
					|| strcmp(attrName, NSPAttr_DEFAULT->getCString())		== 0 
					|| strcmp(attrName, NSPAttr_STEP->getCString())			== 0
					|| strcmp(attrName, NSPAttr_REPETITION->getCString())	== 0
					|| strcmp(attrName, NSPAttr_READONLY->getCString())		== 0) 
				{

					const char* val = child.getAttributeValue(j);

					if (strncmp(type, NSPType_FLOAT->getCString(), 3)		== 0) {
						double tmp = atof(val);
						value = TTValue(tmp);
					} 
					else if (strncmp(type, NSPType_INT->getCString(), 3)	== 0) {
						int tmp = atoi(val);
						value = TTValue(tmp);
					}
					else if (strncmp(type, NSPType_BOOL->getCString(), 3)	== 0) {
						bool tmp = (atoi(val) == 1); 
						value = TTValue(tmp);
					}
					else if (strncmp(type, NSPType_STRING->getCString(), 3)	== 0) {
						value = TTValue((std::string)val);
					}
					else if (strncmp(type, NSPType_GENERIC->getCString(), 3) == 0) {
						void* tmp = (void*)val;
						value = TTValue(tmp);
					}
					//TODO : NSPType_ARRAY
				}

				// Initialise the attribute in the namespace tree
				namespaceAttributeSet(absoluteAddress, TT(attrName), value);
			} 
		} else {
			// if not a Parameter call it recursively for each child
			parseXmlParameters(child, absoluteAddress);
		}
	}
}

NSPStatus 
Namespace::namespaceLoadFromXml(std::string filepath)
{
	XMLNode xMainNode;
	XMLError err = XMLNode::openFileHelper(&xMainNode, filepath.c_str(), "namespace");
	if (err == eXMLErrorFileNotFound)
		return NSP_FILE_NOTFOUND;
	if (err == eXMLErrorFirstTagNotFound)
		return NSP_XMLPARSING_ERROR;

	std::string address = "/";
	parseXmlParameters(xMainNode, address);

	return NSP_NO_ERROR;
}


NSPStatus 
Namespace::namespaceDisplay(void)
{
	unsigned int i;
	TTValue hk;
	TTSymbolPtr key;

	if (TTModularDirectory) {	
		TTModularDirectory->getDirectory()->getKeys(hk);

		for (i = 0; i < TTModularDirectory->getDirectory()->getSize(); i++){
			hk.get(i,(TTSymbol**)&key);
			TTLogMessage("%s\n",key->getCString());
		}

		return NSP_NO_ERROR;
	}
	
	//TTLogMessage("TTModularDirectory_dump : create a directory before");
	return NSP_INIT_ERROR;
}


void Namespace::setAppName		(const  std::string _appName)		{ m_appName = _appName; }
void Namespace::setAppVersion	(const  std::string _appVersion)	{ m_appVersion = _appVersion; }
void Namespace::setCreatorName	(const  std::string _creatorName)	{ m_creatorName = _creatorName; }

std::string Namespace::getAppName()		const { return m_appName; }
std::string Namespace::getAppVersion()  const { return m_appVersion; }
std::string Namespace::getCreatorName()	const { return m_creatorName; }
