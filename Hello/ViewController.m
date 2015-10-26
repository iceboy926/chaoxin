//
//  ViewController.m
//  Hello
//
//  Created by 111 on 15-6-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ViewController.h"
#import "HelloData.h"
#import "HelloDataDelegate.h"
#import "SecondView.h"
#import "AFNetworking/AFHTTPRequestOperationManager.h"
#import "AFNetworking/AFHTTPSessionManager.h"

@implementation ViewController

@synthesize uilabel;
@synthesize uiswitch;
@synthesize uislider;
@synthesize uiimageview;
@synthesize uistepper;
@synthesize uitextfield;
@synthesize passvalue;
@synthesize connection;
@synthesize Data;

- (void)viewDidLoad
{
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 300, 30)];
    label1.text = @"hello nihao ,wo bu zai jia";
    label1.textColor = [UIColor whiteColor];
    label1.backgroundColor = [UIColor redColor];
    
    
    label1.textAlignment=NSTextAlignmentCenter;
    
    
    [self.view addSubview:label1];
    
    
    [uislider setMaximumValue:100];
    
    [uislider setMinimumValue:0];
    
    [uislider setValue:10];
    
    [uistepper setMaximumValue:1];
    [uistepper setMinimumValue:0];
    
    [uistepper setStepValue:0.1];
    
    self.uitextfield.delegate = self;
    
    
    NSLog(@"%@",NSHomeDirectory());
    
    
    [super viewDidLoad];
    
    //[self reach];

	// Do any additional setup after loading the view, typically from a nib.
}

-(void)reach
{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        NSLog(@"status = %d", status);
    }];
    
    
}

-(void)sessiondownload
{
//    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
//    NSString *urlstr = @"http://";
    
}


-(IBAction)button_ok:(id)sender
{
    NSLog(@"button press down");
    uilabel.text = @"you press down the botton";
    
    [uiswitch setOn:YES];
    
    HelloData *hello = [[HelloData alloc] init];
    
    NSLog(@"before data is %@", [hello m_str]);
    
    
    [hello setM_str:@" ni 11111111111"];
    
    
    NSLog(@"after data is %@", [hello m_str]);
    
//    UIAlertView *uialertview = [[UIAlertView alloc] initWithTitle:@"提示" message: @"Please input your name and password!" delegate: self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    
//    [uialertview setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
//    
//    
//    UITextField *textFiled1 = [uialertview textFieldAtIndex:0];
//    
//    textFiled1.keyboardType = UIKeyboardTypeNumberPad;
//    
//    
//    UITextField *textFiled2 = [uialertview textFieldAtIndex:1];
//    
//    textFiled2.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
//    
//    
//    [uialertview show];
    
    
    HelloData *h = [[HelloData alloc] init];
    
    HelloDataDelegate *hd = [[HelloDataDelegate alloc] init];
    
    h.helloDataDelegate = hd;
    
    [h Function];
    
    
//    NSDictionary *dicts = [NSDictionary dictionaryWithObjectsAndKeys:@"one1",@"one",@"two2",@"two",@"three3",@"three", nil];
//
    NSLog(@"passed mes is %@", uitextfield.text);
//    NSNotification *notification  =[NSNotification notificationWithName:@"mynotification" object:uitextfield.text];
//    
    //[[NSNotificationCenter defaultCenter] postNotification:notification];
    
    //[self presentModalViewController:second animated:YES];
    
    //
    

//    SecondView *se = [[SecondView alloc] init];
//
//    
//    self.passvalue = se;
//    
//    [self.passvalue SetValue:uitextfield.text];
//    
//    [self presentViewController:se animated:YES completion:nil];
    
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"mynotification" object:self userInfo:@{@"name": self.uitextfield.text}];
//
    
    NSString *urlstr = @"http://www.baidu.com";
    
    //请求一个地址
    NSURL *url = [NSURL URLWithString:urlstr];
    
    //实力话一个quest
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(self.connection)
    {
        NSLog(@"Link success");
    }
    else
    {
        NSLog(@"Link failed");
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"callback data type : %@", [response textEncodingName]);
    
    NSMutableData *d = [[NSMutableData alloc] init];
    
    self.data = d;
    
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSInteger len = [data length];
    
    NSLog(@"return data len is %d", len);
    
    [self.Data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"the final data len is %d", [self.Data length]);
    
    NSStringEncoding gbkencoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSString *strdata = [[NSString alloc] initWithData:self.Data encoding:gbkencoding];
    
    NSLog(@" the final data is %@", strdata);
    
    self.uilabel.text = strdata;
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error code ");
}

-(IBAction)switch_on:(id)sender
{
    UISwitch *myswitch = (UISwitch *)sender;
    
    BOOL blisOn = [myswitch isOn];
    
    if(blisOn)
    {
        uilabel.text = @"switch is on!";
        
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Note" delegate:self
                                                   cancelButtonTitle:@"No Way!" destructiveButtonTitle:@"Yes I'm sure!" otherButtonTitles:nil, nil];
        action.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [action showInView:self.view];
        
        
    }
    else
    {
        uilabel.text = @"switch is off!";
    }
}

-(IBAction)slider_on:(id)sender
{
    UISlider *slider = (UISlider *)sender;
    
    float value = slider.value;
    
    NSLog(@"value is %f", value);
    
    if (value == slider.maximumValue) {
 
        [uiswitch setOn:YES animated:YES];
    }
    else if(value == slider.minimumValue)
    {
        [uiswitch setOn:NO animated:NO];
    }
    
    
}

-(IBAction)stepper_changed:(id)sender
{
    UIStepper *stepper = (UIStepper *)sender;
    
    NSLock *thelock = [[NSLock alloc] init];
    [thelock lock];
    {
    
    NSString *str = [[NSString alloc] initWithFormat:@" stepper value is %f", stepper.value];
    
    NSLog(@"%@", str);
        
    }
    [thelock unlock];
    
 
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"you click button index is %d", buttonIndex);
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidBeginEditing.........");
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.uitextfield == textField)
    {
        [uitextfield resignFirstResponder];
    }
    
    return FALSE;
}


- (IBAction)clickBackground:(id)sender
{
    NSLog(@"click background .....");
    

    [sender endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
