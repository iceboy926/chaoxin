//
//  NSString+Extension.h
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

-(CGSize) sizeWithFont:(UIFont *)font maxsize:(CGSize)maxsize;

+(NSString*)replaceUnicode:(NSString *)unicodeStr;

+(NSDate *)dateFromString:(NSString *)string;
@end
