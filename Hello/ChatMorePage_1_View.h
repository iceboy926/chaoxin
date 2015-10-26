//
//  ChatMorePage_1_View.h
//  Hello
//
//  Created by 111 on 15-7-21.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatMorePageViewDelegete.h"

@interface ChatMorePage_1_View : UIView


@property(nonatomic, strong)id<ChatMorePageViewDelegete> delegete;


@property(nonatomic, strong) UIButton *PotoBtn;
@property(nonatomic, strong) UIButton *CamareBtn;
@property(nonatomic, strong) UIButton *VideoBtn;
@property(nonatomic, strong) UIButton *ShareBtn;
@property(nonatomic, strong) UIButton *LocationBtn;
@property(nonatomic, strong) UIButton *PayByBtn;
@property(nonatomic, strong) UIButton *ChatAudioBtn;
@property(nonatomic, strong) UIButton *ChatVideoBtn;


@end
