/*
	wcfServiceExample.m
	Provides example and test runs the service's proxy methods.
	Generated by SudzC.com
*/
#import "wcfServiceExample.h"
#import "wcfService.h"

@implementation wcfServiceExample

- (void)run {
	// Create the service
	wcfService* service = [wcfService service];
	service.logging = YES;
	// service.username = @"username";
	// service.password = @"password";
	

	// Returns wcfKeyValueItem*. 
	[service xCheckLogin:self action:@selector(xCheckLoginHandler:) xemail: @"" xpassword: @"" EquipmentType: @""];

	// Returns NSString*. 
	[service xClockIn:self action:@selector(xClockInHandler:) xemail: @"" password: @"" xmastercia: @"" gis: @"" EquipmentType: @""];

	// Returns NSString*. 
	[service xClockOut:self action:@selector(xClockOutHandler:) xemail: @"" password: @"" xid: @"" gis: @"" EquipmentType: @""];

	// Returns wcfClockRtn*. 
	[service xGetClockList:self action:@selector(xGetClockListHandler:) xemail: @"" password: @"" xmastercia: @"" tdate: @"" EquipmentType: @""];

	// Returns NSMutableArray*. 
	[service xGetMasterCia:self action:@selector(xGetMasterCiaHandler:) xemail: @"" password: @"" EquipmentType: @""];

	// Returns NSString*. 
	[service xisupdate_android:self action:@selector(xisupdate_androidHandler:) version: @""];

	// Returns NSString*. 
	[service xisupdate_ipad:self action:@selector(xisupdate_ipadHandler:) version: @""];

	// Returns NSString*. 
	[service xisupdate_iphone:self action:@selector(xisupdate_iphoneHandler:) version: @""];

	// Returns NSString*. 
	[service xisupdate_tablet:self action:@selector(xisupdate_tabletHandler:) version: @""];

	// Returns NSString*. 
	[service xSendGetPasswordMail:self action:@selector(xSendGetPasswordMailHandler:) xemail: @"" EquipmentType: @""];
}

	

// Handle the response from xCheckLogin.
		
- (void) xCheckLoginHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the wcfKeyValueItem* result
		wcfKeyValueItem* result = (wcfKeyValueItem*)value;
	NSLog(@"xCheckLogin returned the value: %@", result);
			
}
	

// Handle the response from xClockIn.
		
- (void) xClockInHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		NSString* result = (NSString*)value;
	NSLog(@"xClockIn returned the value: %@", result);
			
}
	

// Handle the response from xClockOut.
		
- (void) xClockOutHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		NSString* result = (NSString*)value;
	NSLog(@"xClockOut returned the value: %@", result);
			
}
	

// Handle the response from xGetClockList.
		
- (void) xGetClockListHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the wcfClockRtn* result
		wcfClockRtn* result = (wcfClockRtn*)value;
	NSLog(@"xGetClockList returned the value: %@", result);
			
}
	

// Handle the response from xGetMasterCia.
		
- (void) xGetMasterCiaHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSMutableArray* result
		NSMutableArray* result = (NSMutableArray*)value;
	NSLog(@"xGetMasterCia returned the value: %@", result);
			
}
	

// Handle the response from xisupdate_android.
		
- (void) xisupdate_androidHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		NSString* result = (NSString*)value;
	NSLog(@"xisupdate_android returned the value: %@", result);
			
}
	

// Handle the response from xisupdate_ipad.
		
- (void) xisupdate_ipadHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		NSString* result = (NSString*)value;
	NSLog(@"xisupdate_ipad returned the value: %@", result);
			
}
	

// Handle the response from xisupdate_iphone.
		
- (void) xisupdate_iphoneHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		NSString* result = (NSString*)value;
	NSLog(@"xisupdate_iphone returned the value: %@", result);
			
}
	

// Handle the response from xisupdate_tablet.
		
- (void) xisupdate_tabletHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		NSString* result = (NSString*)value;
	NSLog(@"xisupdate_tablet returned the value: %@", result);
			
}
	

// Handle the response from xSendGetPasswordMail.
		
- (void) xSendGetPasswordMailHandler: (id) value {

	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}

	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
			

	// Do something with the NSString* result
		NSString* result = (NSString*)value;
	NSLog(@"xSendGetPasswordMail returned the value: %@", result);
			
}
	

@end
		