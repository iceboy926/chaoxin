//
//  AddMoreView.h
//  Hello
//
//  Created by 111 on 15-7-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddMoreBlock)(NSInteger tag);

@interface AddMoreView : UIView



@property(nonatomic, strong)AddMoreBlock block;

-(void)setAddMoreBlock:(AddMoreBlock)block;

-(id)initWithFrame:(CGRect)frame page:(int)index;


@end
