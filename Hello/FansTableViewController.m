//
//  FansTableViewController.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "FansTableViewController.h"
#import "FansTableViewCell.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "NSString+Extension.h"
#import "MBProgressHUD.h"


@interface FansTableViewController ()
{
    NSMutableArray *dataList;
    MBProgressHUD *HUD;
}

@end

@implementation FansTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.labelText = @"正在刷新，请等待...";
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    self.navigationItem.title = @"粉丝列表";
    
    dataList = [[NSMutableArray alloc] init];
    
    
    [HUD showWhileExecuting:@selector(waitLoadData) onTarget:self withObject:nil animated:YES];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)waitLoadData
{
    [self SendRequst];
    
}

-(void)SendRequst
{
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dicRequest = [NSMutableDictionary dictionary];
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"sinaweibo"];
    NSString *userID = [userDic objectForKey:@"userID"];
    [dicRequest setObject:userID  forKey:@"uid"];
    [dicRequest setObject:appDelegate.wbtoken forKey:@"access_token"];
    [dicRequest setObject:@"200" forKey:@"count"];
    
    
    [WBHttpRequest requestWithAccessToken:appDelegate.wbtoken url:SinaWeiBo_URL_FollowsList httpMethod:@"Get" params:dicRequest queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         [self RequestHanlderRefresh:httpRequest :result :error];
     }
     ];
    
}

- (void)RequestHanlderRefresh:(WBHttpRequest *)httpRequest :(id)result : (NSError *)error
{
    
    NSData *jsonData = [result JSONData];
    
    NSDictionary *dicResult = [jsonData objectFromJSONData];
    
    NSArray *userArray = [dicResult objectForKey:@"users"];
    
    
    for (NSDictionary *userDic in userArray)
    {
        FansModel *fansData = [[FansModel alloc] init];
        fansData.IconUrl = [userDic objectForKey:@"avatar_large"];
        fansData.Name = [NSString replaceUnicode:[userDic  objectForKey:@"screen_name"]];
        fansData.Descript = [NSString stringWithFormat:@"简介：%@", [NSString replaceUnicode:[userDic  objectForKey:@"description"]]];
        fansData.Source = [NSString replaceUnicode:[userDic objectForKey:@"location"]];
        
        [dataList addObject:fansData];
        
    }
    
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
////#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [dataList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 80;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuser = @"FansTableCell";
    FansTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuser];
    if(cell == nil)
    {
        cell = [[FansTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuser];
        
    }
    
    FansModel *fanData = [dataList objectAtIndex:[indexPath row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setFansFrame];
    [cell setFansData:fanData];
    
    //cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    //cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    

    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.

}


@end
