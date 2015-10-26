//
//  MapLocatView.m
//  Hello
//
//  Created by 111 on 15-7-21.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "MapLocatView.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "KCAnnotation.h"
#import "AppDelegate.h"

#define SYSTEM_NAVIBAR_COLOR [UIColor colorWithRed:0 green:0 blue:0 alpha:1]
#define ISIOS8 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=8)
#define ISIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)
#define ISIOS6 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6)
#define STATUS_BAR_H 20
#define NAV_BAT_H 44

#define FRAME_WITH_NAV CGRectMake(0, 0, [self windowWidth], [self windowHeight] - STATUS_BAR_H - NAV_BAT_H)
#define FRAME_USER_LOC CGRectMake(8, [self windowHeight] - STATUS_BAR_H - NAV_BAT_H-58+64, 40, 40)
#define FRAME_CENTRE_LOC CGRectMake([self windowWidth]/2-8, ([self windowHeight] - STATUS_BAR_H - NAV_BAT_H)/2-25+64, 16, 33)s



@interface MapLocatView () <MKMapViewDelegate, CLLocationManagerDelegate>
{
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
}

@end

@implementation MapLocatView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self Addbackbutton];
    [self InitGUI];
    
}

- (NSInteger)windowWidth {
    return [[[[UIApplication sharedApplication] windows] objectAtIndex:0] frame].size.width;
}
- (NSInteger)windowHeight {
    return [[[[UIApplication sharedApplication] windows] objectAtIndex:0] frame].size.height;
}

-(void)Addbackbutton
{
   
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleBordered target:self action:@selector(DogoBack)];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
//    UIImage *norImage = [UIImage imageNamed:@"icon_back"];
//    UIImage *hightImage = [UIImage imageNamed:@"icon_back"];
//    
//    UIButton *buttonback = [UIButton buttonWithType:UIButtonTypeCustom];
//    buttonback.frame = CGRectMake(0, 0, 40, 44);
//    [buttonback addTarget:self action:@selector(DogoBack:) forControlEvents:UIControlEventTouchUpInside];
//    [buttonback setImage:norImage forState:UIControlStateNormal];
//    [buttonback setImage:hightImage forState:UIControlStateHighlighted];
//    [buttonback setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
//    [buttonback setTitle:@"返回" forState:UIControlStateNormal];
//    [buttonback setTitle:@"返回" forState:UIControlStateHighlighted];
//    [buttonback setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [buttonback setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
//    buttonback.titleLabel.textAlignment = NSTextAlignmentLeft;
//    buttonback.titleLabel.backgroundColor = [UIColor redColor];
//    buttonback.backgroundColor = [UIColor clearColor];
//    buttonback.backgroundColor = [UIColor whiteColor];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonback];
    
}

-(void)DogoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)InitGUI
{
    //CGRect frame = [[UIScreen mainScreen] bounds];
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
    
     _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    [self addAnnotationData];
    
    
    
    _locationManager = [[CLLocationManager alloc] init];
    
    if(![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorized)
    {
        
    }
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager startUpdatingLocation];
   
    
}

-(void)addAnnotationData
{
    CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(39.95, 116.35);
    KCAnnotation *annotation1 = [[KCAnnotation alloc] init];
    annotation1.title = @"CMJ title";
    annotation1.subtitle = @"CMJ sub title ";
    annotation1.coordinate = location1;
    annotation1.imagetitle = [UIImage imageNamed:@"icon_position"];
    
    [_mapView addAnnotation:annotation1];
    
}

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[KCAnnotation class]])
    {
        static NSString *strAnnotation = @"annotation1";
        MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:strAnnotation];
        
        if(annotationView == nil)
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:strAnnotation];
            
        }
        
        
        
        return annotationView;
        
    }
    else
        return nil;
    
}



- (void)locationManager:(CLLocationManager *)manager
	 didUpdateLocations:(NSArray *)locations
{
    NSLog(@"did updatelocation...");
    
    CLLocation *location = [locations firstObject];
    
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    NSLog(@"longitude is %f, latitude is %f, altitude is %f, course is %f, speed is %f", coordinate.longitude, coordinate.latitude, location.altitude, location.course, location.speed);
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShowTabBar:(BOOL)blret
{
    
    NSArray *views = [self.tabBarController.view subviews];
    for(id v in views){
        if([v isKindOfClass:[UITabBar class]]){
            [(UITabBar *)v setHidden:blret];
        }
    }
}


-(void)viewWillAppear:(BOOL)animated
{
    [self ShowTabBar:YES];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self ShowTabBar:NO];
    [super viewWillDisappear:animated];
}

@end
