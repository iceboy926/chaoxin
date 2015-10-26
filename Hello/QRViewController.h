//
//  QRViewController.h
//  Hello
//
//  Created by 111 on 15-10-20.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRViewController : UIViewController


@property (nonatomic, copy) void (^QRCodeSuncessBlock) (QRViewController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^QRCodeFailBlock) (QRViewController *);//扫描失败

@end
