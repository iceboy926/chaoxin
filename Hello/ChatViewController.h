//
//  ChatViewController.h
//  Hello
//
//  Created by 111 on 15-7-3.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>
{
    int itemNum;
}

@property(strong, nonatomic) NSMutableArray *dataList;
@property(strong, nonatomic) NSMutableArray *imageList;
@property(strong, nonatomic) NSMutableArray *friendList;
@property (weak, nonatomic) IBOutlet UITableView *uiTableViewdata;
@end
