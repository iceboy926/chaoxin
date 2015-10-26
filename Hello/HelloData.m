//
//  HelloData.m
//  Hello
//
//  Created by 111 on 15-6-17.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "HelloData.h"
#import "HelloDataDelegate.h"

@implementation HelloData

@synthesize m_data;
@synthesize m_str;
@synthesize helloDataDelegate;

-(id) init
{
    if(self = [super init])
    {
        [self setM_str:@"m_str"];
        [self setM_data:[@"m_data" dataUsingEncoding:NSUTF8StringEncoding]];
        
    }
    
    return self;
}

-(void)Function
{
    NSString *str = @"hello data delegate";
    
    [helloDataDelegate ShowMessageData:str];
}

-(NSString *)Req_Error
{
    NSString *str = @"Req_error";
    
    return str;
}

@end
