//
//  Login.m
//  BuildersAccessPo
//
//  Created by amy zhao on 13-3-1.
//  Copyright (c) 2013年 eloveit. All rights reserved.
//
#import "Mysql.h"
#import "Login.h"
#import "wcfService.h"
#import "forgetPs.h"
//#import "cl_cia.h"
//#import "cl_project.h"
//#import "cl_pin.h"
//#import "mainmenu.h"
#import "Reachability.h"
//#import "cl_sync.h"
//#import "cl_favorite.h"
//#import "cl_phone.h"
//#import "cl_vendor.h"
//#import "cl_reason.h"
//#import "mainmenu.h"
//#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "baControl.h"
#import "mastercialist.h"
#import "clocklist.h"

#define NAVBAR_HEIGHT   44
#define PROMPT_HEIGHT   70
#define DIGIT_SPACING   10
#define DIGIT_WIDTH     61
#define DIGIT_HEIGHT    40
#define MARKER_WIDTH    16
#define MARKER_HEIGHT   16
#define MARKER_X        22
#define MARKER_Y        18
#define MESSAGE_HEIGHT  74
#define FAILED_LCAP     19
#define FAILED_RCAP     19
#define FAILED_HEIGHT   26
#define FAILED_MARGIN   10
#define TEXTFIELD_MARGIN 8
#define SLIDE_DURATION  0.3

@interface Login (){
    
}
@end


int xget;

@implementation Login{
    UISwitch *switchView;
    NSString     *name;
    BOOL transiting;
    BOOL isenter;

}
@synthesize usernameField;
@synthesize passwordField;
//@synthesize checkButton;
@synthesize ischecked;
@synthesize pwd, ddpicker, pickerArray;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    
    self.title=@"BA Clock";
    
    [self doInitPage];
	self.ischecked = NO;
    
	NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        //NSData *reader = [NSData dataWithContentsOfFile:filePath];
		NSArray *arr = [[NSArray alloc] initWithContentsOfFile:filePath];
		self.usernameField.text = [arr objectAtIndex:0];
		self.pwd=[arr objectAtIndex:1];
        name=self.usernameField.text;
        
		self.passwordField.text = @"******";
		self.ischecked=YES;
		switchView.on=YES;
    }
     UIColor * cg1 =[UIColor whiteColor] ;
    UIColor * cg = [UIColor lightGrayColor];
    [[UITabBar appearance] setTintColor:cg];
//   
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      cg1, UITextAttributeTextColor,
      [UIFont boldSystemFontOfSize:9.0], UITextAttributeFont,
      [UIColor darkGrayColor], UITextAttributeTextShadowColor,
      nil] forState:UIControlStateNormal];
    
    [[UIToolbar appearance] setTintColor:cg];    
    
    self.navigationController.navigationBar.tintColor = cg;
      [[UISearchBar appearance] setTintColor:cg];
    keyboard=[[CustomKeyboard alloc]init];
    keyboard.delegate=self;
    [usernameField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:NO :TRUE]];
    [passwordField setInputAccessoryView:[keyboard getToolbarWithPrevNextDone:TRUE :NO]];
    
    isenter=YES;
}
-(void)viewWillAppear:(BOOL)animated{
    if (!ischecked) {
        passwordField.text=@"";
    }
    transiting=NO;
}


// custom keyboard
- (void)nextClicked{
    [passwordField becomeFirstResponder];
}

- (void)previousClicked{
    [usernameField becomeFirstResponder];
}

- (void)doneClicked{
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
}

