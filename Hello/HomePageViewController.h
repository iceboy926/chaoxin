//
//  HomePageViewController.h
//  Hello
//
//  Created by 111 on 15-8-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UITableViewController
{
    int itemNum;
}

@property(strong, nonatomic) NSMutableArray *dataList;
@property(strong, nonatomic) NSMutableArray *CellList;
@property(strong, nonatomic) NSMutableArray *StatuseList;

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSMutableDictionary *dicRequestPara;
@end
