//
//  NSString+Extension.m
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize)sizeWithFont:(UIFont *)font maxsize:(CGSize)maxsize
{
    NSDictionary *attr = @{NSFontAttributeName: font};
    
    return [self boundingRectWithSize:maxsize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

+(NSString*)replaceUnicode:(NSString *)unicodeStr
{
    NSString *tempstr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempstr2 = [tempstr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempstr3 = [[@"\"" stringByAppendingString:tempstr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempstr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *returnStr = [NSPropertyListSerialization propertyListFromData:tempData mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    return returnStr;
    //return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

+(NSDate *)dateFromString:(NSString *)string
{
//    if(!string)
//    {
//        return nil;
//    }
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
//    
//    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
//    
//    return [dateFormatter dateFromString:string];
    
    
    if(!string)
        return nil;
    
    struct tm tm;
    time_t t;
    string = [string substringFromIndex:4];
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%b %d %H:%M:%S %z %Y", &tm);
    tm.tm_isdst =-1;
    t= mktime(&tm);
    
    return [NSDate dateWithTimeIntervalSince1970:t];
}

@end
