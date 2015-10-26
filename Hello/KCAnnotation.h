//
//  KCAnnotation.h
//  Hello
//
//  Created by 111 on 15-7-24.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface KCAnnotation : NSObject<MKAnnotation>
//{
//    CLLocationCoordinate2D coordinate;
//    
//    NSString *title;
//    
//    NSString *subtitle;
//}

@property(nonatomic) CLLocationCoordinate2D coordinate;

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;

@property(nonatomic) UIImage *imagetitle;

@end
