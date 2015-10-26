//
//  JSHpple.h
//  Three20
//
//  Created by zy on 13-8-22.
//  Copyright (c) 2013年 zy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"

@interface JSHpple : NSObject
+(id)ShareHpple;
-(NSArray *)HtmlWithData:(NSData *)data XPath:(NSString *)path;
@end
