//
//  clocklist.m
//  BA-Clock
//
//  Created by roberto ramirez on 11/11/13.
//  Copyright (c) 2013 lovetthomes. All rights reserved.
//

#import "clocklist.h"
#import "Reachability.h"
#import "userInfo.h"
#import "Mysql.h"
#import "wcfService.h"
#import "CustomKeyboard.h"
#import "baControl.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "XYAlertView.h"
#import "XYAlertViewHeader.h"

@interface clocklist ()<UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, MBProgressHUDDelegate, XYAlertViewDelegate>

@end

@implementation clocklist{
    UITabBar *ntabbar;
    UIScrollView *uv;
    UITableView *ciatbview;
    wcfArrayOfClockInItem *rtnls;
    UISearchBar *searchBar;
    CustomKeyboard *keyboard;
    NSDate *day;
    NSDateFormatter *dateFormatter;
    int donext;
    CLLocationManager *locationManager;
    NSString *strlocation;
    MBProgressHUD *HUD;
    UIButton *btn1;
    UIButton *btn2;
    NSString *aid;
    UILabel *lbl;
    CLLocation *newLocation;
    int cnt;
    NSTimer *myTimer;
    XYAlertView*  talert;
    UIBarButtonItem * leftbtn;
    UIBarButtonItem * rightbtn;
}

@synthesize idmastercia;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        cnt =0;
    }
    return self;
}

-(void)loadView{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    self.view = view;
    
        if (view.frame.size.height>480) {
        ntabbar=[[UITabBar alloc]initWithFrame:CGRectMake(0, 370+84, 320, 50)];
    }else{
        
        ntabbar=[[UITabBar alloc]initWithFrame:CGRectMake(0, 366, 320, 50)];
    }
    [view addSubview:ntabbar];
    
    if (self.view.frame.size.height>480) {
        uv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 370+80)];
    }else{
        uv =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 364)];
    }
    
    [view addSubview:uv];
    
    view.backgroundColor=[UIColor whiteColor];
    
    [self.navigationItem setHidesBackButton:YES];
//    [self.navigationItem setLeftBarButtonItem:[self getbackButton]];
    
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [self dorefresh:nil];
//}

//-(IBAction)dorefresh:(id)sender{
//    searchBar.text=@"";
//    [HUD hide];
//    [HUD removeFromSuperViewOnHide];
//    [self getInfo];
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@">>" style:UIBarButtonItemStyleBordered target:self action:@selector(nextWeek:) ];
    self.navigationItem.rightBarButtonItem=anotherButton;
    leftbtn=anotherButton;
    anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"<<" style:UIBarButtonItemStyleBordered target:self action:@selector(previousWeek:) ];
    rightbtn=anotherButton;
    self.navigationItem.leftBarButtonItem=anotherButton;
 [self getInfo];
}


-(NSDate *)getdate:(int)nday{
    NSTimeInterval  interval = 24*60*60*nday;
   return  [day initWithTimeInterval:interval sinceDate:day];
}

-(IBAction)previousWeek:(UIButton *)sender{
    
    day =[self getdate:-7];
    donext=3;
    rightbtn.enabled=NO;
    leftbtn.enabled=NO;
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];[locationManager requestWhenInUseAuthorization];
        locationManager.delegate = self;
        locationManager.distanceFilter = 10; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    newLocation=nil;

    if ([CLLocationManager locationServicesEnabled]) {
        
        
        [locationManager startUpdatingLocation];
        myTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                   target:self
                                                 selector:@selector(doupdatecheck22222)
                                                 userInfo:nil
                                                  repeats:YES];
        
    }else{
        [HUD hide:YES];
        rightbtn.enabled=YES;
        leftbtn.enabled=YES;
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
        
        
        strlocation=nil;
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Please turn on Location Services in your device settings in order to Clock In/Out." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        locationManager=nil;
    }
}

