//
//  AsynImageView.h
//  AsynImage
//
//  Created by administrator on 13-3-5.
//  Copyright (c) 2013年 enuola. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsynImageView : UIImageView
{
    NSURLConnection *connection;
    NSMutableData *loadData;
    NSMutableDictionary *memCacheDic;
    NSString *diskCachePathStr;
}
//图片对应的缓存在沙河中的路径
@property (nonatomic) NSString *fileName;

//指定默认未加载时，显示的默认图片
@property (nonatomic) UIImage *placeholderImage;
//请求网络图片的URL
@property (nonatomic) NSString *imageURL;

@property (nonatomic) NSString *imageFilePath;


-(void)showImage:(NSString *)imageURL;

@end
