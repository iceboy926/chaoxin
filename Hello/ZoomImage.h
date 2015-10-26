//
//  ZoomImage.h
//  Hello
//
//  Created by 111 on 15-9-10.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZoomImage : NSObject <UIScrollViewDelegate>
{
    
}

@property (nonatomic, strong) UIImageView *imageView;

+(void)ShowImage:(UIImageView *)avatarImage;

-(void)ShowavatarImage:(UIImageView *)avatarImage;


+(void)HideImage:(UITapGestureRecognizer *)tap;

@end
