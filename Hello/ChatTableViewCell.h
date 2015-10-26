//
//  ChatTableViewCell.h
//  Hello
//
//  Created by 111 on 15-7-10.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell
{
    int  itemNum;
}
@property (strong, nonatomic) IBOutlet UIImageView *uiImageTitle;
@property (strong, nonatomic) IBOutlet UILabel *uiLabelName;
@property (strong, nonatomic) IBOutlet UILabel *uiLabelMessage;


@property(copy, nonatomic) UIImage *image;
@property(copy, nonatomic) NSString *Name;
@property(copy, nonatomic) NSString *Message;

@end
