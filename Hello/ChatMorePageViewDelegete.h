//
//  ChatMorePageViewDelegete.h
//  Hello
//
//  Created by 111 on 15-7-21.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RowDistance 16
#define ColDistance 30

#define RowCount 2
#define ColCount 4

#define ImageWidth 60
#define ImageHeight 60

@protocol ChatMorePageViewDelegete <NSObject>


@optional
-(void)PotoPicked;
-(void)CameraPicked;
-(void)VideoPicked;
-(void)SharePicked;
-(void)LocationPicked;
-(void)PayByPicked;
-(void)ChatAudioPicked;
-(void)ChatVideoPicked;

@end
