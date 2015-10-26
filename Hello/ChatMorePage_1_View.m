//
//  ChatMorePage_1_View.m
//  Hello
//
//  Created by 111 on 15-7-21.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ChatMorePage_1_View.h"

@implementation ChatMorePage_1_View

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGFloat xPoint = (0+1)*RowDistance + 0*ImageWidth;
        CGFloat yPoint = (0+1)*ColDistance + 0*ImageHeight;
        
        _PotoBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_PotoBtn setBackgroundImage:[UIImage imageNamed:@"addmore_1.png"] forState:UIControlStateNormal];
        [_PotoBtn addTarget:self action:@selector(PhotoPick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_PotoBtn];
        
        
        xPoint = (1+1)*RowDistance + 1*ImageWidth;
        yPoint = (0+1)*ColDistance + 0*ImageHeight;
        
        _CamareBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_CamareBtn setBackgroundImage:[UIImage imageNamed:@"addmore_2"] forState:UIControlStateNormal];
        [_CamareBtn addTarget:self action:@selector(CameraPic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_CamareBtn];
        
        
        xPoint = (2+1)*RowDistance + 2*ImageWidth;
        yPoint = (0+1)*ColDistance + 0*ImageHeight;
        
        _VideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_VideoBtn setBackgroundImage:[UIImage imageNamed:@"addmore_3"] forState:UIControlStateNormal];
        [_VideoBtn addTarget:self action:@selector(VideoPic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_VideoBtn];
        
        
        xPoint = (3+1)*RowDistance + 3*ImageWidth;
        yPoint = (0+1)*ColDistance + 0*ImageHeight;
        
        _ShareBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_ShareBtn setBackgroundImage:[UIImage imageNamed:@"addmore_4"] forState:UIControlStateNormal];
        [_ShareBtn addTarget:self action:@selector(SharePic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_ShareBtn];
        
        
        xPoint = (0+1)*RowDistance + 0*ImageWidth;
        yPoint = (1+1)*ColDistance + 1*ImageHeight;
        
        _LocationBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_LocationBtn setBackgroundImage:[UIImage imageNamed:@"addmore_5"] forState:UIControlStateNormal];
        [_LocationBtn addTarget:self action:@selector(LocationPick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_LocationBtn];
        
        
        xPoint = (1+1)*RowDistance + 1*ImageWidth;
        yPoint = (1+1)*ColDistance + 1*ImageHeight;
        
        _PayByBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_PayByBtn setBackgroundImage:[UIImage imageNamed:@"addmore_6"] forState:UIControlStateNormal];
        [_PayByBtn addTarget:self action:@selector(PayByPic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_PayByBtn];
        
        
        xPoint = (2+1)*RowDistance + 2*ImageWidth;
        yPoint = (1+1)*ColDistance + 1*ImageHeight;
        
        _ChatAudioBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_ChatAudioBtn setBackgroundImage:[UIImage imageNamed:@"addmore_7"] forState:UIControlStateNormal];
        [_ChatAudioBtn addTarget:self action:@selector(ChatAudioPic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_ChatAudioBtn];
        
        
        xPoint = (3+1)*RowDistance + 3*ImageWidth;
        yPoint = (1+1)*ColDistance + 1*ImageHeight;
        
        _ChatVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
        [_ChatVideoBtn setBackgroundImage:[UIImage imageNamed:@"addmore_8"] forState:UIControlStateNormal];
        [_ChatVideoBtn addTarget:self action:@selector(ChatVideoPic) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_ChatVideoBtn];

        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)PhotoPick
{
    [_delegete PotoPicked];
}

-(void)CameraPic
{
    [_delegete CameraPicked];
}

-(void)VideoPic
{
    [_delegete VideoPicked];
}

-(void)SharePic
{
    [_delegete SharePicked];
}

-(void)LocationPick
{
    [_delegete LocationPicked];
}

-(void)PayByPic
{
    [_delegete PayByPicked];
}

-(void)ChatAudioPic
{
    [_delegete ChatAudioPicked];
}

-(void)ChatVideoPic
{
    [_delegete ChatVideoPicked];
}

@end
