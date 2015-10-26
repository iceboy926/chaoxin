//
//  TableViewCell.m
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "TableViewCell.h"
#import "HomeCellFrame.h"
#import "HomeCellModel.h"
#import "AsynImageView.h"
#import "UIImage+ResizeImage.h"
//#import <SDWebImage/UIImageView+WebCache.h>


@implementation TableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
         //头像
        _iconView = [[AsynImageView alloc] init];
        _iconView.placeholderImage = [UIImage imageNamed:@"cute_boy_1.png"];
        _iconView.userInteractionEnabled = YES;
        [self.contentView addSubview:_iconView];
        UITapGestureRecognizer *tapRecIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchUserIcon:)];
        [_iconView addGestureRecognizer:tapRecIcon];
        
        
        
        //name
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = NameFont;
        _nameLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:_nameLabel];
        
        UITapGestureRecognizer *tapGestR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchNameLabel:)];
        [_nameLabel addGestureRecognizer:tapGestR];
        
        
        
        //vip
        _vipView = [[UIImageView alloc] init];
        _vipView.image = [UIImage imageNamed:@"vip"];
        [self.contentView addSubview:_vipView];
        
        
        //timesource
        _timeSourceLabel = [[UILabel alloc] init];
        _timeSourceLabel.font = SourceFont;
        _timeSourceLabel.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_timeSourceLabel];
        
        
        //detail
        _detailLabel = [[PPLabel alloc] init];
        _detailLabel.delegate = self;
        _detailLabel.font = DetailFont;
        _detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
        
        
    
        //picture
        _pickView = [[UIView alloc] init];
        //_pickView.placeholderImage = [UIImage imageNamed:@"pickView"];
        _pickView.userInteractionEnabled = YES;
        [self.contentView addSubview:_pickView];
        
        
        _picArray = [[NSMutableArray alloc] init];
        
        
        
        //
        _retweetView = [[UIView alloc] init];
        _retweetView.userInteractionEnabled = YES;
        _retweetView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:1];
        _retweetView.layer.borderWidth = 0.5;
        _retweetView.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.contentView addSubview:_retweetView];
        
        
        _retweetLabel = [[PPLabel alloc] init];
        _retweetLabel.delegate = self;
        _retweetLabel.font = DetailFont;
        _retweetLabel.numberOfLines = 0;
        [_retweetView addSubview:_retweetLabel];
        
        _retweetPicView = [[UIView alloc] init];
        _retweetPicView.userInteractionEnabled = YES;
        [_retweetView addSubview:_retweetPicView];
        
        _retweetPicArray = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellFrame:(HomeCellFrame *)CellFrame
{
    _CellFrame = CellFrame;
    
    [self setHomeCellData];
    
    [self setHomeCellFrame];
}

-(void)setHomeCellData
{
    HomeCellModel *CellModel = _CellFrame.HomeCell;
    
    //_iconView.imageURL = CellModel.icon;
    
    [_iconView showImage:CellModel.icon];
    
    _nameLabel.text = CellModel.Name;
    
    if(CellModel.blVip)
    {
        _vipView.hidden = NO;
        _nameLabel.textColor = [UIColor redColor];
    }
    else
    {
        _vipView.hidden = YES;
        _nameLabel.textColor = [UIColor blackColor];
    }
    
    _timeSourceLabel.text = CellModel.timesource;
    
    _detailLabel.text = CellModel.detail;
    
    
    
    
    NSError *error = NULL;
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:&error];
    
    matchsArray = [detector matchesInString:_detailLabel.text options:0 range:NSMakeRange(0, _detailLabel.text.length)];
    
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(@[a-zA-Z0-9._\u4E00-\u9FA5]+)|#([a-zA-Z0-9._\u4E00-\u9FA5]*)#" options:0 error:nil];
    
    matchUserArray = [regex matchesInString:_detailLabel.text options:0 range:NSMakeRange(0, _detailLabel.text.length)];
    
    ArrayList = [matchsArray arrayByAddingObjectsFromArray:matchUserArray];
    
    [self highlightLinksWithIndex:NSNotFound];

    
    [_picArray removeAllObjects];
    
    for (UIView *view in _pickView.subviews) {
        [view removeFromSuperview];
    }
    
    if([CellModel.pictureArray count] > 0)
    {
        
        for(NSString *picrul in CellModel.pictureArray)
        {
            AsynImageView *asyImage = [[AsynImageView alloc] init];
            
            asyImage.placeholderImage = [UIImage imageNamed:@"pickView"];
            
            //asyImage.imageURL = picrul;
            [asyImage showImage:picrul];
            
            asyImage.userInteractionEnabled = YES;
            
            [_pickView addSubview:asyImage];
            
            UITapGestureRecognizer *tapRecIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchPicView:)];
            [asyImage addGestureRecognizer:tapRecIcon];
            
            [_picArray addObject:asyImage];
        }
        
        _pickView.hidden = NO;
    }
    else
    {
        _pickView.hidden = YES;
    }
    
    
    if(CellModel.blretweet)  //有转发
    {
        for(UIView *view in _retweetPicView.subviews)
        {
            [view removeFromSuperview];
        }
        
        [_retweetPicArray removeAllObjects];
        
        _retweetLabel.text = CellModel.retweetDetail;
        
        if([CellModel.retweetPictureArray count] > 0)
        {
            
            
            for(NSString *picrul in CellModel.retweetPictureArray)
            {
                AsynImageView *asyImage = [[AsynImageView alloc] init];
                
                asyImage.placeholderImage = [UIImage imageNamed:@"pickView"];
                
                //asyImage.imageURL = picrul;
                
                [asyImage showImage:picrul];
                
                asyImage.userInteractionEnabled = YES;
                
                [_retweetPicView addSubview:asyImage];
                
                UITapGestureRecognizer *tapRecIcon = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TouchPicView:)];
                [asyImage addGestureRecognizer:tapRecIcon];
                
                [_retweetPicArray addObject:asyImage];
            }
            
            
            _retweetPicView.hidden = NO;
        }
        else
        {
            _retweetPicView.hidden = YES;
        }

        _retweetView.hidden = NO;
    }
    else
    {
        _retweetView.hidden = YES;
    }
    
    
    
    
    
}