-(IBAction)nextWeek:(UIButton *)sender{
    day =[self getdate:7];
    donext=4;
    rightbtn.enabled=NO;
    leftbtn.enabled=NO;
    
    if (!locationManager) {
        locationManager = [[CLLocationManager alloc] init];[locationManager requestWhenInUseAuthorization];
        locationManager.delegate = self;
        locationManager.distanceFilter = 10; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    newLocation=nil;

    
    if ([CLLocationManager locationServicesEnabled]) {
        
        
        [locationManager startUpdatingLocation];
        myTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                   target:self
                                                 selector:@selector(doupdatecheck22222)
                                                 userInfo:nil
                                                  repeats:YES];
        
    }else{
        [HUD hide:YES];
        rightbtn.enabled=YES;
        leftbtn.enabled=YES;
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
        
        
        strlocation=nil;
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Please turn on Location Services in your device settings in order to Clock In/Out." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
        locationManager=nil;
    }
}
-(void)getInfo{
    if (!lbl) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 42)];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        
        lbl.textAlignment=NSTextAlignmentCenter;
        lbl.textColor=[UIColor whiteColor];
        lbl.tag=14;
        
        //    lbl.textColor= [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0f];
        lbl.font=[UIFont boldSystemFontOfSize:12.0];
        lbl.backgroundColor=[UIColor clearColor];
        [titleView addSubview:lbl];
        lbl.numberOfLines=2;
        lbl.textAlignment=NSTextAlignmentCenter;
        self.navigationItem.titleView=titleView;
    }
    //     lbl.text=[NSString stringWithFormat:@"Last Sync\n%@", lastsync];
    if (!day) {
        day=[[NSDate alloc]init];
    }
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:day];
    int weekday = [componets weekday];
    
    NSDate *nsunday;
    NSDate *nStarday;
    nsunday=[self getdate:-(weekday-1)];
    nStarday=[self getdate:(7-weekday)];
   
    lbl.text=[NSString stringWithFormat:@"Time Period\n%@ - Thru - %@", [self stringFromDate1:nsunday], [self stringFromDate1:nStarday]];
    
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    lbl.textColor=[UIColor blackColor];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertView *alert=[self getErrorAlert:@"There is not available network!"];
        [alert show];
    }else{
        wcfService *service =[wcfService service];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
        //        NSLog(@"%@ %@ %@ %@", idmastercia, idrealtor, idguest, idcommunity);
        
        if (!day) {
            day=[[NSDate alloc]init];
        }
        
        NSString *tt = [self stringFromDate:day];
        [service xGetClockList:self action:@selector(xGetRealtorGuestLogHandler:) xemail:[userInfo getUserName] password:[userInfo getUserPwd] xmastercia:idmastercia tdate:tt EquipmentType:@"3"];
        
    }
    
}
-(NSDate *)dateFromString:(NSString *)str{
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    [dateFormatter setDateFormat: @"MM/dd/yyyy"];
    
    
    NSDate *destDate= [dateFormatter dateFromString:str];
    
    return destDate;
}

