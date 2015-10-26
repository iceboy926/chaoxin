//
//  MessageCellFrameModel.m
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "MessageCellFrameModel.h"
#import "MessageModel.h"
#import "NSString+Extension.h"

#define timeH 40
#define padding 10
#define imageW 40
#define imageH 40
#define textW 150


@implementation MessageCellFrameModel

-(void)setMessage:(MessageModel *)mess
{
    _message = mess;
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    if(_message.blShowTime)
    {
        CGFloat timeFrameX  = 0.0;
        CGFloat timeFrameY = 0.0;
        CGFloat timeFrameW = frame.size.width;
        CGFloat timeFrameH = timeH;
        
        _timeFrame = CGRectMake(timeFrameX, timeFrameY, timeFrameW, timeFrameH);
    }
    
    //image
    CGFloat imageFrameX = mess.type ? padding: (frame.size.width - padding - imageW);
    CGFloat imageFrameY = CGRectGetMaxY(_timeFrame);
    CGFloat imageFrameW = imageW;
    CGFloat imageFrameH = imageH;
    _imageFrame = CGRectMake(imageFrameX, imageFrameY, imageFrameW, imageFrameH);
    
    //text
    CGSize textMaxSize = CGSizeMake(textW, MAXFLOAT);
    CGSize textSize = [mess.textMessage sizeWithFont:[UIFont systemFontOfSize:14.0] maxsize: textMaxSize];
    CGSize textRealSize = CGSizeMake(textSize.width + textPadding*2, textSize.height + textPadding*2);
    CGFloat textFrameY = imageFrameY;
    CGFloat textFrameX = mess.type ? (2*padding + imageW): (frame.size.width - imageW - 2*padding - textRealSize.width);
    _textFrame = (CGRect){textFrameX, textFrameY, textRealSize};
    
    
    //cell height
    _cellHeight = MAX(CGRectGetMaxY(_imageFrame), CGRectGetMaxY(_textFrame));
    
    
    
}

@end
