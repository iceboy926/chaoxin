//
//  FansTableViewCell.m
//  Hello
//
//  Created by 111 on 15-10-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "FansTableViewCell.h"

@implementation FansTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _IconView = [[AsynImageView alloc] init];
        _IconView.placeholderImage = [UIImage imageNamed:@"me"];
        _IconView.userInteractionEnabled = YES;
        _IconView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_IconView];
        
        
        _FansNameLable = [[UILabel alloc] init];
        _FansNameLable.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        _FansNameLable.textAlignment = NSTextAlignmentLeft;
        _FansNameLable.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_FansNameLable];
        
        _FansDescriptLabel = [[UILabel alloc] init];
        _FansDescriptLabel.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:12];
        _FansDescriptLabel.textAlignment = NSTextAlignmentLeft;
        _FansDescriptLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_FansDescriptLabel];
       
        
        _FansSourceLabel = [[UILabel alloc] init];
        _FansSourceLabel.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:12];
        _FansSourceLabel.textAlignment = NSTextAlignmentLeft;
        _FansSourceLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_FansSourceLabel];
        
        _FansfollowsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _FansfollowsBtn.showsTouchWhenHighlighted  = YES;
        _FansfollowsBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_FansfollowsBtn setBackgroundImage:[UIImage imageNamed:@"card_icon_addattention"] forState:UIControlStateNormal];
        [_FansfollowsBtn setBackgroundImage:[UIImage imageNamed:@"card_icon_attention"] forState:UIControlStateSelected];
        [_FansfollowsBtn addTarget:self action:@selector(followBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_FansfollowsBtn];
        
        
        
    }
    
    return self;
}


-(void)setFansFrame
{
    NSDictionary *viewDic = NSDictionaryOfVariableBindings(_IconView, _FansNameLable, _FansDescriptLabel, _FansSourceLabel, _FansfollowsBtn);
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_IconView(==60)]-[_FansNameLable(120)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDic]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_IconView(==60)]-[_FansDescriptLabel(120)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDic]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_IconView(==60)]-[_FansSourceLabel(120)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDic]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_IconView(==60)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDic]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_FansNameLable]-2-[_FansDescriptLabel(==_FansNameLable)]-2-[_FansSourceLabel(==_FansNameLable)]"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDic]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_FansfollowsBtn]-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:viewDic]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_FansfollowsBtn
                                                                 attribute:NSLayoutAttributeCenterY
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.contentView
                                                                 attribute:NSLayoutAttributeCenterY
                                                                multiplier:1
                                                                 constant:0]];
    
}

-(void)setFansData:(FansModel *)fansData
{
    [_IconView showImage:fansData.IconUrl];
    _FansNameLable.text = fansData.Name;
    _FansDescriptLabel.text = fansData.Descript;
    _FansSourceLabel.text = fansData.Source;
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

-(void)followBtnClick:(id)sender
{
    
    
}

@end
