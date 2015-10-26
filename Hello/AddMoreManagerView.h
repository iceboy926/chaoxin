//
//  AddMoreManagerView.h
//  Hello
//
//  Created by 111 on 15-7-17.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddMoreView;
#import "ChatMorePage_1_View.h"
#import "ChatMorePage_2_View.h"

typedef void(^AddMoreBlock)(NSInteger tag);

@protocol AddMoreManangerDelegete <NSObject>

-(void)PotoPicked;
-(void)CameraPicked;
-(void)VideoPicked;
-(void)SharePicked;
-(void)LocationPicked;
-(void)PayByPicked;
-(void)ChatAudioPicked;
-(void)ChatVideoPicked;

@end



@interface AddMoreManagerView : UIView<UIScrollViewDelegate, UIPageViewControllerDelegate, ChatMorePageViewDelegete>

@property(nonatomic,strong) UIScrollView *scrollview;
@property(nonatomic,strong) UIPageControl *pageControl;
@property(nonatomic,strong) AddMoreView *MoreView1;
@property(nonatomic,strong) AddMoreView *MoreView2;
@property(nonatomic,strong) ChatMorePage_1_View *PageView_1;
@property(nonatomic,strong) ChatMorePage_2_View *PageView_2;
@property(nonatomic, retain) id<AddMoreManangerDelegete> delegete;

-(void)setBlock:(AddMoreBlock)block;

-(id)initWithFrame:(CGRect)frame withDeleget:(id)delegete;

@end
