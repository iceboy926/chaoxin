//
//  JSHpple.m
//  Three20
//
//  Created by zy on 13-8-22.
//  Copyright (c) 2013年 zy. All rights reserved.
//

#import "JSHpple.h"

@implementation JSHpple

+(id)ShareHpple{
    static dispatch_once_t onceToken;
    static JSHpple *hpple=nil;
    dispatch_once(&onceToken, ^{
        hpple=[[JSHpple alloc] init];
    });
    return hpple;
}


-(NSArray *)HtmlWithData:(NSData *)data XPath:(NSString *)path{
    TFHpple *happen=[[TFHpple alloc] initWithHTMLData:data];
    NSArray *htmlContent=[happen searchWithXPathQuery:path];
    NSMutableArray *result=[NSMutableArray arrayWithCapacity:0];
    if (htmlContent.count<=0) {
        NSLog(@"没有解析到对应的数据");
        return nil;
    }
    for (TFHppleElement *ele in htmlContent) {
        NSString *content=[self SearchElement:ele];
        if (!content) {
            content=@"Null";
        }
        [result addObject:content];
    }
    
    return result;
    
}

-(NSString *)SearchElement:(TFHppleElement *)element{
      NSArray *childs=[element children];
    if (childs.count==1) {
        if ([[childs lastObject] isTextNode]) {//没有子节点
            return [element text];
        }
        else{//有子节点
            TFHppleElement *childElement=[childs lastObject];
            NSString *content=[self SearchElement:childElement];
            if (content) {
                return content;
            }
        }
    }
    return nil;
}


@end
