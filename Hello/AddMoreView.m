//
//  AddMoreView.m
//  Hello
//
//  Created by 111 on 15-7-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "AddMoreView.h"

#define RowDistance 16
#define ColDistance 30

#define RowCount 2
#define ColCount 4

#define ImageWidth 60
#define ImageHeight 60


@implementation AddMoreView


- (id)initWithFrame:(CGRect)frame
{
    //frame = CGRectMake(0, 0, 320, 160);
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        
        UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(16, 10, 60, 60)];
        [button1 setBackgroundImage:[UIImage imageNamed:@"addmore_pic"] forState:UIControlStateNormal];
        button1.tag = 1;
        [button1 addTarget:self action:@selector(TapBtnTouchIn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(92, 10, 60, 60)];
        [button2 setBackgroundImage:[UIImage imageNamed:@"addmore_camera"] forState:UIControlStateNormal];
        button2.tag = 2;
        [button2 addTarget:self action:@selector(TapBtnTouchIn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        
        UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(168, 10, 60, 60)];
        [button3 setBackgroundImage:[UIImage imageNamed:@"addmore_video"] forState:UIControlStateNormal];
        button3.tag = 3;
        [button3 addTarget:self action:@selector(TapBtnTouchIn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        
        UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(244, 10, 60, 60)];
        [button4 setBackgroundImage:[UIImage imageNamed:@"addmore_location"] forState: UIControlStateNormal];
        button4.tag = 4;
        [button4 addTarget:self action:@selector(TapBtnTouchIn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button4];
        
        
        // Initialization code
    }
    return self;
}


-(id)initWithFrame:(CGRect)frame page:(int)index
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        for(int i = 0 ; i < RowCount; i++)
        {
            for(int j = 0; j < ColCount; j++)
            {
                CGFloat xPoint = (j+1)*RowDistance + j*ImageWidth;
                CGFloat yPoint = (i+1)*ColDistance + i*ImageHeight;
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(xPoint, yPoint, ImageWidth, ImageHeight)];
                
                NSString *imageIndex = [NSString stringWithFormat:@"addmore_%i", (8*index + j+i*ColCount + 1)];
                
                [button setBackgroundImage:[UIImage imageNamed:imageIndex] forState:UIControlStateNormal];
                
                [button setTag:(8*index + j+i*ColCount + 1)];
                
                [button addTarget:self action:@selector(TapBtnTouchIn:) forControlEvents: UIControlEventTouchUpInside];
                
                [self addSubview:button];
            }
        }
    }
    
    return self;
}

-(void)TapBtnTouchIn:(UIButton *)sender
{
    self.block(sender.tag);
}


-(void)setAddMoreBlock:(AddMoreBlock)block
{
    self.block = block;
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
