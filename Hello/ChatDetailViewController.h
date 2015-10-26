//
//  ChatDetailViewController.h
//  Hello
//
//  Created by 111 on 15-7-10.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMoreManagerView.h"

@interface ChatDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AddMoreManangerDelegete>
{
    NSMutableArray *CellFrameData;
    UIImageView *_toolbarView;
    UITableView *_chatView;
    
}

@property int itemSelected;
@property (strong, nonatomic) IBOutlet UITableView *TableView;

@end
