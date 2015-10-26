//
//  HomePageViewController.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "HomePageViewController.h"
#import "TableViewCell.h"
#import "HomeCellModel.h"
#import "HomeCellFrame.h"
#import "Reachability.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "FCXRefreshHeaderView.h"
#import "FCXRefreshFooterView.h"
#import "UIScrollView+FCXRefresh.h"
#import "NSString+Extension.h"
#import "HomeDetailViewController.h"
#import "MapLocatView.h"
#import "ZoomImage.h"
#import "JSHpple.h"
#import "AsynImageView.h"
#import "HomeUserInfoViewController.h"
#import "MBProgressHUD.h"
//#import <libkern>

@interface HomePageViewController () <UITableViewDelegate, UITableViewDataSource, WBHttpRequestDelegate, TableViewDelegate>
{
    FCXRefreshHeaderView *headerView;
    FCXRefreshFooterView *footerView;
    NSInteger totalRow;
    
    MBProgressHUD *waitView;
}

@end

@implementation HomePageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    self.CellList = [[NSMutableArray alloc] init];
    
    self.StatuseList = [[NSMutableArray alloc] init];
    
    self.navigationItem.title = @"南宫勇少";
    

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _dicRequestPara = [NSMutableDictionary dictionary];
    [_dicRequestPara setObject:appDelegate.wbtoken forKey:@"access_token"];
    
    [self addRefreshView];
    
 
    
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(void)beginWaiting:(NSString *)message
{
    waitView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:waitView];
    waitView.delegate = self;
    waitView.labelText = message;
    waitView.square = NO;
    [waitView show:YES];
}

-(void)endWaiting
{
    [waitView hide:YES afterDelay:.5];
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//}

-(void)addRefreshView
{
    __weak __typeof(self)weakSelf = self;
    
    headerView = [self.tableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView)
                  {
                      [weakSelf refreshAction];
                  }];
    
    footerView = [self.tableView addFooterWithRefreshHandler:^(FCXRefreshBaseView *refreshView)
    {
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [weakSelf.dicRequestPara setObject:appDelegate.wbtoken forKey:@"access_token"];
        //[weakSelf.dicRequestPara setObject:@"100" forKey:@"count"];
        if([weakSelf.StatuseList count] >1)
        {
            NSNumber *longid = [[NSUserDefaults standardUserDefaults] objectForKey:@"Next"];//[[weakSelf.StatuseList lastObject] objectForKey:@"idstr"];
            if([longid longValue] == 0)
            {
                [footerView showNoMoreData];
                [footerView endRefresh];
                
                return ;
            }
            [weakSelf.dicRequestPara setObject:[longid stringValue] forKey:@"max_id"];
        }
        
        [weakSelf SendRequst];
                      
    }];
    
    footerView.autoLoadMore = YES;
}

- (void)refreshAction {
    //__weak UITableView *weakTableView = self.tableView;
    //__weak FCXRefreshHeaderView *weakHeaderView = headerView;
    __weak __typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [weakSelf.dicRequestPara setObject:appDelegate.wbtoken forKey:@"access_token"];
        [weakSelf.dicRequestPara setObject:@"100" forKey:@"count"];
        if([weakSelf.StatuseList count] >1)
        {
            NSString *strid = [[weakSelf.StatuseList firstObject] objectForKey:@"idstr"];
            
            if([strid longLongValue] == 0)
            {
                [headerView endRefresh];
                return ;
            }
            [weakSelf.dicRequestPara setObject:strid forKey:@"since_id"];
        }
        
        [weakSelf SendRequst];

    });
}


-(void)SendRequst
{
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];

    
    [WBHttpRequest requestWithAccessToken:appDelegate.wbtoken url:SinaWeiBo_URL_Statuses_home httpMethod:@"Get" params:_dicRequestPara queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         [self RequestHanlderRefresh:httpRequest :result :error];
     }
     ];

}

