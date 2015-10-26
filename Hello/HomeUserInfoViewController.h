//
//  HomeUserInfoViewController.h
//  Hello
//
//  Created by 111 on 15-9-25.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeUserInfoViewController : UIViewController

@property (nonatomic, copy) NSString *strUserName;


@property (nonatomic, strong) UIImageView *HeadBodyView;

@property (nonatomic, strong) UIImageView *UserIconView;

@property (nonatomic, strong) UILabel *UserNameLable;

@property (nonatomic, strong) UILabel *followsLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@end
