//
//  HomeCellFrame.h
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#define Padding 10

//#define SourceFont [UIFont systemFontOfSize:12]
//#define NameFont [UIFont fontWithName:@"TimesNewRomanPS-BoldMT" size:16]
//#define DetailFont [UIFont fontWithName:@"TimesNewRomanPSMT" size:18]
#define ICON_WIDTH  50
#define ICON_HEIGH  50

#import <Foundation/Foundation.h>
@class HomeCellModel;


@interface HomeCellFrame : NSObject


@property (nonatomic, assign, readonly) CGRect iconFrame;

@property (nonatomic, assign, readonly) CGRect nameFrame;

@property (nonatomic, assign, readonly) CGRect vipFrame;

@property (nonatomic, assign, readonly) CGRect timesourceFrame;

@property (nonatomic, assign, readonly) CGRect detailFrame;

@property (nonatomic, assign, readonly) CGRect pictureFrame;

@property (nonatomic, strong) NSMutableArray *pictFrameArray;

@property (nonatomic, assign, readonly) CGRect retweetViewFrame;

@property (nonatomic, assign, readonly) CGRect retweetDetailFrame;
@property (nonatomic, assign, readonly) CGRect retweetPictureFrame;
@property (nonatomic, strong) NSMutableArray *retweetPictureFrameArray;


@property (nonatomic, strong) HomeCellModel *HomeCell;

@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end
