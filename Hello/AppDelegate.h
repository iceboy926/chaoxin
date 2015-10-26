//
//  AppDelegate.h
//  Hello
//
//  Created by 111 on 15-6-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuidInViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate, UITextFieldDelegate>
{
    NSString* wbtoken;
    NSString* wbCurrentUserID;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) GuidInViewController *GuidView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (retain, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@end
