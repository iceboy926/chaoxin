//
//  HomeUserInfoViewController.m
//  Hello
//
//  Created by 111 on 15-9-25.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "HomeUserInfoViewController.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import "NSString+Extension.h"

@interface HomeUserInfoViewController ()<UINavigationControllerDelegate>


@end

@implementation HomeUserInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

//添加控件约束
-(void)AddConstraint
{
    
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
   
    _HeadBodyView = [[UIImageView alloc] init];
    
    _HeadBodyView.translatesAutoresizingMaskIntoConstraints = NO;
    _HeadBodyView.userInteractionEnabled = YES;
    _HeadBodyView.contentMode = UIViewContentModeScaleAspectFill;
    //_HeadBodyView.backgroundColor = [UIColor grayColor];
    //_HeadBodyView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_HeadBodyView];
    
    
    _UserIconView = [[UIImageView alloc] init];
    _UserIconView.userInteractionEnabled = YES;
    _UserIconView.translatesAutoresizingMaskIntoConstraints = NO;
    //_UserIconView.image = [UIImage imageNamed:@"weixin2"];
    //_UserIconView.backgroundColor = [UIColor greenColor];
    [_HeadBodyView addSubview:_UserIconView];
    
    
    _UserNameLable = [[UILabel alloc] init];
    _UserNameLable.translatesAutoresizingMaskIntoConstraints = NO;
    _UserNameLable.font = [UIFont systemFontOfSize:18];
    //_UserNameLable.textColor = [UIColor whiteColor];
    _UserNameLable.textAlignment = NSTextAlignmentCenter;
    //_UserNameLable.text = @"nameLable";
    [_HeadBodyView addSubview:_UserNameLable];
    
    
    _followsLabel = [[UILabel alloc] init];
    _followsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _followsLabel.font = [UIFont systemFontOfSize:16];
    //_followsLabel.textColor = [UIColor whiteColor];
    _followsLabel.textAlignment = NSTextAlignmentCenter;
    //_followsLabel.text = @"followslabel";
    [_HeadBodyView addSubview:_followsLabel];
    
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.font = [UIFont systemFontOfSize:14];
    //_descriptionLabel.textColor = [UIColor whiteColor];
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    _descriptionLabel.numberOfLines = 0;
    //_descriptionLabel.text = @"descruptilable";
    [_HeadBodyView addSubview:_descriptionLabel];

    
    NSDictionary *viewDic = NSDictionaryOfVariableBindings(_UserIconView, _UserNameLable, _followsLabel, _descriptionLabel);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_HeadBodyView]-0-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:NSDictionaryOfVariableBindings(_HeadBodyView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_HeadBodyView]-0-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_HeadBodyView)]];
    
    
    
    //
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_UserIconView(==60)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewDic]];
    
    
//    //设置高度
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_UserIconView(==60)]-[_UserNameLable(==20)]-[_followsLabel(==_UserNameLable)]-[_descriptionLabel]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:viewDic]];
////
//
//    //水平居中
//    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_UserIconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_HeadBodyView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_UserNameLable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_HeadBodyView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_followsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_HeadBodyView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_HeadBodyView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
//
    //
    
    [self SendRequst];
    
    
}

- (void)RequestHanlderRefresh:(WBHttpRequest *)httpRequest :(id)result : (NSError *)error
{
    NSDictionary *UserDic = [[result JSONData] objectFromJSONData];
    
    
    NSString *coverStr = [UserDic objectForKey:@"cover_image_phone"];
    if(coverStr == nil)
    {
        coverStr = [UserDic objectForKey:@"cover_image"];
    }
    
    
    
    NSString *iconUrlStr = [UserDic objectForKey:@"avatar_large"];
    
    
    NSString *NameStr = [NSString replaceUnicode:[UserDic objectForKey:@"screen_name"]];
    
    int  follows = [[UserDic valueForKey:@"followers_count"] intValue];
    int  friends = [[UserDic valueForKey:@"friends_count"] intValue];
    
    NSString *followStr = [NSString stringWithFormat:@"关注 %d | 粉丝 %d ", follows, friends];
    
    
    NSString *DescriptStr = [NSString replaceUnicode:[UserDic objectForKey:@"description"]];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
    
        NSData *coverImageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:coverStr]];
        
        UIImage *bodyImage = [UIImage imageWithData:coverImageData];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
            _HeadBodyView.image = bodyImage;
        
        });
    
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrlStr]];
        
        UIImage *iconImage = [UIImage imageWithData:imageData];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _UserIconView.image = iconImage;
            
        });
        
    });
    
    _UserNameLable.text = NameStr;
    
    _followsLabel.text = followStr;
    
    
    
    //[_UserIconView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrlStr]]];
     
     
}


-(void)SendRequst
{
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:appDelegate.wbtoken forKey:@"access_token"];
    [dic setObject:_strUserName forKey:@"screen_name"];
    
    
    [WBHttpRequest requestWithAccessToken:appDelegate.wbtoken url:SinaWeiBo_URL_User_Show httpMethod:@"Get" params:dic queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         [self RequestHanlderRefresh:httpRequest :result :error];
     }
     ];
    
}



-(void)setHeadBodyData
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc] initWithTitle:@"首页" style:UIBarButtonItemStyleDone target:self action:@selector(Goback:)];
    
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttr[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    
    [backitem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    
    [backitem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem = backitem;
    
    self.navigationController.delegate = self;
    
    
    
    [self AddConstraint];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [self ShowTabBar:YES];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self ShowTabBar:NO];
    [super viewWillDisappear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

-(void)viewDidUnload
{
    [super viewDidUnload];
    self.navigationController.delegate = nil;
}

-(void)dealloc
{
    //[super dealloc];
    self.navigationController.delegate = nil;
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"willShowViewController");
    
    if(viewController == self)
    {
        //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        self.navigationController.navigationBar.alpha = 0.3;
        //self.navigationController.navigationBar.translucent = YES;
    }
    else
    {
        self.navigationController.navigationBar.alpha =1.0;
        self.navigationController.delegate = nil;
        //self.navigationController.navigationBar.tintColor = nil;
        //self.navigationController.navigationBar.translucent = NO;
    }
    
}


-(void)Goback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)ShowTabBar:(BOOL)blret
{
    for (UIView *view in [self.tabBarController.view subviews]) {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blret];
            break;
        }
    }
    
}

@end
