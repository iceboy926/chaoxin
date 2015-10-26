//
//  ChatDetailViewController.m
//  Hello
//
//  Created by 111 on 15-7-10.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "ChatDetailViewController.h"
#import "MessageCellFrameModel.h"
#import "MessageModel.h"
#import "MessageTableViewCell.h"
#import "AddMoreView.h"

#import "MapLocatView.h"


#define kToolBarH 44
#define kTextFieldH 30

@interface ChatDetailViewController ()

@property(nonatomic, strong) UIButton *sendSoundBtn;
@property(nonatomic, strong) UIButton *addMoreBtn;
@property(nonatomic, strong) UIButton *expressBtn;
//切换键盘
@property (nonatomic, strong) UIButton *changeKeyBoardButton;

//发送语音的按钮
@property (nonatomic, strong) UIButton *sendVoiceButton;

@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) AddMoreView *MoreView;

@property(nonatomic, strong) AddMoreManagerView *MoreManageView;

@property(nonatomic,strong) UIImagePickerController *imagePiceker;


@end

@implementation ChatDetailViewController
@synthesize itemSelected = _itemSelected;
@synthesize imagePiceker = _imagePiceker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURL *pUrl = [[NSBundle mainBundle] URLForResource:@"friendsInfo" withExtension:@"plist"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfURL:pUrl];
    NSString *key = [NSString stringWithFormat:@"%i", self.itemSelected+1];
    NSString *titleName = [[dict objectForKey:key] objectForKey:@"name"];
    
    self.title = titleName;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    
    [self loadData];
    [self addChatView];
    
    [self addToolBar];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSLog(@"camera");
    }
    if([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        NSLog(@"photoLibrary");
    }
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        NSLog(@"album");
    }
    
    

    
    
    
    //[[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

/**
*  记载数据
*/
- (void)loadData
{
    CellFrameData =[NSMutableArray array];
    
    //NSURL *dataUrl = [[NSBundle mainBundle] URLForResource:@"messages.plist" withExtension:nil];
    
    NSArray *patharry = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *pathstr = [patharry objectAtIndex:0];
    NSString *filepath = [pathstr stringByAppendingPathComponent:@"messages.plist"];
    
    NSLog(@"paee is %@", filepath);
    
    
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:filepath];
    for (NSDictionary *dict in dataArray) {
        MessageModel *message = [MessageModel MessageModelWithDic:dict];
        MessageCellFrameModel *lastFrame = [CellFrameData lastObject];
        MessageCellFrameModel *cellFrame = [[MessageCellFrameModel alloc] init];
        message.blShowTime = ![message.timeMessage isEqualToString:lastFrame.message.timeMessage];
        cellFrame.message = message;
        [CellFrameData addObject:cellFrame];
    }
}


/**
 *  添加TableView
 */
- (void)addChatView
{
    self.view.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    UITableView *chatView = [[UITableView alloc] init];
    chatView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kToolBarH);
    //NSLog(@"frame is height = %f", self.view.frame.size.height);
    chatView.backgroundColor = [UIColor colorWithRed:235.0/255 green:235.0/255 blue:235.0/255 alpha:1.0];
    chatView.delegate = self;
    chatView.dataSource = self;
    chatView.separatorStyle = UITableViewCellSeparatorStyleNone;
    chatView.allowsSelection = NO;
    [chatView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEdit)]];
    _chatView = chatView;
    
    [self.view addSubview:chatView];
}

