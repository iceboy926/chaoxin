//
//  MessageCellFrameModel.h
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

#define textPadding 15

@class MessageModel;

@interface MessageCellFrameModel : NSObject

@property(nonatomic, strong) MessageModel *message;

@property(nonatomic, assign, readonly) CGRect timeFrame;
@property(nonatomic, assign, readonly) CGRect textFrame;
@property(nonatomic, assign, readonly) CGRect imageFrame;

@property(nonatomic, assign, readonly) CGFloat cellHeight;

@end