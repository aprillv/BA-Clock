//
//  mastercialist.m
//  BuildersAccess
//
//  Created by amy zhao on 13-4-2.
//  Copyright (c) 2013年 eloveit. All rights reserved.
//

#import "mastercialist.h"
#import "Mysql.h"
#import <QuartzCore/QuartzCore.h>
#import "userInfo.h"
#import "wcfKeyValueItem.h"
//#import "forapprove.h"
#import "wcfService.h"
#import "Reachability.h"
//#import "cl_phone.h"
//#import "cl_sync.h"
//#import "phonelist.h"
#import "MBProgressHUD.h"
//#import "multiSearch.h"
#import "clocklist.h"

@interface mastercialist ()<MBProgressHUDDelegate, UITabBarDelegate>

@end

@implementation mastercialist{
    MBProgressHUD *HUD;
}

@synthesize ntabbar, searchtxt, rtnlist, rtnlist1, type;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title=@"Select a Company";
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationItem setLeftBarButtonItem:[self getbackButton]];
    
    rtnlist1=rtnlist;

//    [[ntabbar.items objectAtIndex:0]setImage:[UIImage imageNamed:@"home.png"] ];
//    [[ntabbar.items objectAtIndex:0]setTitle:@"Home" ];
//    [[ntabbar.items objectAtIndex:0]setAction:@selector(gohome:) ];
    for (int i=0; i<3; i++) {
        [[ntabbar.items objectAtIndex:i]setImage:nil ];
        [[ntabbar.items objectAtIndex:i]setTitle:nil ];
        [[ntabbar.items objectAtIndex:i]setEnabled:NO ];
    }
   
//    [[ntabbar.items objectAtIndex:2]setImage:nil ];
//    [[ntabbar.items objectAtIndex:2]setTitle:nil ];
//    [[ntabbar.items objectAtIndex:2]setEnabled:NO ];
    [[ntabbar.items objectAtIndex:3]setImage:[UIImage imageNamed:@"refresh3.png"] ];
    [[ntabbar.items objectAtIndex:3]setTitle:@"Refresh" ];
    ntabbar.delegate = self;
//    [[ntabbar.items objectAtIndex:3]setAction:@selector(dorefresh:) ];
    
    searchtxt.delegate=self;
    keyboard=[[CustomKeyboard alloc]init];
    keyboard.delegate=self;
    [searchtxt setInputAccessoryView:[keyboard getToolbarWithDone]];
    
   
//    sv.backgroundColor=[Mysql groupTableViewBackgroundColor];
    
    
    if (rtnlist) {
        [self fullpage];
    }else{
        [self dorefresh:nil];
    
    }
    
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([item.title isEqualToString:@"Refresh"]) {
        [self dorefresh:item];
    }
}
- (void)doneClicked{
    [searchtxt resignFirstResponder];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchtxt resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    UITableView *tbview=(UITableView *)[self.view viewWithTag:2];

    NSString *str;
    str=[NSString stringWithFormat:@"Key like '%@*' or Value like [c]'*%@*'", searchtxt.text, searchtxt.text];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: str];
    rtnlist=[[rtnlist1 filteredArrayUsingPredicate:predicate] mutableCopy];
    [tbview reloadData];
    
}


-(IBAction)dorefresh:(id)sender{
    
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
    }else{
        wcfService* service = [wcfService service];
        NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [service xisupdate_iphone:self action:@selector(xisupdate_iphoneHandler:) version:version];
    }
}
- (void) xisupdate_iphoneHandler: (id) value {
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
    
    NSString* result = (NSString*)value;
    if ([result isEqualToString:@"1"]) {
        
        //        UIAlertView *alert = nil;
        //        alert = [[UIAlertView alloc]
        //                 initWithTitle:@"BuildersAccess"
        //                 message:@"There is a new version?"
        //                 delegate:self
        //                 cancelButtonTitle:@"Cancel"
        //                 otherButtonTitles:@"Ok", nil];
        //        alert.tag = 1;
        //        [alert show];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=http://www.buildersaccess.com/iphone/BA-Clock.plist"]];
        
    }else{
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
    self.rtnlist =[(wcfArrayOfKeyValueItem*)value toMutableArray];
    rtnlist1=rtnlist;
       
    [self fullpage];
  
    
	
    
   
}

-(void)fullpage{
    if (ciatbview) {
        searchtxt.text=@"";
        [ciatbview reloadData];
        [ntabbar setSelectedItem:nil];
    }else{
        UIScrollView *sv = (UIScrollView *)[self.view viewWithTag:1];
        if (self.view.frame.size.height>480) {
            ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 325+87)];
            sv.contentSize=CGSizeMake(320.0,326+87);
        }else{
            ciatbview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 325)];
            sv.contentSize=CGSizeMake(320.0,326);
        }
        ciatbview.tag=2;
        [sv addSubview:ciatbview];
        ciatbview.delegate = self;
        ciatbview.dataSource = self;
    }

}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.rtnlist count]; // or self.items.count;
    
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
    
    wcfKeyValueItem *cia =[rtnlist objectAtIndex:indexPath.row];
    
    cell.textLabel.text = cia.Value;
  
    
    [cell .imageView setImage:nil];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Reachability* curReach  = [Reachability reachabilityWithHostName: @"ws.buildersaccess.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus ==NotReachable) {
        UIAlertView *alert=[self getErrorAlert:@"We are temporarily unable to connect to BuildersAccess, please check your internet connection and try again. Thanks for your patience."];
        [alert show];
    }else{
        wcfService* service = [wcfService service];
        NSString*   version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [service xisupdate_iphone:self action:@selector(xisupdate_iphoneHandler1:) version:version];
    }
}
- (void) xisupdate_iphoneHandler1: (id) value {
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
    
    NSString* result = (NSString*)value;
    if ([result isEqualToString:@"1"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=http://www.buildersaccess.com/iphone/BA-Clock.plist"]];
        
    }else {
        NSIndexPath *indexPath = [ciatbview indexPathForSelectedRow];
        
        [ciatbview deselectRowAtIndexPath:indexPath animated:YES];
        
        wcfKeyValueItem *kv =[rtnlist objectAtIndex:indexPath.row];
        [userInfo initCiaInfo:[kv.Key intValue] andNm:kv.Value];
        
        clocklist *cl=[clocklist alloc];
        cl.managedObjectContext=self.managedObjectContext;
        cl.idmastercia=kv.Key;
//        cl.day=@"11/11/2013";
        [self.navigationController pushViewController:cl animated:YES];
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
