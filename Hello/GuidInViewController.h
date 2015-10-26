//
//  GuidInViewController.h
//  Hello
//
//  Created by 111 on 15-8-17.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GotoMainPage)();

@interface GuidInViewController : UIViewController

@property (nonatomic) NSArray *arryImage;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageView;
@property (nonatomic, strong) UIButton *EnterButton;
@property (nonatomic, copy) GotoMainPage gotoMainPage;

-(id)initWithBackGroundImage :(NSArray *)imageArray;

-(void)DisappearScroll;

@end
