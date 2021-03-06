/*
	wcfService.m
	The implementation classes and methods for the Service web service.
	Generated by SudzC.com
*/

#import "wcfService.h"
				
#import "Soap.h"
	
#import "wcfArrayOfClockInItem.h"
#import "wcfArrayOfKeyValueItem.h"
#import "wcfKeyValueItem.h"
#import "wcfClockRtn.h"
#import "wcfClockInItem.h"

/* Implementation of the service */
				
@implementation wcfService

	- (id) init
	{
		if(self = [super init])
		{
			self.serviceUrl = @"http://ws4.buildersaccess.com/Service.svc";
			self.namespace = @"http://tempuri.org/";
			self.headers = nil;
			self.logging = NO;
		}
		return self;
	}
	
	- (id) initWithUsername: (NSString*) username andPassword: (NSString*) password {
		if(self = [super initWithUsername:username andPassword:password]) {
		}
		return self;
	}
	
	+ (wcfService*) service {
		return [wcfService serviceWithUsername:nil andPassword:nil];
	}
	
	+ (wcfService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password {
		return [[[wcfService alloc] initWithUsername:username andPassword:password] autorelease];
	}

		
	/* Returns wcfKeyValueItem*.  */
	- (SoapRequest*) xCheckLogin: (id <SoapDelegate>) handler xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType
	{
		return [self xCheckLogin: handler action: nil xemail: xemail xpassword: xpassword EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xCheckLogin: (id) _target action: (SEL) _action xemail: (NSString*) xemail xpassword: (NSString*) xpassword EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xpassword forName: @"xpassword"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xCheckLogin" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xCheckLogin" postData: _envelope deserializeTo: [[wcfKeyValueItem alloc] autorelease]];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xSendGetPasswordMail: (id <SoapDelegate>) handler xemail: (NSString*) xemail EquipmentType: (NSString*) EquipmentType
	{
		return [self xSendGetPasswordMail: handler action: nil xemail: xemail EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xSendGetPasswordMail: (id) _target action: (SEL) _action xemail: (NSString*) xemail EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xSendGetPasswordMail" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xSendGetPasswordMail" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_iphone: (id <SoapDelegate>) handler version: (NSString*) version
	{
		return [self xisupdate_iphone: handler action: nil version: version];
	}

	- (SoapRequest*) xisupdate_iphone: (id) _target action: (SEL) _action version: (NSString*) version
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: version forName: @"version"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xisupdate_iphone" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xisupdate_iphone" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_ipad: (id <SoapDelegate>) handler version: (NSString*) version
	{
		return [self xisupdate_ipad: handler action: nil version: version];
	}

	- (SoapRequest*) xisupdate_ipad: (id) _target action: (SEL) _action version: (NSString*) version
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: version forName: @"version"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xisupdate_ipad" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xisupdate_ipad" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_tablet: (id <SoapDelegate>) handler version: (NSString*) version
	{
		return [self xisupdate_tablet: handler action: nil version: version];
	}

	- (SoapRequest*) xisupdate_tablet: (id) _target action: (SEL) _action version: (NSString*) version
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: version forName: @"version"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xisupdate_tablet" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xisupdate_tablet" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xisupdate_android: (id <SoapDelegate>) handler version: (NSString*) version
	{
		return [self xisupdate_android: handler action: nil version: version];
	}

	- (SoapRequest*) xisupdate_android: (id) _target action: (SEL) _action version: (NSString*) version
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: version forName: @"version"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xisupdate_android" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xisupdate_android" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSMutableArray*.  */
	- (SoapRequest*) xGetMasterCia: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password EquipmentType: (NSString*) EquipmentType
	{
		return [self xGetMasterCia: handler action: nil xemail: xemail password: password EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xGetMasterCia: (id) _target action: (SEL) _action xemail: (NSString*) xemail password: (NSString*) password EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: password forName: @"password"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xGetMasterCia" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xGetMasterCia" postData: _envelope deserializeTo: [[wcfArrayOfKeyValueItem alloc] autorelease]];
		[_request send];
		return _request;
	}

	/* Returns wcfClockRtn*.  */
	- (SoapRequest*) xGetClockList: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia tdate: (NSString*) tdate EquipmentType: (NSString*) EquipmentType
	{
		return [self xGetClockList: handler action: nil xemail: xemail password: password xmastercia: xmastercia tdate: tdate EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xGetClockList: (id) _target action: (SEL) _action xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia tdate: (NSString*) tdate EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: password forName: @"password"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xmastercia forName: @"xmastercia"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: tdate forName: @"tdate"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xGetClockList" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xGetClockList" postData: _envelope deserializeTo: [[wcfClockRtn alloc] autorelease]];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xClockIn: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType
	{
		return [self xClockIn: handler action: nil xemail: xemail password: password xmastercia: xmastercia gis: gis EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xClockIn: (id) _target action: (SEL) _action xemail: (NSString*) xemail password: (NSString*) password xmastercia: (NSString*) xmastercia gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: password forName: @"password"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xmastercia forName: @"xmastercia"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: gis forName: @"gis"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xClockIn" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xClockIn" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}

	/* Returns NSString*.  */
	- (SoapRequest*) xClockOut: (id <SoapDelegate>) handler xemail: (NSString*) xemail password: (NSString*) password xid: (NSString*) xid gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType
	{
		return [self xClockOut: handler action: nil xemail: xemail password: password xid: xid gis: gis EquipmentType: EquipmentType];
	}

	- (SoapRequest*) xClockOut: (id) _target action: (SEL) _action xemail: (NSString*) xemail password: (NSString*) password xid: (NSString*) xid gis: (NSString*) gis EquipmentType: (NSString*) EquipmentType
		{
		NSMutableArray* _params = [NSMutableArray array];
		
		[_params addObject: [[[SoapParameter alloc] initWithValue: xemail forName: @"xemail"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: password forName: @"password"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: xid forName: @"xid"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: gis forName: @"gis"] autorelease]];
		[_params addObject: [[[SoapParameter alloc] initWithValue: EquipmentType forName: @"EquipmentType"] autorelease]];
		NSString* _envelope = [Soap createEnvelope: @"xClockOut" forNamespace: self.namespace withParameters: _params withHeaders: self.headers];
		SoapRequest* _request = [SoapRequest create: _target action: _action service: self soapAction: @"http://tempuri.org/IService/xClockOut" postData: _envelope deserializeTo: @"NSString"];
		[_request send];
		return _request;
	}


@end
	