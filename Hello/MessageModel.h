//
//  MessageModel.h
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    kMessageModelTypeOther = 0,
    kMessageModelTypeMe
}MessageModelTypes;

@interface MessageModel : NSObject

@property(nonatomic, copy)NSString *textMessage;
@property(nonatomic, copy)NSString *timeMessage;
@property(nonatomic, assign)MessageModelTypes type;
@property(nonatomic, assign)BOOL blShowTime;

+(id)MessageModelWithDic:(NSDictionary *)dic;


@end
