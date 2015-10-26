//
//  HelloData.h
//  Hello
//
//  Created by 111 on 15-6-17.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProtocolDelegate.h"

@interface HelloData : NSObject<ProtocolDelegate>
{
    NSString *m_str;
    NSData *m_data;
    id  helloDataDelegate;
}

@property(nonatomic, retain) NSString *m_str;
@property(nonatomic, retain) NSData *m_data;
@property(nonatomic, retain) id helloDataDelegate;

-(id) init;

-(void)Function;

@end