-(void)doInitPage{
    
    UIScrollView *sv = (UIScrollView *)[self.view viewWithTag:1];
    int x=0;
    int y=10;
    if (self.view.frame.size.height>480) {
        sv.contentSize=CGSizeMake(320.0,425.0+80);
        y=y+20;
        x=10;
    }else{
        sv.contentSize=CGSizeMake(320.0,425.0);
        x=5;
    }
    
    UILabel *lbl;
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(20, y, 300, 21)];
    lbl.text=@"Email";
    [sv addSubview:lbl];
    y=y+21+x;
    
    usernameField=[[UITextField alloc]initWithFrame:CGRectMake(20, y, 280, 30)];
    [usernameField setBorderStyle:UITextBorderStyleRoundedRect];
    [usernameField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    usernameField.returnKeyType=UIReturnKeyDone;
    [sv addSubview: usernameField];
    y=y+30+x+5;
    
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(20, y, 300, 21)];
    lbl.text=@"Password";
    [sv addSubview:lbl];
    y=y+21+x;
    
    passwordField=[[UITextField alloc]initWithFrame:CGRectMake(20, y, 280, 30)];
    [passwordField setBorderStyle:UITextBorderStyleRoundedRect];
    [passwordField addTarget:self action:@selector(textFieldDoneEditing:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [passwordField setSecureTextEntry:YES];
    [sv addSubview: passwordField];
    y=y+30+x+15;
        
    
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(20, y, 280, 36)];
    lbl.layer.cornerRadius=10.0;
    lbl.layer.borderWidth=1.0f;
    lbl.layer.borderColor=[UIColor lightGrayColor].CGColor;
    //    usernameField.returnKeyType=UIReturnKeyDone;
    [sv addSubview: lbl];
   
    
    lbl =[[UILabel alloc]initWithFrame:CGRectMake(28, y+8, 120, 21)];
    lbl.text=@"Remember Me";
    [sv addSubview:lbl];
    
     switchView= [[UISwitch alloc] initWithFrame:CGRectMake(220.0f, y+4, 100.0f, 28.0f)];
    switchView.on = NO;
    [sv addSubview:switchView];
    [switchView addTarget:self action:@selector(CheckboxClicked:) forControlEvents:UIControlEventValueChanged];
     y=y+70+x;
    
    UIButton *btn1 = [baControl getGrayButton];
    [btn1 setFrame:CGRectMake(20, y, 280, 44)];
    [btn1 setTitle:@"Clock In/Out" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
    
    y=y+50+x;
    
    y=y+30+x;
    
    btn1 =[baControl getGrayButton];
    [btn1 setFrame:CGRectMake(20, y, 280, 44)];
    [btn1 setTitle:@"Forgot Your Password" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(ForgotPasOnclick:) forControlEvents:UIControlEventTouchDown];
    [sv addSubview:btn1];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}




-(IBAction)popupscreen2:(id)sender{
    
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self
                                                    cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Select",@"Cancel", nil];
    [actionSheet setTag:2];
    
    if (ddpicker ==nil) {
        ddpicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        pickerArray = [NSArray arrayWithObjects:@"Builder", nil];
        ddpicker.showsSelectionIndicator = YES;
        
        ddpicker.delegate = self;
        ddpicker.dataSource = self;
        
    }
    [actionSheet addSubview:ddpicker];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view]; // show from our table view (pops up in the middle of the table)
    
    int y=0;
    if (self.view.frame.size.height>480) {
        y=80;
    }
    
    [actionSheet setFrame:CGRectMake(0, 177+y, 320, 383)];
    
    [[[actionSheet subviews]objectAtIndex:0] setFrame:CGRectMake(20,180, 120, 46)];
    [[[actionSheet subviews]objectAtIndex:1] setFrame:CGRectMake(180,180, 120, 46)];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"save"];
}

