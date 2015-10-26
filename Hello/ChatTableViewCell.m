//
//  ChatTableViewCell.m
//  Hello
//
//  Created by 111 on 15-7-10.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ChatTableViewCell.h"

@implementation ChatTableViewCell

@synthesize image;
@synthesize Name;
@synthesize Message;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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


-(void)setImage:(UIImage *)i
{
    if(![image isEqual:i])
    {
        image = [i copy];
        self.imageView.image = image;
    }
}

-(void)setName:(NSString *)N
{
    if(![Name isEqualToString:N])
    {
        Name = [N copy];
        self.uiLabelName.text = Name;
    }
}

-(void)setMessage:(NSString *)Mes
{
    if(![Message isEqualToString:Mes])
    {
        Message = [Mes copy];
        self.uiLabelMessage.text = Message;
    }
}


@end
