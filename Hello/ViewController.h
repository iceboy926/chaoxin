//
//  ViewController.h
//  Hello
//
//  Created by 111 on 15-6-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
#import "XMPPFramework.h"

@interface ViewController : UIViewController<UIAlertViewDelegate, UITextFieldDelegate, UIActionSheetDelegate,NSURLConnectionDataDelegate,XMPPStreamDelegate>
{
    UILabel *uilabel;
    UIButton *uibutton;
    UISwitch *uiswitch;
    UISlider *uislider;
    UIImageView *uiimageview;
    UIStepper *uistepper;
    UITextField *uitextfield;
    id<PassValueDelegate> passvalue;
    NSURLConnection *connection;
    NSMutableData *Data;
    XMPPStream *xmpstream;
}

@property(nonatomic, retain) IBOutlet UILabel *uilabel;
@property(nonatomic, retain) IBOutlet UISwitch *uiswitch;
@property(nonatomic, retain) IBOutlet UISlider *uislider;
@property(nonatomic, retain) IBOutlet UIImageView *uiimageview;
@property(nonatomic, retain) IBOutlet UIStepper *uistepper;
@property(nonatomic, retain) IBOutlet UITextField *uitextfield;
@property(nonatomic, retain) id<PassValueDelegate> passvalue;
@property(nonatomic, retain) NSURLConnection *connection;
@property(nonatomic, retain) NSMutableData *Data;
@property(strong, nonatomic) XMPPStream *xmppstream;


-(IBAction)button_ok:(id)sender;
-(IBAction)switch_on:(id)sender;
-(IBAction)slider_on:(id)sender;
-(IBAction)stepper_changed:(id)sender;


-(void)connect;


-(void)reach;


- (IBAction)clickBackground:(id)sender;

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
@end