- (void)creatFiles: (NSString *)pwd1 {
    
    NSString *user_name = [Mysql TrimText:self.usernameField.text];
    NSString *filePath = [self dataFilePath];
	//NSFileManager *fileManager =[NSFileManager defaultManager];
	if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
		NSError* error;
		[[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
	}
	//NSData *data = (NSData *)[self TrimText:self.usernameField.text];
	//[fileManager createFileAtPath:filePath contents:data attributes:nil];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:user_name];
	[array addObject:pwd1];
    [array writeToFile:filePath atomically:YES];
    
}

- (IBAction) ForgotPasOnclick: (id) sender{
    if (transiting) {
        return;
    }else{
        transiting=YES;
        forgetPs *fp = [forgetPs alloc];
        fp.managedObjectContext=self.managedObjectContext;
        [self.navigationController pushViewController:fp animated:YES];
    }
}

- (IBAction) CheckboxClicked : (id) sender{
    if (ischecked == NO) {
		self.ischecked=YES;
	}else {
		self.ischecked=NO;        
        NSString *filePath = [self dataFilePath];
        if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
            NSError* error;
            [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
        }
        
        passwordField.text=@"";
        
        [self deletealldata];
	}
}

-(void)deletealldata{
    
}
- (IBAction) login: (UIButton *) sender{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText=@"   Login...   ";
    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
    
    [self autoUpd];
}

-(void)autoUpd{

    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
       [HUD hide:YES];
        for (UIWindow* window in [UIApplication sharedApplication].windows) {
            NSArray* subviews = window.subviews;
            if ([subviews count] > 0){
                for (UIAlertView* cc in subviews) {
                    if ([cc isKindOfClass:[UIAlertView class]]) {
                        [cc dismissWithClickedButtonIndex:0 animated:YES];
                        
                    }
                }
            }
            
        }

        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        
        transiting=NO;
    }else{
        wcfService* service = [wcfService service];
        NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
           [service xisupdate_iphone:self action:@selector(xisupdate_iphoneHandler:) version:version];
            
    }
}
- (void) xisupdate_iphoneHandler: (id) value {
   
        
    
    
// Handle errors
if([value isKindOfClass:[NSError class]]) {
    NSError *error = value;
    NSLog(@"%@", [error localizedDescription]);
    [HUD hide:YES];
    
    
    UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
    [alert show];
    
    transiting=NO;
    return;
}

// Handle faults
if([value isKindOfClass:[SoapFault class]]) {
    SoapFault *sf =value;
    NSLog(@"%@", [sf description]);
    [HUD hide:YES];
    UIAlertView *alert = [self getErrorAlert: value];
    [alert show];
    transiting=NO;
    return;
}

    NSString* result = (NSString*)value;
    if ([result isEqualToString:@"1"]) {
        [HUD hide:YES];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=http://www.buildersaccess.com/iphone/BA-Clock.plist"]];
        
    }else{
        [self doLogin];
    }


}
- (void) doLogin{
    if (transiting) {
        return;
    }else{
        transiting=YES;
    }
    
	NSString *user_name = [Mysql TrimText:self.usernameField.text];
    NSString *pass_word = [Mysql TrimText:self.passwordField.text];
	if (user_name.length==0){
        [HUD hide:YES];
		UIAlertView *alert = [self getErrorAlert: @"Please Input All Fields"];
        [alert show];
        [usernameField becomeFirstResponder];
        transiting=NO;
	}else if(pass_word.length==0){
        [HUD hide:YES];
        UIAlertView *alert = [self getErrorAlert: @"Please Input All Fields"];
        [alert show];
		
        [passwordField becomeFirstResponder];
        transiting=NO;
    }else if ([Mysql IsEmail:user_name]==NO) {
        [HUD hide:YES];
        UIAlertView *alert = [self getErrorAlert: @"Please Input invalid email"];
        [alert show];
        [usernameField becomeFirstResponder];
        transiting=NO;
	} else{
        
        NSString *myMD5Pas;
		if (self.pwd != nil && [pass_word isEqualToString:@"******"]==YES) {
			myMD5Pas = pwd;
		} else {
			myMD5Pas = [Mysql md5:pass_word];
		}
//        NSLog(@"%@", myMD5Pas);
        Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
        NetworkStatus netStatus = [curReach currentReachabilityStatus];
        if (netStatus ==NotReachable) {
            [HUD hide:YES];
            UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
            [alert show];
            transiting=NO;
        }else{
            wcfService* service = [wcfService service];
            
            [service xCheckLogin:self action:@selector(xCheckLoginHandler:) xemail: user_name xpassword: myMD5Pas EquipmentType:@"3"];
        }
	}
}