-(void)addToolBar
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.frame = CGRectMake(0, self.view.frame.size.height - kToolBarH, self.view.frame.size.width, kToolBarH);
    bgView.image = [UIImage imageNamed:@"chat_bottom_bg"];
    bgView.userInteractionEnabled = YES;
    _toolbarView = bgView;
    [self.view addSubview:bgView];
    
    self.changeKeyBoardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeKeyBoardButton.frame = CGRectMake(0, 0, kToolBarH, kToolBarH);
    [self.changeKeyBoardButton setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
    [self.changeKeyBoardButton addTarget:self action:@selector(tapChangeKeyBoardButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.changeKeyBoardButton];
    
    
    self.addMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addMoreBtn.frame = CGRectMake(self.view.frame.size.width - kToolBarH, 0, kToolBarH, kToolBarH);
    [self.addMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateNormal];
    [self.addMoreBtn setImage:[UIImage imageNamed:@"chat_bottom_up_nor"] forState:UIControlStateHighlighted];
    [self.addMoreBtn addTarget:self action:@selector(AddMoreBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.addMoreBtn];
    
    self.expressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.expressBtn.frame = CGRectMake(self.view.frame.size.width - kToolBarH * 2, 0, kToolBarH, kToolBarH);
    [self.expressBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateNormal];
    [self.expressBtn setImage:[UIImage imageNamed:@"chat_bottom_smile_nor"] forState:UIControlStateHighlighted];
    [self.expressBtn addTarget:self action:@selector(ExpressBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.expressBtn];
    
    self.textField = [[UITextField alloc] init];
    self.textField.returnKeyType = UIReturnKeySend;
    self.textField.enablesReturnKeyAutomatically = YES;
    self.textField.keyboardType = UIKeyboardTypeDefault;
    self.textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 1)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.frame = CGRectMake(kToolBarH, (kToolBarH - kTextFieldH) * 0.5, self.view.frame.size.width - 3 * kToolBarH, kTextFieldH);
    self.textField.background = [UIImage imageNamed:@"chat_bottom_textfield"];
    self.textField.delegate = self;
    [bgView addSubview:self.textField];
    
    
    self.sendVoiceButton = [[UIButton alloc] initWithFrame:self.textField.frame];
    [self.sendVoiceButton setBackgroundImage:[UIImage imageNamed:@"chat_bottom_textfield"] forState:UIControlStateNormal];
    [self.sendVoiceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sendVoiceButton setTitle:@"按住说话" forState:UIControlStateNormal];
    
    [self.sendVoiceButton addTarget:self action:@selector(tapSendVoiceButton:) forControlEvents:UIControlEventTouchUpInside];
    self.sendVoiceButton.hidden = YES;
    
    [bgView addSubview:self.sendVoiceButton];
    

//    __weak __block ChatDetailViewController *copy_self = self;
    self.MoreManageView = [[AddMoreManagerView alloc] initWithFrame:CGRectZero];
    self.MoreManageView.delegete = self;
//    [self.MoreManageView setBlock:^(NSInteger buttonFlag)
//     {
//         [copy_self AddMoreBlockFun:buttonFlag];
//     }
//     ];
    
    
    
    //给sendVoiceButton添加长按手势
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(sendvoiceBtnLongPress:)];
    
    longpress.minimumPressDuration = 0.2;
    
    [self.sendVoiceButton addGestureRecognizer:longpress];
    
}

#pragma mark - tableView的数据源和代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return CellFrameData.count;
}

- (MessageTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    //cell.MessageCellFrame = CellFrameData[indexPath.row];

    [cell setMessageCellFrame:CellFrameData[indexPath.row] otherImage:[NSString stringWithFormat:@"00%i.png", self.itemSelected+1]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCellFrameModel *cellFrame = CellFrameData[indexPath.row];
    return cellFrame.cellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - UITextField的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"text enter in");
    
    //1.获得时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    
    //2.创建一个MessageModel类
    MessageModel *message = [[MessageModel alloc] init];
    message.textMessage = textField.text;
    message.timeMessage = strDate;
    message.type = 0;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:message.textMessage,@"text",message.timeMessage, @"time",[NSNumber numberWithInt:message.type], @"type",nil];
    
    
    
    
    //3
    MessageCellFrameModel *cellframe = [[MessageCellFrameModel alloc] init];
    MessageCellFrameModel *lastcell = [CellFrameData lastObject];
    message.blShowTime = [lastcell.message.timeMessage isEqualToString:message.timeMessage];
    [cellframe setMessage:message];
    
    
    [CellFrameData addObject:cellframe];
    [_chatView reloadData];
    
    
    
    
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)  objectAtIndex:0]stringByAppendingPathComponent:@"messages.plist"];
    
    NSLog(@" ptah %@", path);
    
    NSMutableArray *apparry = [NSMutableArray arrayWithContentsOfFile:path];
    if(apparry == nil)
    {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:dic, nil];
        
        [array writeToFile:path atomically:YES];
    }
    else
    {
        [apparry addObject:dic];
        
        [apparry writeToFile:path atomically:YES];
    }
    

    
    
    
    
     textField.text = @"";
    
    return YES;
}

