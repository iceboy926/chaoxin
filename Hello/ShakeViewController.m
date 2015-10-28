//
//  ShakeViewController.m
//  Hello
//
//  Created by 1234 on 15-10-23.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ShakeViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "AppDelegate.h"
#import "JSONKit.h"
#import <CoreLocation/CoreLocation.h>
#import "NSString+Extension.h"

static SystemSoundID shake_sound_male_id = 0;

@interface ShakeViewController () <CLLocationManagerDelegate>
{
    UIImageView *imageView;
    
    UIImageView *imageViewUp;
    UIImageView *imageViewDown;
    
    CGRect imageViewUpOrigFrame;
    CGRect imageViewDownOrigFrame;
    
    CGFloat currentLatitude; //纬度
    CGFloat currentLongtitude;//径度
    
    CLLocationManager *locationMgr;
    
    NSMutableArray *UserList;
    
    
    
    UILabel *FindedUserLabel;
    UIImageView *FinderUserImage;
    UIView  *FindedUserView;
    
}

@end

@implementation ShakeViewController

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
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backGo)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    UserList = [NSMutableArray array];
    
    //self.view.backgroundColor = [UIColor grayColor];
    
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.userInteractionEnabled = YES;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    
    imageViewUp = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageViewUp.image = [UIImage imageNamed:@"Shake_Logo_Up"];
    imageViewUp.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageViewUp];
    
    
    imageViewDown = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageViewDown.image = [UIImage imageNamed:@"Shake_Logo_Down"];
    imageViewDown.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageViewDown];
    
    [self ImageInit];
    
    
    FindedUserView = [[UIView alloc] initWithFrame:CGRectZero];
    FindedUserView.userInteractionEnabled = YES;
    FindedUserView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:FindedUserView];
    
    
    FinderUserImage = [[UIImageView alloc] initWithFrame: CGRectMake(5, 5, 50, 50)];
    FinderUserImage.userInteractionEnabled = YES;
    FinderUserImage.image = [UIImage imageNamed:@"other"];
    [FindedUserView addSubview:FinderUserImage];
    
    
    FindedUserLabel = [[UILabel alloc] initWithFrame: CGRectMake(5, 58, 200, 20)];
    FindedUserLabel.font = SourceFont;
    FindedUserLabel.textColor = [UIColor blackColor];
    [FindedUserView addSubview:FindedUserLabel];
    
    
    
    locationMgr = [[CLLocationManager alloc] init];
    locationMgr.delegate = self;
    locationMgr.desiredAccuracy = kCLLocationAccuracyBest;
    locationMgr.distanceFilter = 1000.0f;
    [locationMgr startUpdatingLocation];
    
    
    
    currentLatitude = locationMgr.location.coordinate.latitude;
    currentLongtitude = locationMgr.location.coordinate.longitude;
    
    NSLog(@"latitude is %f", currentLatitude);
    NSLog(@"longtitude is %f", currentLongtitude);
    


    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchImage:)];
    [imageView addGestureRecognizer:tapGesture];
    
    [self SendRequest];
    // Do any additional setup after loading the view from its nib.
}


-(void)SendRequest
{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dicRequest = [NSMutableDictionary dictionary];
    //NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"sinaweibo"];
    
    [dicRequest setObject:appDelegate.wbtoken forKey:@"access_token"];
    [dicRequest setObject:[NSString stringWithFormat:@"%f",currentLatitude] forKey:@"lat"];
    [dicRequest setObject:[NSString stringWithFormat:@"%f",currentLongtitude] forKey:@"long"];
    
    [WBHttpRequest requestWithAccessToken:appDelegate.wbtoken url:SinaWeiBo_URL_NearBy_User httpMethod:@"Get" params:dicRequest queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error)
     {
         [self RequestHanlderRefresh:httpRequest :result :error];
     }
     ];
    
}

- (void)RequestHanlderRefresh:(WBHttpRequest *)httpRequest :(id)result : (NSError *)error
{
    
    NSData *jsonData = [result JSONData];
    
    NSDictionary *dicResult = [jsonData objectFromJSONData];

    //NSLog(@"dicResult is %@", dicResult);
    
    NSArray *UserArray = [dicResult objectForKey:@"users"];
    
    for (NSDictionary *dicUser in UserArray) {
        
        NSString *strUserName = [NSString replaceUnicode:[dicUser objectForKey:@"screen_name"]];
        
        NSString *strIconUrl = [dicUser objectForKey:@"profile_image_url"];
        
        
        [UserList addObject:[NSDictionary dictionaryWithObjectsAndKeys:strUserName,@"name",strIconUrl,@"url",nil]];
        
    }
    
}


-(int)GetRandomNumber:(int)from to:(int)to
{
    return (int)(from + arc4random()%(to - from));
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    imageViewUpOrigFrame = imageViewUp.frame;
    NSLog(@"imageViewUp Frame = %f", imageViewUpOrigFrame.origin.x);
    
    imageViewDownOrigFrame = imageViewDown.frame;
    NSLog(@"imageViewDown Frame = %f", imageViewDownOrigFrame.origin.x);
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self HideToolbar:NO];
}

