//
//  InformationViewController.m
//  Hello
//
//  Created by 111 on 15-7-3.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

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
    
    UIBarButtonItem *backupItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backup)];
    
    self.navigationItem.leftBarButtonItem = backupItem;
    
    self.navigationItem.title = @"朋友圈";
    //self.tabBarItem.image = [UIImage imageNamed:@"infor_normal"];
    
    //self.tabBarItem.selectedImage = [UIImage imageNamed:@"infor_pressed"];
    
    
    //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backup
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)HideToolBar:(BOOL)blHide
{
    for (UIView *toolView in [self.tabBarController.view subviews]) {
        if([toolView isKindOfClass:[UITabBar class]])
        {
            [toolView setHidden:blHide];
            break;
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HideToolBar:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideToolBar:NO];
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
