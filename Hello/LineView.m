//
//  LineView.m
//  Hello
//
//  Created by 111 on 15-8-19.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGPoint pointstart = CGPointZero;
    
    pointstart.x = 0;
    pointstart.y = 0;
    
    CGPoint pointend = CGPointZero;
    
    pointend.x = self.frame.size.width;
    pointend.y = 0;
    
    //获得处理的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //指定直线样式
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    
    //指定直线宽度
    CGContextSetLineWidth(ctx, 1.0);
    
    //指定直线颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);
    
    
    
    CGContextMoveToPoint(ctx, pointstart.x, pointstart.y);
    
    
    CGContextAddLineToPoint(ctx, pointend.x, pointend.y);
    

    
    
    CGContextStrokePath(ctx);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
