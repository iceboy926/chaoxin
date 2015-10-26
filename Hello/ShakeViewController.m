//
//  ShakeViewController.m
//  Hello
//
//  Created by 1234 on 15-10-23.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ShakeViewController.h"
#import <AudioToolbox/AudioToolbox.h>

static SystemSoundID shake_sound_male_id = 0;

@interface ShakeViewController ()
{
    UIImageView *imageView;
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
    
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
    
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.userInteractionEnabled = YES;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:imageView];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchImage:)];
    [imageView addGestureRecognizer:tapGesture];
    
    //UITabGestureRecognizer *gesture = [[UIGestureRecognizer alloc] initWithTarget:self action:<#(SEL)#>
    
    
    
    // Do any additional setup after loading the view from its nib.
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
        
        [imageView setImage:[UIImage imageNamed:@"other"]];
        [self AddFrameConstraint];
        [self playSound:@"shake_match"];
        
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