- (void)endEdit
{
    NSLog(@"endEdit  in");
    [self.view endEditing:YES];
}


-(void)keyboardwillChange:(NSNotification *)note
{
    //NSLog(@"%@", note.userInfo);
    
    NSDictionary *dic = [note userInfo];
    
    NSValue *value = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [value CGRectValue];
    
    CGFloat moveY = keyboardRect.origin.y - self.view.frame.size.height;
    
    
    NSValue *animationDurationValue = [dic objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations: ^(void){
        
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
        
    }];
    
    
   // [self moveInputBarWithKeyboardHeight:keyboardRect.size.height withDuration:animationDuration];
    
}

-(void)KeyboardWillHide:(NSNotification *)note
{
    NSDictionary *dic = [note userInfo];
    
    NSValue *value = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [value CGRectValue];
    
    CGFloat moveY = self.view.frame.size.height - keyboardRect.origin.y;
    
    
    NSValue *animationDurationValue = [dic objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:0.01 animations: ^(void){
        
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
        
    }];

}

-(void)tapChangeKeyBoardButton:(id)sender
{
    NSLog(@"soundBtnpressed ....");
    
    if(self.sendVoiceButton.hidden == YES)
    {
        self.textField.hidden = YES;
        self.sendVoiceButton.hidden = NO;
        
        [self.changeKeyBoardButton setImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateNormal];
        
        if([self.textField isFirstResponder])
        {
            [self.textField resignFirstResponder];
        }
    }
    else
    {
        self.sendVoiceButton.hidden = YES;
        self.textField.hidden = NO;
        
        [self.changeKeyBoardButton setImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
        
        if(![self.textField isFirstResponder])
        {
            [self.textField becomeFirstResponder];
        }
    }
    
    
}


-(void)AddMoreBtnPressed:(id)sender
{
    NSLog(@"addmorebtnPressed ...");
    
    if([self.textField.inputView isEqual:self.MoreManageView])
    {
        self.textField.inputView = nil;
        [self.textField reloadInputViews];
    }
    else
    {
        self.textField.inputView = self.MoreManageView;
        [self.textField reloadInputViews];
    }
    
    if(![self.textField isFirstResponder])
    {
        [self.textField becomeFirstResponder];
    }
    
    if(self.textField.hidden == YES)
    {
        self.textField.hidden = NO;
        self.sendVoiceButton.hidden = YES;
    }
    
}

-(void)ExpressBtnPressed:(id)sender
{
    NSLog(@"ExpressBtnPressed .....");
}

-(void)tapSendVoiceButton:(id)sender
{
    
}

-(void)sendvoiceBtnLongPress:(id)sender
{
    NSLog(@"longpress ........");
    
}


-(void)AddMoreBlockFun:(int)flag
{
    switch(flag)
    {
        case 1:
            [self presentViewController:_imagePiceker animated:YES completion:nil];
            break;
        
        default :
            NSLog(@"fun %i", flag);
            break;
    }
}

-(void)PotoPicked
{
    NSLog(@"PhotoPicked......");
    
    _imagePiceker = [[UIImagePickerController alloc] init];
    //_imagePiceker.view.backgroundColor = [UIColor orangeColor];
    _imagePiceker.SourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePiceker.delegate = self;
    
    [self presentViewController:_imagePiceker animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"imagepicker");
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagepicker cancel");
    
    [self dismissViewControllerAnimated:YES completion:^(void){
    }];
}


-(void)LocationPicked
{
    NSLog(@"location picked.....");
    
    MapLocatView *view = [[MapLocatView alloc] initWithNibName:@"MapLocatView" bundle:nil];
    
    //UINavigationController *nva = [[UINavigationController alloc] initWithRootViewController:view];
    
    [self presentViewController:view animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
