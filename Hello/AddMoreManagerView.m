//
//  AddMoreManagerView.m
//  Hello
//
//  Created by 111 on 15-7-17.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "AddMoreManagerView.h"
#import "AddMoreView.h"
#import "ChatMorePage_1_View.h"
#import "ChatMorePage_2_View.h"


#define AddMorePageControlHeight 30

#define Pages 2

@implementation AddMoreManagerView

@synthesize scrollview = _scrollview;
@synthesize pageControl = _pageControl;
@synthesize MoreView1 = _MoreView1;
@synthesize MoreView2 = _MoreView2;
@synthesize delegete = _delegete;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, 320, 216);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       [self Setup];
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame withDeleget:(id)delegete
{
    frame = CGRectMake(0, 0, 320, 216);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        
    }
    return self;
}

-(void)Setup
{
    self.backgroundColor = [UIColor whiteColor];
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - AddMorePageControlHeight)];
    
    _scrollview.pagingEnabled = YES;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.contentSize = CGSizeMake(CGRectGetWidth(_scrollview.frame)*Pages, CGRectGetHeight(_scrollview.frame));
    _scrollview.delegate = self;
    
    [self addSubview:_scrollview];
    
    
//    //for(int i = 0; i < Pages; i++)
//    {
//        _MoreView1 = [[AddMoreView alloc] initWithFrame:CGRectMake(0*CGRectGetWidth(_scrollview.frame), 0, CGRectGetWidth(_scrollview.frame), CGRectGetHeight(_scrollview.frame)) page:0];
//        [_scrollview addSubview:_MoreView1];
//        
//        _MoreView2 = [[AddMoreView alloc] initWithFrame:CGRectMake(1*CGRectGetWidth(_scrollview.frame), 0, CGRectGetWidth(_scrollview.frame), CGRectGetHeight(_scrollview.frame)) page:1];
//        [_scrollview addSubview:_MoreView2];
//    }
    
    {
        _PageView_1 = [[ChatMorePage_1_View alloc] initWithFrame:CGRectMake(0*CGRectGetWidth(_scrollview.frame), 0, CGRectGetWidth(_scrollview.frame), CGRectGetHeight(_scrollview.frame))];
        _PageView_1.delegete = self;
        [_scrollview addSubview:_PageView_1];
        
        _PageView_2 = [[ChatMorePage_2_View alloc] initWithFrame:CGRectMake(1*CGRectGetWidth(_scrollview.frame), 0, CGRectGetWidth(_scrollview.frame), CGRectGetHeight(_scrollview.frame))];
        _PageView_2.delegete = self;
        [_scrollview addSubview:_PageView_2];
    }
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_scrollview.frame), self.frame.size.width, AddMorePageControlHeight)];
    
    [_pageControl addTarget:self action:@selector(PageChanged:) forControlEvents: UIControlEventValueChanged];
    
    _pageControl.numberOfPages = Pages;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    [self addSubview:_pageControl];
    
}


-(void)PageChanged:(UIPageControl *)sender
{
    //int pagecount = [sender currentPage];
    
    NSLog(@"page changed....Page ");
    
}

-(void)PotoPicked
{
    NSLog(@"addmoremanager PotoPicked............");
    if(_delegete && [_delegete respondsToSelector:@selector(PotoPicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete PotoPicked];
        });
    }
    
}

-(void)CameraPicked
{
    NSLog(@"addmoremanager CameraPicked............");
    if(_delegete && [_delegete respondsToSelector:@selector(CameraPicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete CameraPicked];
        });
    }}

-(void)VideoPicked
{
    if(_delegete && [_delegete respondsToSelector:@selector(VideoPicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete VideoPicked];
        });
    }
}

-(void)SharePicked
{
    if(_delegete && [_delegete respondsToSelector:@selector(SharePicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete SharePicked];
        });
    }
}

-(void)LocationPicked
{
    if(_delegete && [_delegete respondsToSelector:@selector(LocationPicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete LocationPicked];
        });
    }
    
}

-(void)PayByPicked
{
    if(_delegete && [_delegete respondsToSelector:@selector(PayByPicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete PayByPicked];
        });
    }
}

-(void)ChatAudioPicked
{
    if(_delegete && [_delegete respondsToSelector:@selector(ChatAudioPicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete ChatAudioPicked];
        });
    }
}

-(void)ChatVideoPicked
{
    if(_delegete && [_delegete respondsToSelector:@selector(ChatVideoPicked)])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_delegete ChatVideoPicked];
        });
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll ");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView     // called when scroll view grinds to a halt
{
    int index = fabs(scrollView.contentOffset.x)/self.frame.size.width;
    
    [_pageControl setCurrentPage:index];
    
    NSLog(@"scrollview did end...page %d", index);
    
}

-(void)setBlock:(AddMoreBlock)block
{
    [_MoreView1 setBlock:block];
    [_MoreView2 setBlock:block];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
