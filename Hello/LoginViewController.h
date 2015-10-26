//
//  LoginViewController.h
//  Hello
//
//  Created by 111 on 15-7-1.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMPPManager.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *uiUserNameTF;
@property (strong, nonatomic) IBOutlet UITextField *uiPassWordTF;
@property (strong, nonatomic) IBOutlet UIButton *uiLogInBT;
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
- (IBAction)TextFile_DidEnd:(id)sender;

- (IBAction)LogIn:(id)sender;

-(void)LoginWithSinabo;

@end
