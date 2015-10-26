//
//  HomeCellModel.h
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeCellModel : NSObject

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *Name;

@property (nonatomic, copy) NSString *timesource;

@property (nonatomic, copy) NSString *detail;

@property (nonatomic, copy) NSMutableArray *pictureArray;

@property (nonatomic, assign) BOOL blVip;

@property (nonatomic, copy) NSString *retweetDetail;
@property (nonatomic, copy) NSMutableArray *retweetPictureArray;

@property (nonatomic, assign) BOOL blretweet;


@end
