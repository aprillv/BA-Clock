/*
	wcfKeyValueItem.h
	The interface definition of properties and methods for the wcfKeyValueItem object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface wcfKeyValueItem : SoapObject
{
	NSString* _Key;
	NSString* _Value;
	
}
		
	@property (retain, nonatomic) NSString* Key;
	@property (retain, nonatomic) NSString* Value;

	+ (wcfKeyValueItem*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
