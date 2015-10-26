//
//  MessageTableViewCell.m
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageCellFrameModel.h"
#import "MessageModel.h"
#import "UIImage+ResizeImage.h"

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundView = nil;
        self.backgroundColor = [UIColor clearColor];
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_timeLabel];
        
        _imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imageView];
        
        _textView = [UIButton buttonWithType:UIButtonTypeCustom];
        _textView.titleLabel.numberOfLines = 0;
        _textView.titleLabel.font = [UIFont systemFontOfSize:13];
        _textView.contentEdgeInsets = UIEdgeInsetsMake(textPadding, textPadding, textPadding, textPadding);
        [self.contentView addSubview:_textView];
        
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

-(void)setMessageCellFrame:(MessageCellFrameModel *)MessageCellFrame
{
    _MessageCellFrame = MessageCellFrame;
    
    MessageModel *message = MessageCellFrame.message;
    
    _timeLabel.frame = MessageCellFrame.timeFrame;
    _timeLabel.text = message.timeMessage;
    
    _imageView.frame = MessageCellFrame.imageFrame;
    NSString *strImage = message.type ? @"other" : @"me";
    _imageView.image = [UIImage imageNamed:strImage];
    
    _textView.frame = MessageCellFrame.textFrame;
    NSString *txtbg = message.type ? @"chat_recive_nor" : @"chat_send_nor";
    UIColor *txtcolor = message.type ? [UIColor blackColor] : [UIColor whiteColor];
    
    [_textView setTitleColor:txtcolor forState: UIControlStateNormal];
    [_textView setBackgroundImage:[UIImage resizeImage:txtbg] forState:UIControlStateNormal];
    [_textView setTitle:message.textMessage forState:UIControlStateNormal];
    
}

-(void)setMessageCellFrame:(MessageCellFrameModel *)MessageCellFrame otherImage: (NSString *)imagestr
{
    _MessageCellFrame = MessageCellFrame;
    
    MessageModel *message = MessageCellFrame.message;
    
    _timeLabel.frame = MessageCellFrame.timeFrame;
    _timeLabel.text = message.timeMessage;
    
    _imageView.frame = MessageCellFrame.imageFrame;
    NSString *strImage = message.type ? imagestr : @"me";
    _imageView.image = [UIImage imageNamed:strImage];
    
    _textView.frame = MessageCellFrame.textFrame;
    NSString *txtbg = message.type ? @"chat_recive_nor" : @"chat_send_nor";
    UIColor *txtcolor = message.type ? [UIColor blackColor] : [UIColor whiteColor];
    
    [_textView setTitleColor:txtcolor forState: UIControlStateNormal];
    [_textView setBackgroundImage:[UIImage resizeImage:txtbg] forState:UIControlStateNormal];
    [_textView setTitle:message.textMessage forState:UIControlStateNormal];
}

@end