- (void)RequestHanlderRefresh:(WBHttpRequest *)httpRequest :(id)result : (NSError *)error
{
    NSData *jsonData = [result JSONData];
    
    
    NSDictionary *dicResult = [jsonData objectFromJSONData];
    
    NSArray *tempArray = [dicResult objectForKey:@"statuses"];
    
    [[NSUserDefaults standardUserDefaults] setObject:[dicResult objectForKey:@"next_cursor"] forKey:@"Next"];
    
    
    
    for (NSDictionary *Statuses in tempArray)
    {
        HomeCellModel *cellUser = [[HomeCellModel alloc] init];
        NSDictionary *UserDic = [Statuses objectForKey:@"user"];
        [cellUser setName:[NSString replaceUnicode:[UserDic objectForKey:@"screen_name"]]];
        [cellUser setIcon:[UserDic objectForKey:@"avatar_hd"]];
            
        NSString *stringTime = [Statuses objectForKey:@"created_at"];
        NSMutableString *strsource = [self GetTime:stringTime];
        
        NSMutableString *arrysource = [self GetSource:[Statuses objectForKey:@"source"]];
        [strsource appendFormat:@"     %@",arrysource];
        [cellUser setTimesource:strsource];
            
        cellUser.blVip = [[UserDic valueForKey:@"verified"] boolValue];
        
        NSString *strDetail = [Statuses objectForKey:@"text"];
                
        [cellUser setDetail:[NSString replaceUnicode:strDetail]];
                
        NSArray *arrayPic = [Statuses objectForKey:@"pic_urls"];
        if([arrayPic count] > 0)
        {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arrayPic count]];
            for (NSDictionary *picDic in arrayPic)
            {
                NSMutableString *stringPic = [picDic objectForKey:@"thumbnail_pic"];
//                NSString *strout = [stringPic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
//                [array addObject:strout];
                
                [array addObject:stringPic];
            }
                    
            cellUser.pictureArray = [array mutableCopy];
        }
        
        NSDictionary *retweetDic = [Statuses objectForKey:@"retweeted_status"];
        if(retweetDic != nil) //有转发
        {
            NSString *strRetweetDetail = [retweetDic objectForKey:@"text"];
            [cellUser setRetweetDetail:[NSString replaceUnicode:strRetweetDetail]];
            
            NSArray *arryRetweetPic = [retweetDic objectForKey:@"pic_urls"];
            if([arryRetweetPic count] > 0)
            {
                NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arryRetweetPic count]];
                for (NSDictionary *picDic in arryRetweetPic) {
                    
                    NSMutableString *stringPic = [picDic objectForKey:@"thumbnail_pic"];
//                    NSString *strout = [stringPic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
//                    [array addObject:strout];
                    [array addObject:stringPic];
                }
                
                cellUser.retweetPictureArray = [array mutableCopy];
            }
            
            cellUser.blretweet = YES;
        }
        else
        {
            cellUser.blretweet = NO;
        }
        
                
    
            
            
            
        HomeCellFrame *cellFrame = [[HomeCellFrame alloc] init];
        [cellFrame setHomeCell:cellUser];
            
        [self.CellList addObject:cellFrame];
            
        [self.StatuseList addObject:Statuses];
        
    }
    
    [self.tableView reloadData];
    [footerView endRefresh];
    //[headerView endRefresh];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    //NSLog(<#...#>)
    //NSLog(@"-------------level-------------%d", (int)OSMemoryNotificationCurrentLevel());
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.CellList count] >0)
    {
        HomeCellFrame *cellFrame = [self.CellList objectAtIndex:[indexPath row]];
    
        CGFloat height = cellFrame.cellHeight;
    
        //DEBUG_LOG(@"height is %f", height);
    
        return height;
    }
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.CellList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIndentif = @"HomeCell";
    
    TableViewCell *homecellView = [tableView dequeueReusableCellWithIdentifier:tableCellIndentif];
    
    if(homecellView == nil)
    {
        homecellView = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIndentif];
    }
    
    NSInteger i = [indexPath row];
    
    homecellView.Index = i;
    
    homecellView.delegate = self;
    //homecellView.selectedBackgroundView = [[UIView alloc] initWithFrame:homecellView.frame];
    homecellView.selectionStyle = UITableViewCellSelectionStyleNone;
    homecellView.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
  
    HomeCellFrame *CellFrame = [self.CellList objectAtIndex:i];
    
    
    [homecellView setCellFrame:CellFrame];
    
    
    return homecellView;
}


