/*
	wcfService.h
	The interface definition of classes and methods for the Service web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				
#import "wcfArrayOfClockInItem.h"
#import "wcfArrayOfKeyValueItem.h"
#import "wcfKeyValueItem.h"
#import "wcfClockRtn.h"
#import "wcfClockInItem.h"

/* Interface for the service */
				
@interface wcfService : SoapService
		
	/* Returns wcfKeyValueItem*.  */
	- (SoapRequest*) xCheckLogin: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType;
	- (SoapRequest*) xCheckLogin: (id) target action: (SEL) action xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType;

	/* Returns NSString*.  */
	- (SoapRequest*) xSendGetPasswordMail: (id <SoapDelegate>) handler xemail: (NSString*) xemail EquipmentType: (NSString*) EquipmentType;
	- (SoapRequest*) xSendGetPasswordMail: (id) target action: (SEL) action xemail: (NSString*) xemail EquipmentType: (NSString*) EquipmentType;

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_iphone: (id <SoapDelegate>) handler version: (NSString*) version;
	- (SoapRequest*) xisupdate_iphone: (id) target action: (SEL) action version: (NSString*) version;

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_ipad: (id <SoapDelegate>) handler version: (NSString*) version;
	- (SoapRequest*) xisupdate_ipad: (id) target action: (SEL) action version: (NSString*) version;

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_tablet: (id <SoapDelegate>) handler version: (NSString*) version;
	- (SoapRequest*) xisupdate_tablet: (id) target action: (SEL) action version: (NSString*) version;

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_android: (id <SoapDelegate>) handler version: (NSString*) version;
	- (SoapRequest*) xisupdate_android: (id) target action: (SEL) action version: (NSString*) version;

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) xGetMasterCia: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password EquipmentType: (NSString*) EquipmentType;
	- (SoapRequest*) xGetMasterCia: (id) target action: (SEL) action xemail: (NSString*) xemail password: (NSString*) password EquipmentType: (NSString*) EquipmentType;

	/* Returns wcfClockRtn*.  */
	- (SoapRequest*) xGetClockList: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia tdate: (NSString*) tdate EquipmentType: (NSString*) EquipmentType;
	- (SoapRequest*) xGetClockList: (id) target action: (SEL) action xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia tdate: (NSString*) tdate EquipmentType: (NSString*) EquipmentType;

	/* Returns NSString*.  */
	- (SoapRequest*) xClockIn: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType;
	- (SoapRequest*) xClockIn: (id) target action: (SEL) action xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType;

	/* Returns NSString*.  */
	- (SoapRequest*) xClockOut: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password xid: (NSString*) xid gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType;
	- (SoapRequest*) xClockOut: (id) target action: (SEL) action xemail: (NSString*) xemail password: (NSString*) password xid: (NSString*) xid gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType;

		
	+ (wcfService*) service;
	+ (wcfService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;
@end
	