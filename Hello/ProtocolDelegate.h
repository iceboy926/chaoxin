//
//  ProtocolDelegate.h
//  Hello
//
//  Created by 111 on 15-6-18.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocolDelegate <NSObject>

@required

-(NSString *)Req_Error;


@optional

-(NSString *)Opt_other;


@end