-(void)setHomeCellFrame
{
    
    _iconView.frame = _CellFrame.iconFrame;
    
    _nameLabel.frame = _CellFrame.nameFrame;
    
    _vipView.frame = _CellFrame.vipFrame;
    
    _timeSourceLabel.frame = _CellFrame.timesourceFrame;
    
    _detailLabel.frame = _CellFrame.detailFrame;
    
    if([_CellFrame.HomeCell.pictureArray count] > 0)
    {
        
        for(int i = 0; i < [_pickView.subviews count]; i++)
        {
            UIView *imageView = (UIView *)[_pickView.subviews objectAtIndex:i];
            imageView.frame =[[_CellFrame.pictFrameArray objectAtIndex:i] CGRectValue];
        }
        
        _pickView.frame = _CellFrame.pictureFrame;
    }
    
    if(_CellFrame.HomeCell.blretweet) //有转发
    {
        _retweetView.frame = _CellFrame.retweetViewFrame;
        
        _retweetLabel.frame = _CellFrame.retweetDetailFrame;
        
        if([_CellFrame.HomeCell.retweetPictureArray count] > 0)
        {
            for(int i = 0; i < [_retweetPicView.subviews count]; i++)
            {
                UIView *imageView = (UIView *)[_retweetPicView.subviews objectAtIndex:i];
                imageView.frame = [[_CellFrame.retweetPictureFrameArray objectAtIndex:i] CGRectValue];
            }
            
            _retweetPicView.frame = _CellFrame.retweetPictureFrame;
        }
    }
    
}

- (void)label:(PPLabel*)label didBeginTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
    [self highlightLinksWithIndex:charIndex];
}
- (void)label:(PPLabel*)label didMoveTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
    [self highlightLinksWithIndex:charIndex];
}
- (void)label:(PPLabel*)label didEndTouch:(UITouch*)touch onCharacterAtIndex:(CFIndex)charIndex
{
    [self highlightLinksWithIndex:NSNotFound];
    
    for (NSTextCheckingResult *match in ArrayList) {
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            
            NSRange matchRange = [match range];
            
            if ([self isIndex:charIndex inRange:matchRange]) {
                
                [self.delegate DidPushWebView:match.URL Index:self.Index];
                break;
            }
        }
        else if([match resultType] == NSTextCheckingTypeRegularExpression)
        {
            NSRange matchRange = [match range];
            
            if ([self isIndex:charIndex inRange:matchRange]) {
                
                [self.delegate DidPushWebView:[_detailLabel.text substringWithRange:matchRange]];
                break;
            }

        }
    }
}
- (void)label:(PPLabel*)label didCancelTouch:(UITouch*)touch
{
    [self highlightLinksWithIndex:NSNotFound];
}

- (BOOL)isIndex:(CFIndex)index inRange:(NSRange)range {
    return index > range.location && index < range.location+range.length;
}

- (void)highlightLinksWithIndex:(CFIndex)index {
    
    NSMutableAttributedString* attributedString = [_detailLabel.attributedText mutableCopy];
    
    for (NSTextCheckingResult *match in ArrayList) {
        
        if ([match resultType] == NSTextCheckingTypeLink) {
            
            NSRange matchRange = [match range];
            
            if ([self isIndex:index inRange:matchRange]) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:matchRange];
            }
            else {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:matchRange];
            }
            
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:matchRange];
        }
        else if([match resultType] == NSTextCheckingTypeRegularExpression)
        {
            NSRange matchRange = [match range];
            
            if ([self isIndex:index inRange:matchRange]) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:matchRange];
            }
            else {
                [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:matchRange];
            }
        }
    }
    
    _detailLabel.attributedText = attributedString;

    
}

- (void) TouchNameLabel:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)[tap view];
    
    if([_delegate respondsToSelector:@selector(DidTouchNamelabel:)])
    {
        [_delegate DidTouchNamelabel:label.text];
    }
}

- (void) TouchUserIcon:(UITapGestureRecognizer *)tap
{
    AsynImageView *iconView = (AsynImageView *)[tap view];
    if([_delegate respondsToSelector:@selector(DidTouchUserIcon: Index:)])
    {
        [_delegate DidTouchUserIcon:iconView Index:self.Index];
    }
}

- (void)TouchPicView:(UITapGestureRecognizer *)tap
{
    AsynImageView *picView = (AsynImageView *)[tap view];
//    if([_delegate respondsToSelector:@selector(DidTouchPicView:)])
//    {
//        [_delegate DidTouchPicView:picView];
//    }
    
    if([_delegate respondsToSelector:@selector(DidTouchPicAsyView:)])
    {
        [_delegate DidTouchPicAsyView:picView];
    }
}


@end
