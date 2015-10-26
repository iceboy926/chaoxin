//
//  MessageTableViewCell.h
//  Hello
//
//  Created by 111 on 15-7-13.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageCellFrameModel;

@interface MessageTableViewCell : UITableViewCell
{
    UILabel *_timeLabel;
    UIImageView *_imageView;
    UIButton *_textView;
}

@property(nonatomic, strong) MessageCellFrameModel *MessageCellFrame;

-(void)setMessageCellFrame:(MessageCellFrameModel *)MessageCellFrame otherImage: (NSString *)imagestr;

@end
