//
//  QRResultViewController.m
//  Hello
//
//  Created by 1234 on 15-10-23.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "QRResultViewController.h"

@interface QRResultViewController () <UIWebViewDelegate>
{
    UIWebView  *webView;
}

@end

@implementation QRResultViewController

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
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backUp)];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    
    webView.backgroundColor = [UIColor lightGrayColor];
    
    webView.scalesPageToFit = YES;
    
    [self.view addSubview:webView];
    
    webView.delegate = self;
    
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.HttpStr]]];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self HideToolbar:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideToolbar:NO];
    
}

-(void)backUp
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)HideToolbar:(BOOL)blret
{
    for(UIView *view in [self.tabBarController.view subviews])
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            [view setHidden:blret];
            break;
        }
    }
}

@end
