//
//  SecondView.h
//  Hello
//
//  Created by 111 on 15-6-18.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@interface SecondView : UIViewController<PassValueDelegate>
{
    UITextField *textfiled;
    NSString* _value;
}

@property (nonatomic, retain) NSString *_value;

-(void)SetValue:(NSString *)value;

-(void)notificationHandler:(NSNotification *) notification;

- (IBAction)BackToFirstPage:(id)sender;

@property(nonatomic, strong)IBOutlet UITextField *textfiled;

@end
