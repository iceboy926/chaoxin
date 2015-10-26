//
//  GuidInViewController.m
//  Hello
//
//  Created by 111 on 15-8-17.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "GuidInViewController.h"


#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface GuidInViewController () <UIScrollViewDelegate, UIPageViewControllerDelegate>
{
    BOOL blOut;
}
@end

@implementation GuidInViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

-(id)initWithBackGroundImage :(NSArray *)imageArray
{
    if(self = [super init])
    {
        self.arryImage = imageArray;
        blOut = NO;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView = [[UIScrollView alloc] initWithFrame:SCREEN_FRAME];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*[self.arryImage count], SCREEN_HEIGHT);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    [self AddViewImage];
    
    
    _pageView = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-80, SCREEN_WIDTH, 30)];
    
    _pageView.currentPageIndicatorTintColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.0];
    
    _pageView.numberOfPages = [self.arryImage count];
    
    _pageView.currentPage = 0;
    
    [_pageView addTarget:self action:@selector(OnPointPicked) forControlEvents: UIControlEventValueChanged];
    
    
    
    [self.view addSubview:_pageView];
    
    
    self.EnterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.EnterButton.backgroundColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000];
    self.EnterButton.layer.borderWidth = 0.5;
    self.EnterButton.layer.borderColor = [UIColor colorWithRed:0.153 green:0.533 blue:0.796 alpha:1.000].CGColor;
    self.EnterButton.layer.cornerRadius = 8;
    
    self.EnterButton.frame = [self frameofEnterButton];
    
    self.EnterButton.alpha = 0;
    
    self.EnterButton.tintColor = [UIColor whiteColor];
    
    [self.EnterButton setTitle:@"立即体验" forState:UIControlStateNormal];
    
    [self.EnterButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:14]];
    
    [self.EnterButton addTarget:self action:@selector(OnEnter:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.EnterButton];
    
    
    
}


-(void)OnEnter:(id)object
{
    
    //[self dismissViewControllerAnimated:YES completion:^(){}];
    
    self.gotoMainPage();
}

-(void)AddViewImage
{
    for (int i = 0; i < [self.arryImage count]; i++)
    {
        //UIView *View = [[UIView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)/*SCREEN_FRAME*/];
        
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_index_0%ibg", (i+1)]];
        
        
        [_scrollView addSubview:imageView];
        
    }
}

-(CGRect)frameofEnterButton
{
    CGRect rect = CGRectZero;
    
    CGSize Size = self.EnterButton.bounds.size;
    
    if(CGSizeEqualToSize(Size, CGSizeZero))
    {
        Size = CGSizeMake(SCREEN_WIDTH*0.4, 30);
        //NSLog(@"Size = %@", Size);
    }
    
    rect = CGRectMake(SCREEN_WIDTH/2 - Size.width/2, SCREEN_HEIGHT - 40, Size.width, Size.height);
    
    //NSLog(@"rect = %@", rect);
    return rect;
}

-(void)DisappearScroll
{
    _scrollView.alpha = 0.0;
    _pageView.alpha = 0.0;
    _EnterButton.alpha = 0.0;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)OnPointPicked
{
    //CGFloat offsize =
    
    
    CGFloat offsetx = _pageView.currentPage*SCREEN_WIDTH;
    
    [UIView animateWithDuration:0.3 animations:^{
    
        _scrollView.contentOffset = CGPointMake(offsetx, 0);
    
    }];
    
    
    if(_pageView.currentPage == [self.arryImage count] - 1)
    {
        self.EnterButton.alpha = 1.0;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrollViewDisScroll");
    
    //NSLog(@"scrollView.contentOffset.x = %f", scrollView.contentOffset.x);
    
    if(scrollView.contentOffset.x > (([self.arryImage count] - 1)*SCREEN_WIDTH+30))
    {
        blOut = YES;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;      // called when scroll view grinds to a halt
{
    //NSLog(@"scrollViewDidEndDecelarating");
    int index = scrollView.contentOffset.x/SCREEN_WIDTH;
    
    _pageView.currentPage = index;
    
    if(index == [self.arryImage count] - 1)
    {
        self.EnterButton.alpha = 1.0;
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
