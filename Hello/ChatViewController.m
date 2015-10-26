//
//  ChatViewController.m
//  Hello
//
//  Created by 111 on 15-7-3.
//  Copyright (c) 2015年 mit. All rights reserved.
///Users/a111/Desktop/Hello/Hello.xcodeproj

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
#import "ChatDetailViewController.h"
#import "Reachability.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"


@interface ChatViewController ()

@end

@implementation ChatViewController

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
    
    //self.tabBarItem.image = [UIImage imageNamed:@"chat_normal"];
    
    //self.tabBarItem.selectedImage = [UIImage imageNamed:@"chat_pressed"];
    
    
    NSDictionary *sinadic = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"sinaweibo"];
    
    NSString *nickName = [sinadic objectForKey:@"nickname"];
   
    
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    if([reach currentReachabilityStatus] == NotReachable)
    {
        //self.title = [NSString stringWithFormat:@"%@(未连接)", nickName];
    }
    else
    {
        //self.title = nickName;
    }
    
//    id<ISSPage> isspageNum ;
//    
//    [isspageNum setPageNo:1];
//    [isspageNum setPageSize:2];
//    
//    
//    [ShareSDK getFriendsWithType:ShareTypeSinaWeibo page:isspageNum authOptions:nil result:^(SSResponseState state, NSArray *users, long long curr, long long prev, long long next, BOOL hasNext, NSDictionary *extInfo, id<ICMErrorInfo> error)
//     {
//         if(state == SSResponseStateSuccess)
//         {
//             NSLog(@"user array count = %ld", [users count]);
//             
//             self.friendList = [users copy];
//             
//             [self.uiTableViewdata reloadData];
//         }
//     }];
//    
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    
    //self.tableView.tableFooterView = [[UIView alloc] init];
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];


    
    
//    NSURL *pUrl = [[NSBundle mainBundle] URLForResource:@"friendsInfo" withExtension:@"plist"];
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfURL:pUrl];
//    
//    NSMutableArray *tempDataList = [[NSMutableArray alloc] init];
//    NSMutableArray *imageList = [[NSMutableArray alloc] init];
//    
//    for(int i = 0; i < 5; i++)
//    {
//        NSString *key = [NSString stringWithFormat:@"%i", i+1];
//        NSMutableDictionary *obj = [dict objectForKey:key];
//        [tempDataList addObject:obj];
//        
//        
//        NSString *keyimage = [NSString stringWithFormat:@"00%i.png", i+1];
//        UIImage *image = [UIImage imageNamed:keyimage];
//        [imageList addObject:image];
//    }
//    
//    
//    self.dataList = [tempDataList copy];
//    self.imageList = [imageList copy];

    
    // Do any additional setup after loading the view.
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_friendList count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableCellIndentif = @"ChatCell";
    
    ChatTableViewCell *chatcell = [tableView dequeueReusableCellWithIdentifier:tableCellIndentif];
    
    if(chatcell == nil)
    {
        chatcell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIndentif];
    }
    
    NSInteger i = [indexPath row];
    
//    SSSinaWeiboUser *weiboUser = [self.friendList objectAtIndex:i];
//    
//    NSString *strnick = [weiboUser nickname];
//    
//    NSString *strurlimage = [weiboUser profileImage];
//    
//    NSDictionary *dic = [weiboUser sourceData];
//    
//
//    NSLog(@"nickname is %@", strnick);
//    NSLog(@"urlimage is %@", strurlimage);
    //NSLog(@"dic is %@", dic);
    
    
    

    
//    NSDictionary *dic = [self.dataList objectAtIndex:i];
//    
//    
//    chatcell.Name = [dic objectForKey:@"name"];
//    chatcell.Message = [dic objectForKey:@"dec"];
//    
//    chatcell.image = [self.imageList objectAtIndex:i];
    
    
    
    
    
    
    return chatcell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    itemNum = [indexPath row];
    
    [self performSegueWithIdentifier:@"GotoChatDetail" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GotoChatDetail"])
    {
        ChatDetailViewController *rec = segue.destinationViewController;
        rec.itemSelected = itemNum;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
