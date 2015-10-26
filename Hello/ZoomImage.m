//
//  ZoomImage.m
//  Hello
//
//  Created by 111 on 15-9-10.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ZoomImage.h"

@implementation ZoomImage

@synthesize imageView = _imageView;

static CGRect oldRect;

//显示大图
+(void)ShowImage:(UIImageView *)avatarImage
{
    UIImage *image = avatarImage.image;
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAX_WIDTH, MAX_HEIGHT)];
    
    oldRect = [avatarImage convertRect:avatarImage.frame toView:windows];
    
    background.backgroundColor = [UIColor blackColor];
    background.alpha = 0.5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:oldRect];
    
    imageView.image = image;
    
    imageView.tag = 1;
    
    [background addSubview:imageView];
    
    [windows addSubview:background];
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideImage:)];
    
    [background addGestureRecognizer:tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGFloat x = 0.0;
        CGFloat y = 0.0;
        CGFloat width = 0.0;
        CGFloat height = 0.0;
        
        
        
        if(image.size.width > MAX_WIDTH || image.size.height > MAX_HEIGHT)
        {
            
            CGFloat widthScal = image.size.width/MAX_WIDTH;
            CGFloat heightScal = image.size.height/MAX_HEIGHT;
            
            CGFloat Scal = MAX(widthScal, heightScal);
            
           
            width = image.size.width/Scal;
            height = image.size.height/Scal;
        

            x = MAX_WIDTH/2 - width/2;
            y = MAX_HEIGHT/2 -height/2;
        }
        else
        {
            x = MAX_WIDTH/2 - image.size.width/2;
            y = MAX_HEIGHT/2 - image.size.height/2;
            width = image.size.width;
            height = image.size.height;
        }
        
        imageView.frame = CGRectMake(x, y, width, height);
        
        background.alpha = 1;
    
    }];
    
    
}

//-(void)ShowavatarImage:(UIImageView *)avatarImage
//{
//    UIImage *image = avatarImage.image;
//    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
//    UIView *background = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    
//    [background addSubview:scrollView];
//    
//    
//    //oldRect = [avatarImage convertRect:avatarImage.frame toView:windows];
//    
//    background.backgroundColor = [UIColor blackColor];
//    background.alpha = 0.5;
//    
//    _imageView = [[UIImageView alloc] initWithImage:image];
//    
//    _imageView.tag = 1;
//
//    [scrollView addSubview:_imageView];
//    
//    [windows addSubview:background];
//    
//    scrollView.contentSize = image.size;
//    
//    scrollView.delegate = self;
//    
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(HideImage:)];
//    
//    [background addGestureRecognizer:tap];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        
//        CGFloat x = 0.0;
//        CGFloat y = 0.0;
//        CGFloat width = 0.0;
//        CGFloat height = 0.0;
//        
//        if(image.size.width > MAX_WIDTH || image.size.height > MAX_HEIGHT)
//        {
//            width = image.size.width;
//            height = image.size.height;
//        }
//        else
//        {
//            x = MAX_WIDTH/2 - image.size.width/2;
//            y = MAX_HEIGHT/2 - image.size.height/2;
//            width = image.size.width;
//            height = image.size.height;
//        }
//        
//        _imageView.frame = CGRectMake(x, y, width, height);
//        
//        background.alpha = 1;
//        
//    }];
//
//    
//}
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
//{
//    return _imageView;
//}


+(void)HideImage:(UITapGestureRecognizer *)tap
{
    UIView *background = tap.view;
    
    UIImageView *imageView = (UIImageView *)[tap.view viewWithTag:1];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageView.frame = oldRect;
        
        background.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [background removeFromSuperview];
    }];
}



@end