- (NSString *)stringFromDate1:(NSDate *)date{
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    [dateFormatter setDateFormat:@"MMM dd/yyyy"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}



- (void) xGetRealtorGuestLogHandler: (id) value {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // Handle errors
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
    
    wcfClockRtn *t = (wcfClockRtn *)value;
    rtnls =(wcfArrayOfClockInItem *)(t).Clockls;
//    NSLog(@"%@", rtnls);
      if (ciatbview) {
        [ciatbview reloadData];
        [ntabbar setSelectedItem:nil];
          
          
    }else{
        if (self.view.frame.size.height>480) {
            ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 408+40)];
            uv.contentSize=CGSizeMake(320.0,370+81);
        }else{
            ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 364)];
            uv.contentSize=CGSizeMake(320.0,365);
        }
        ciatbview.rowHeight=66;
        ciatbview.tag=2;
        [uv addSubview:ciatbview];
        ciatbview.delegate = self;
        ciatbview.dataSource = self;
        
        btn1 = [baControl getGrayButton];
        [btn1 setFrame:CGRectMake(5, 5, 150, 40)];
        
        
        [ntabbar addSubview:btn1];
        
        
        btn2 = [baControl getGrayButton];
        [btn2 setFrame:CGRectMake(165, 5, 150, 40)];
        [btn2 setTitle:@"Exit" forState:UIControlStateNormal];
       [btn2 addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchDown];
        [ntabbar addSubview:btn2];
        
    }
   

    if (t.btnClockIn) {
        btn1.hidden=NO;
        [btn1 setTitle:@"Clock In" forState:UIControlStateNormal];
         [btn1 setBackgroundImage:[[UIImage imageNamed:@"greenButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(docheckIn) forControlEvents:UIControlEventTouchDown];
        
    }else if (t.btnClockOut) {
         btn1.hidden=NO;
        [btn1 setTitle:@"Clock Out" forState:UIControlStateNormal];
         [btn1 setBackgroundImage:[[UIImage imageNamed:@"redButton.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(docheckOut) forControlEvents:UIControlEventTouchDown];
    }else{
        btn1.hidden=YES;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [rtnls count]; // or self.items.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        
    }
    
    
    
    wcfClockInItem  *cia =[rtnls objectAtIndex:indexPath.row];
    //    if (cia.TimeIn) {
    //        cell.textLabel.text = [NSString stringWithFormat:@"%@                 %@", cia.sDate, cia.Time];
    //    }else{
    //        cell.textLabel.text = [NSString stringWithFormat:@"%@                    %@", cia.sDate, cia.Time];
    //    }
    NSMutableString *t=[[NSMutableString alloc]init];
    [t appendString:cia.sDate];
    
    CGSize gi1 = [cia.sDate sizeWithFont:[UIFont boldSystemFontOfSize:17.0]];
    CGSize gi2 = [cia.Time sizeWithFont:[UIFont boldSystemFontOfSize:17.0]];
    int ddd= 280-gi1.width-gi2.width;
    int i = ddd/5;
    for (int j=0; j<i; j++) {
        [t appendString:@" "];
    }
    [t appendString:cia.Time];
    cell.textLabel.text=t;
    
    //    gi1 = [t sizeWithFont:[UIFont boldSystemFontOfSize:17.0]];
    //    NSLog(@"%f", gi1.width);
    //    cell.detailTextLabel.numberOfLines=2;
    if (indexPath.row!=[rtnls count]-1) {
        
        if (cia.TimeIn && cia.TimeOut) {
            cell.detailTextLabel.text=[NSString stringWithFormat:@"Clock In: %@    Clock out: %@", cia.TimeIn, cia.TimeOut];
        }else  if (cia.TimeIn) {
            cell.detailTextLabel.text=[NSString stringWithFormat:@"Clock In: %@  ", cia.TimeIn];
            
            
            aid=cia.Idnumber;
            
        }
    }else{
        cell.detailTextLabel.text=nil;
    }
    
    
    //
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    [cell .imageView setImage:nil];
    
    return cell;
    
    
}


-(void)docheckIn{
    donext=1;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText=@"   Clocking In...   ";
    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
    [self doupdatecheck1];
}


-(void)docheckOut{
    donext=2;
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText=@"   Clocking Out...   ";
    HUD.dimBackground = YES;
    HUD.delegate = self;
    [HUD show:YES];
    [self doupdatecheck1];
}



-(void)doupdatecheck1{
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
        
        
        //        [HUD removeFromSuperViewOnHide];
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
    }else{
        wcfService* service = [wcfService service];
        NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [service xisupdate_iphone:self action:@selector(xisupdate_iphoneHandler777777:) version:version];
    }

}




- (void) xisupdate_iphoneHandler777777: (id) value {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    // Handle errors
    if([value isKindOfClass:[NSError class]]) {
        [HUD hide];
        [HUD removeFromSuperViewOnHide];
        NSError *error = value;
        NSLog(@"%@", [error localizedDescription]);
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
        return;
    }
    
    // Handle faults
    if([value isKindOfClass:[SoapFault class]]) {
        [HUD hide];
        [HUD removeFromSuperViewOnHide];
        SoapFault *sf =value;
        NSLog(@"%@", [sf description]);
        UIAlertView *alert = [self getErrorAlert: value];
        [alert show];
        return;
    }
    if(donext==-1){
        return;
    }else if (donext==3 || donext==4) {
        [self getInfo];
    }else{
        if (!locationManager) {
            locationManager = [[CLLocationManager alloc] init];[locationManager requestWhenInUseAuthorization];
            locationManager.delegate = self;
            locationManager.distanceFilter = 10; // whenever we move
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        }
        
        newLocation=nil;
        
        if ([CLLocationManager locationServicesEnabled]) {
            
          
            [locationManager startUpdatingLocation];
            myTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                       target:self
                                                     selector:@selector(doupdatecheck22222)
                                                     userInfo:nil
                                                      repeats:YES];
            
        }else{
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

            
            strlocation=nil;
            UIAlertView *errorAlert = [[UIAlertView alloc]
                                       initWithTitle:@"Error" message:@"Please turn on Location Services in your device settings in order to Clock In/Out." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
            locationManager=nil;
        }
    }
    
}

-(void)doupdatecheck22222{
  
    leftbtn.enabled=YES;
    rightbtn.enabled=YES;
    [myTimer invalidate];
    
   
    
    
    [locationManager stopUpdatingLocation];
    locationManager=nil;
    if (newLocation) {
        [self doupdate8888888];
    
    }else{
        strlocation=nil;
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
        
        UIAlertView *errorAlert = [[UIAlertView alloc]
                                   initWithTitle:@"Error" message:@"Cannot get you gps location from Location Services in your device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [errorAlert show];
    }
    
}
-(void)doupdate8888888{
    if (newLocation != nil ) {
        
        strlocation=[NSString stringWithFormat:@"lng=%.20f lat=%.20f", newLocation.coordinate.longitude, newLocation.coordinate.latitude];
        [locationManager stopUpdatingLocation];
        wcfService* service = [wcfService service];
        
        if (donext==1) {
            [service xClockIn:self action:@selector(xClockInHandler:) xemail:[userInfo getUserName] password:[userInfo getUserPwd] xmastercia:idmastercia gis:strlocation EquipmentType:@"3"];
        }else{
            [service xClockOut:self action:@selector(xClockInHandler:) xemail:[userInfo getUserName] password:[userInfo getUserPwd] xid:aid gis:strlocation EquipmentType:@"3"];
        }
        
    }else{
        strlocation=nil;
    }
}

- (void) xClockInHandler: (id) value {
    [HUD hide];
    // Handle errors
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
   
    [HUD removeFromSuperview];
    NSString *rtn =(NSString *)value;
    
    if(![rtn isEqualToString:@"1"]){
        UIAlertView *alert = [self getErrorAlert: @"Internet Connection Error."];
        [alert show];
    }else{
        
        if (donext==1) {
            donext=-1;
//            [self dorefresh:nil];
            
           talert= XYShowAlert(@"Clock In\nSuccessfully!");
            talert.delegate=self;
            
        }else{
            donext=-1;
            talert= XYShowAlert(@"Clock Out\nSuccessfully!");
            talert.delegate=self;
            
           
        }
    }
    

}

-(void)doclosealert{
    [self logout:nil];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    newLocation = [locations lastObject];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    [HUD hide:YES];
//    for (UIWindow* window in [UIApplication sharedApplication].windows) {
//        NSArray* subviews = window.subviews;
//        if ([subviews count] > 0){
//            for (UIAlertView* cc in subviews) {
//                if ([cc isKindOfClass:[UIAlertView class]]) {
//                    [cc dismissWithClickedButtonIndex:0 animated:YES];
//                    
//                }
//            }
//        }
//        
//    }
    
    
    NSLog(@"didFailWithError: %@", error);
    
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