- (void) xCheckLoginHandler: (id) value {
    [HUD hide:YES];
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        
        
        NSError *error = value;
        NSLog(@"%@", [error localizedDescription]);
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        transiting=NO;
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        SoapFault *sf =value;
        NSLog(@"%@", [sf description]);
        UIAlertView *alert = [self getErrorAlert: value];
        [alert show];
        transiting=NO;
        return;
    }
    
    wcfKeyValueItem* result = (wcfKeyValueItem*)value;
    
    if (![result.Key isEqualToString:@"0"] ){
        xget=[result.Key intValue];
        NSString *user_name = [Mysql TrimText:self.usernameField.text];        
        
        NSString *pass_word = [Mysql TrimText:self.passwordField.text];
        NSString *myMD5Pas;
        if (self.pwd != nil && [pass_word isEqualToString:@"******"]==YES) {
            myMD5Pas = pwd;
        } else {
            myMD5Pas = [Mysql md5:pass_word];
        }
        
        if (self.ischecked == YES) {
            
            if (self.pwd == nil) {
                [self creatFiles:myMD5Pas];
            } else if ([pass_word isEqualToString:@"******"]==NO || ![name isEqualToString:user_name]) {
                [self creatFiles:myMD5Pas];
            }
            
            [userInfo setUserName:user_name andPwd:myMD5Pas];
            [userInfo inituserNameServer:result.Value];
            
            [self getMasterCialist];
            
            
        }else {
            [userInfo setUserName:user_name andPwd:myMD5Pas];
            
            NSString *filePath = [self dataFilePath];
            if ([[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
                NSError* error;
                [[NSFileManager defaultManager]removeItemAtPath:filePath error:&error];
            }
            
            [self getMasterCialist];
        }
        
    }else{
        UIAlertView *alert = [self getErrorAlert: @"Email and Password not found"];
        [alert show];
        [usernameField becomeFirstResponder];
        transiting=NO;
        return;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (alertView.tag == 0) {
        switch (buttonIndex) {
			case 0:
                transiting=NO;
				break;
			default:
                break;
		}
		return;
	}
}


-(void)getMasterCialist{

    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alert=[self getErrorAlert:@"There is not available network!"];
        [alert show];
    }else{
        wcfService *service =[wcfService service];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        [service xGetMasterCia:self action:@selector(xGetMasterCiaHandler:) xemail:[userInfo getUserName] password:[userInfo getUserPwd]  EquipmentType:@"3"];
    }
    


}


- (void) xGetMasterCiaHandler: (id) value {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	if([value isKindOfClass:[NSError class]]) {
        NSError *error = value;
        NSLog(@"%@", [error localizedDescription]);
        
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        SoapFault *sf =value;
        
        NSLog(@"%@", [sf description]);
        UIAlertView *alert = [self getErrorAlert: value];
        [alert show];
        
        return;
    }
    
    // Do something with the NSMutableArray* result
    wcfArrayOfKeyValueItem *ttt = (wcfArrayOfKeyValueItem*)value;
    if ([ttt count]>1) {
        wcfKeyValueItem *kv =[ttt objectAtIndex:0];
//        NSLog(@"%@", kv);
        if ([kv.Key isEqualToString:@"1"]) {
            wcfKeyValueItem *kv =[ttt objectAtIndex:0];
            [userInfo initCiaInfo:[kv.Key intValue] andNm:kv.Value];
            clocklist *cl=[clocklist alloc];
            cl.managedObjectContext=self.managedObjectContext;
            cl.idmastercia=kv.Key;
            [self.navigationController pushViewController:cl animated:YES];
        }else{
            mastercialist *ml =[self.storyboard instantiateViewControllerWithIdentifier:@"mastercialist"];
            ml.managedObjectContext=self.managedObjectContext;
            ml.rtnlist=[ttt toMutableArray];
            ml.rtnlist1=ml.rtnlist;
            [self.navigationController pushViewController:ml animated:YES];
        }
    }else{
        wcfKeyValueItem *kv =[ttt objectAtIndex:0];
        [userInfo initCiaInfo:[kv.Key intValue] andNm:kv.Value];
        
        clocklist *cl=[clocklist alloc];
        cl.managedObjectContext=self.managedObjectContext;
        cl.idmastercia=kv.Key;
//        cl.day=@"11/11/2013";
        [self.navigationController pushViewController:cl animated:YES];
    }    
}

- (IBAction)textFieldDoneEditing:(id)sender {
	[sender resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

@end