-(NSMutableString*)GetTime:(NSString *)strCreate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *datastr = [NSString dateFromString:strCreate];
    
    NSString *str = [dateFormatter stringFromDate:datastr];
    
    
    NSMutableString *strDate = [[NSMutableString alloc] initWithString:str];
    
    
    return strDate;
}

-(NSMutableString *)GetSource:(NSString *)strSource
{
    
    NSArray *array = [strSource componentsSeparatedByString:@">"];
    
    if([array count] < 2)
    {
        return nil;
    }
    NSString *str = [array objectAtIndex:1];
    
    
    NSMutableString *arrout = [NSMutableString stringWithString:[str substringToIndex:(str.length - 3)]];
    
    return arrout;
}



#pragma mark - Table view delegate

//// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    
////    HomeDetailViewController *HomeDetail = [[HomeDetailViewController alloc] initWithNibName:@"HomeDetailViewController" bundle:nil];
////    
////    HomeDetail.DicStatusData = [self.StatuseList objectAtIndex:[indexPath row]];
////    
////    [HomeDetail setHidesBottomBarWhenPushed:YES];
////    
////    [self.navigationController pushViewController:HomeDetail animated:YES];
//    
//}


#pragma mark - table View cell delegate

-(void)DidPushWebView:(NSURL *)Url Index:(NSInteger)UserIndex
{
    
    HomeDetailViewController *HomeDetail = [[HomeDetailViewController alloc] initWithNibName:@"HomeDetailViewController" bundle:nil];

    
    //[HomeDetail setHidesBottomBarWhenPushed:YES];
    
    [HomeDetail setHttpUrl:Url];
    
    [self.navigationController pushViewController:HomeDetail animated:YES];
}

-(void)DidPushWebView:(NSString *)UserName
{
    HomeUserInfoViewController *homeUserView = [[HomeUserInfoViewController alloc] initWithNibName:@"HomeUserInfoViewController" bundle:nil];
    
    NSString *strUser = [UserName stringByReplacingOccurrencesOfString:@"@" withString:@""];
    
    homeUserView.strUserName = [UserName copy];
    
    [self.navigationController pushViewController:homeUserView animated:YES];}

-(void)DidTouchNamelabel:(NSString *)Screenname
{
    NSLog(@"did tounamelabel");
//    NSString *strUserPwdBase64 = [NSString stringWithFormat:@"+=/abcdefg+/="];
//    
//    NSCharacterSet *allowedCharacters = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"];
//    
//    NSString *strUserPwdBase64Percent = [strUserPwdBase64 stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
//    
//    NSString *strOut = [strUserPwdBase64 stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
//    NSString *sttout2 = [strOut stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
//    NSString *strout3 = [sttout2 stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    
    HomeUserInfoViewController *homeUserView = [[HomeUserInfoViewController alloc] initWithNibName:@"HomeUserInfoViewController" bundle:nil];
    
    homeUserView.strUserName = [Screenname copy];
    
    [self.navigationController pushViewController:homeUserView animated:YES];
}

-(void)DidTouchUserIcon:(UIImageView *)UserIcon Index:(NSInteger)UseIndex
{
//    NSDictionary *statues = [self.StatuseList objectAtIndex:UseIndex];
//    
//    NSDictionary *UserDic = [statues objectForKey:@"user"];
//    
//    NSString *iconHD = [UserDic objectForKey:@"avatar_hd"];
    
  
    
    [ZoomImage ShowImage:UserIcon];
}

-(void)DidTouchPicView:(UIImageView *)PicView
{
    [ZoomImage ShowImage:PicView];
    
    //ZoomImage *zoom = [[ZoomImage alloc] init];
    
    //[zoom ShowavatarImage:PicView];
}


-(void)DidTouchPicAsyView:(AsynImageView *)asyImageView
{
    NSString *strimageUrl = asyImageView.imageURL;
    
    NSRange range = [strimageUrl rangeOfString:@"thumbnail"];
    
    if(range.length > 0)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
            NSString *strLargeImageUrl = [strimageUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:strLargeImageUrl]];
            //AsynImageView *largeImage = [[AsynImageView alloc] init];
            
            //[largeImage showImage:strLargeImageUrl];
            
            UIImageView *largeimage = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                 [ZoomImage ShowImage:largeimage];
            
            });
        
        });

        
        
    }
    
}


@end
