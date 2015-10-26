//
//  SecondView.m
//  Hello
//
//  Created by 111 on 15-6-18.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "SecondView.h"


@interface SecondView ()

@end

@implementation SecondView

@synthesize textfiled;
@synthesize _value;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"Second View Page";
        
        _value = [[NSString alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"mynotification" object:nil];
    // Do any additional setup after loading the view.
    
    self.textfiled.text = _value;
}

- (void)SetValue:(NSString *)value
{
    _value = value;
    
}

-(IBAction)BackToFirstPage:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)notificationHandler:(NSNotification *) notification
{
    NSDictionary *nameDic = [notification userInfo];
    
    self.textfiled.text = [nameDic objectForKey:@"name"];
    
    
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
