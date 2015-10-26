//
//  MessageModel.m
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

+(id)MessageModelWithDic:(NSDictionary *)dic
{
    MessageModel *mess = [[MessageModel alloc] init];
    
    mess.textMessage = dic[@"text"];
    mess.timeMessage = dic[@"time"];
    mess.type = [dic[@"type"] intValue];
    
    
    return mess;
}

@end
