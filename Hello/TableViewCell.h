//
//  TableViewCell.h
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLabel.h"
@class AsynImageView;
@class HomeCellFrame;


@protocol TableViewDelegate <NSObject>

-(void)DidPushWebView:(NSURL *)Url Index:(NSInteger)UserIndex;

-(void)DidPushWebView:(NSString *)UserName;

-(void)DidTouchNamelabel:(NSString *)Screenname;

-(void)DidTouchUserIcon:(UIImageView *)UserIcon Index:(NSInteger)UseIndex;

-(void)DidTouchPicView:(UIImageView *)PicView;

-(void)DidTouchPicAsyView:(AsynImageView *)asyImageView;

@end

@interface TableViewCell : UITableViewCell <PPLabelDelegate>
{
    NSArray *matchsArray;
    NSArray *matchUserArray;
    
    NSArray *ArrayList;
}

/*
 头像
 */
@property (nonatomic, strong) AsynImageView *iconView;

/*
 vip 认证
 */

@property (nonatomic, strong) UIImageView *vipView;


/*
 名称
 */

@property (nonatomic, strong) UILabel *nameLabel;

/*
 时间 来源
 */

@property (nonatomic, strong) UILabel *timeSourceLabel;

/*
 正文
 */

@property (nonatomic, strong) PPLabel *detailLabel;


/*
 配图
 */

@property (nonatomic, strong) UIView *pickView;

@property (nonatomic, strong) NSMutableArray *picArray;


/*
 转发weibo
 */

@property (nonatomic, strong)UIView *retweetView;
@property (nonatomic, strong)PPLabel *retweetLabel;
@property (nonatomic, strong)UIView *retweetPicView;

@property (nonatomic, strong)NSMutableArray *retweetPicArray;


@property (nonatomic, strong)HomeCellFrame *CellFrame;


@property (nonatomic) NSInteger  Index;

@property (nonatomic, strong) id<TableViewDelegate> delegate;


@end