-(void)AddFrameConstraint
{
//    NSArray *arrayConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[imageView]-20-|"
//                                                                        options:0
//                                                                        metrics:nil
//                                                                        views:NSDictionaryOfVariableBindings(imageView)];
//    
//    NSArray *arrayConstranintYs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[imageView]-20-|"
//                                                                          options:0
//                                                                          metrics:nil
//                                                                            views:NSDictionaryOfVariableBindings(imageView)];
//    
//    
//    [self.view addConstraints:arrayConstraints];
//    [self.view addConstraints:arrayConstranintYs];
    
    
    NSLayoutConstraint *ConstraintX = [NSLayoutConstraint constraintWithItem:imageView
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                    attribute:NSLayoutAttributeCenterX
                                                                    multiplier:1
                                                                     constant:0];
    
    
    NSLayoutConstraint *ConstraintY = [NSLayoutConstraint constraintWithItem:imageView
                                                                    attribute:NSLayoutAttributeCenterY
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeCenterY
                                                                   multiplier:1
                                                                     constant:0];
    
    [self.view addConstraint:ConstraintX];
    [self.view addConstraint:ConstraintY];
//
    
    
}

-(void)playSound:(NSString *)WavName
{
    NSString *WavPath = [[NSBundle mainBundle] pathForResource:WavName ofType:@"wav"];
    NSLog(@"path is %@", WavPath);
    if(WavPath)
    {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:WavPath], &shake_sound_male_id);
        
        AudioServicesPlaySystemSound(shake_sound_male_id);
    
    }
}

-(void)ImageInit
{
//    NSDictionary *Viewdic = NSDictionaryOfVariableBindings(imageViewUp, imageViewDown);
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageViewUp]"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:Viewdic]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageViewUp]"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:Viewdic]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageViewUp
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageViewUp
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:0.9
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageViewDown
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageViewDown
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:imageViewUp
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:imageViewDown
                                                          attribute:NSLayoutAttributeLeft
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:imageViewUp
                                                          attribute:NSLayoutAttributeLeft
                                                         multiplier:1
                                                           constant:0]];
    
}

-(void)ImageMove
{

    //FindedUserView.frame = CGRectZero;
    
    
    [UIView beginAnimations:@"Shake_Animation" context:(__bridge void *)imageViewUp];
    [UIView setAnimationDuration:1.5f];
    
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(imageDidStop)];
    
    CGRect ViewUpFrame = imageViewUpOrigFrame;
    ViewUpFrame.origin.y = ViewUpFrame.origin.y - 20;
    
    [imageViewUp setFrame:ViewUpFrame];
    
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:@"Shake_Animation" context:(__bridge void *)imageViewDown];
    [UIView setAnimationDuration:1.5f];
    
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(imageDidStop)];
    
    CGRect ViewDownFrame = imageViewDownOrigFrame;
    ViewDownFrame.origin.y = ViewDownFrame.origin.y + 20;
    
    [imageViewDown setFrame:ViewDownFrame];
    
    [UIView commitAnimations];
}

-(void)imageStop
{
    [UIView beginAnimations:@"Shake_Animation" context:(__bridge void *)imageViewUp];
    [UIView setAnimationDuration:2.5f];
    
    [UIView setAnimationDelegate:self];
    //[UIView setAnimationDidStopSelector:@selector(imageDidStop)];
    
    [imageViewUp setFrame:imageViewUpOrigFrame];
    
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:@"Shake_Animation" context:(__bridge void *)imageViewDown];
    [UIView setAnimationDuration:2.5f];
    
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(imageDidStop)];

    
    [imageViewDown setFrame:imageViewDownOrigFrame];
    
    [UIView commitAnimations];
    
    
    
    
}

-(void)imageDidStop
{
    FindedUserView.hidden = NO;
    
    int Count = [UserList count];
    if(Count > 0)
    {
        //[UIView beginAnimations:@"show_finded" context:(__bridge void *)FindedUserView];
       
        //[UIView setAnimationDuration:1.5f];
        
        //[UIView setAnimationDelegate:self];
        
        int number = [self GetRandomNumber:0 to:Count];
        
        NSDictionary *dicUser = [UserList objectAtIndex:number];
        
        //NSLog(@"user name is %@", [dicUser objectForKey:@"name"]);
        //NSLog(@"url is %@", [dicUser objectForKey:@"url"]);
        
        FindedUserLabel.text = [dicUser objectForKey:@"name"];
        NSURL *url = [NSURL URLWithString:[dicUser objectForKey:@"url"]];
        
        
        FinderUserImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        FindedUserView.frame = CGRectMake(CGRectGetMinX(imageViewDownOrigFrame) - 10, CGRectGetMaxY(imageViewDownOrigFrame) + 10, 100, 100);
        
        //[UIView commitAnimations];
    }
}

-(void)backGo
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)TouchImage:(UITapGestureRecognizer *)tapGesture
{
    
    
}

-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"begin motion");
    
    imageView.image = nil;
    
    [self playSound:@"shake_sound_male"];
    
    FindedUserView.hidden = YES;
    
}


-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"cancel motion");
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.subtype == UIEventSubtypeMotionShake)
    {
        NSLog(@"end motion");
        
        //[imageView setImage:[UIImage imageNamed:@"other"]];
        //[self AddFrameConstraint];
        [self playSound:@"shake_match"];
        [self ImageMove];
        [self imageStop];
        
    }
    else
    {
        NSLog(@"motion continue");
    }
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
