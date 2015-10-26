//
//  MainTabBarViewController.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomePageViewController.h" //首页
#import "FansTableViewController.h" //粉丝
#import "FindViewController.h" //发现
#import "MineViewController.h" //我
#import "MainNavigateViewController.h" //nav


@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

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
    
    HomePageViewController *chatView = [[HomePageViewController alloc] init];
    [self addChildvc:chatView title:@"首页" image:[UIImage imageNamed:@"chat_normal"] SelectImage:[UIImage imageNamed:@"chat_pressed"]];
    
    FansTableViewController *fansView = [[FansTableViewController alloc] init];
    [self addChildvc:fansView title:@"粉丝" image:[UIImage imageNamed:@"friend_normal"] SelectImage:[UIImage imageNamed:@"friend_pressed"]];
    
    FindViewController *findView = [[FindViewController alloc] init];
    [self addChildvc:findView title:@"发现" image:[UIImage imageNamed:@"infor_normal"] SelectImage:[UIImage imageNamed:@"infor_pressed"]];
    
    MineViewController *mineView = [[MineViewController alloc] init];
    [self addChildvc:mineView title:@"我" image:[UIImage imageNamed:@"user_normal"] SelectImage:[UIImage imageNamed:@"user_pressed"]];
    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)addChildvc:(UIViewController *)ChildVc title:(NSString *)title image:(UIImage *)image SelectImage:(UIImage *)SelectImage
{
    ChildVc.title = title;
    
    ChildVc.tabBarItem.image = image;
    ChildVc.tabBarItem.selectedImage = SelectImage;
    
    NSMutableDictionary *textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor blueColor];
    
    NSMutableDictionary *textAttrSelect = [NSMutableDictionary dictionary];
    textAttrSelect[NSForegroundColorAttributeName] = [UIColor redColor];
    
    
    [ChildVc.tabBarItem setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    [ChildVc.tabBarItem setTitleTextAttributes:textAttrSelect forState:UIControlStateSelected];
    
    MainNavigateViewController *nv = [[MainNavigateViewController alloc] initWithRootViewController:ChildVc];
    
    [self addChildViewController:nv];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
