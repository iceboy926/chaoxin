//
//  LoginViewController.m
//  Hello
//
//  Created by 111 on 15-7-1.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"
#import "LineView.h"
//#import <ShareSDK/ShareSDK.h>
//#import "WXApi.h"
#import "MainTabBarViewController.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"

typedef enum {
    UIImageRoundedCornerTopLeft = 1,
    UIImageRoundedCornerTopRight = 1 << 1,
    UIImageRoundedCornerBottomRight = 1 << 2,
    UIImageRoundedCornerBottomLeft = 1 << 3,
    UIImageRoundedCornerAll = 1|1<<1|1<<2|1<<3
} UIImageRoundedCorner;

#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface LoginViewController () <WBHttpRequestDelegate,WeiboSDKDelegate>

@end

@implementation LoginViewController
{
    MBProgressHUD *HUD;
    UIButton *button_sina;
    UIButton *button_qq;
    UIButton *button_weixin;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"登录";
    // Custom initialization
    [[XMPPManager ShareManager].xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:HUD];
    //	HUD.delegate = self;
	HUD.labelText = @"登录中...";
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bj"]];
	
   
    [self.uiLogInBT setBackgroundImage:[[UIImage imageNamed:@"LoginGreenBigBtn_HI"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateDisabled];
    
    [self.uiLogInBT setBackgroundImage:[[UIImage imageNamed:@"LoginGreenBigBtn"] stretchableImageWithLeftCapWidth:10 topCapHeight:15] forState:UIControlStateNormal];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidLogStatus:) name:XMPP_LOGIN_STATUS object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    //
    
    


    LineView *lineView1 = [[LineView alloc] initWithFrame:CGRectMake(30, SCREEN_HEIGHT - 50, 100, 0.5)];
    [self.view addSubview:lineView1];
    
    LineView *lineView2 = [[LineView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 + 30, SCREEN_HEIGHT - 50, 100, 0.5)];
    [self.view addSubview:lineView2];
    
    
    UILabel *label_text = [[UILabel alloc] initWithFrame:CGRectMake(130, SCREEN_HEIGHT - 55, lineView2.frame.origin.x - 130, 10)];
    
    label_text.text =@"其他登录方式";
    
    [label_text setFont:[UIFont systemFontOfSize:9.0]];
    
    [label_text setTextColor:[UIColor whiteColor]];
    
    [label_text setTextAlignment:NSTextAlignmentCenter];
    
    [label_text setBackgroundColor:[UIColor clearColor]];
    
    [self.view addSubview:label_text];
    
    
    
    
    
    
    button_sina = [UIButton buttonWithType:UIButtonTypeCustom];

    button_sina.frame = [self frameofsinaweiboButton];
    
    [button_sina setBackgroundImage:[UIImage imageNamed:@"sinaweibo"] forState: UIControlStateNormal];
    
    [button_sina addTarget:self action:@selector(LoginWithSinabo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button_sina];
    
    
    
    button_qq = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button_qq.frame = [self frameofqqButton];
    
    UIImage *image = [self roundedRectImage:[UIImage imageNamed:@"qq2"] withradius:10 cornerMask:UIImageRoundedCornerAll];
    
    [button_qq setBackgroundImage:image forState:UIControlStateNormal];
    
    [button_qq addTarget:self action:@selector(LoginWithqq) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button_qq];
    
    
    
    button_weixin = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button_weixin.frame = [self frameofweixinButton];
    
    [button_weixin setBackgroundImage:[UIImage imageNamed:@"weixin2"] forState: UIControlStateNormal];
    
    [button_weixin addTarget:self action:@selector(LoginWithweixin) forControlEvents: UIControlEventTouchUpInside];
    
    [self.view addSubview:button_weixin];
    
    
//    UILabel *lable_sina = [[UILabel alloc] initWithFrame:CGRectMake(button_sina.frame.origin.x, button_sina.frame.origin.y + button_sina.frame.size.height, button_sina.frame.size.width, 20)];
//    
//    lable_sina.text = @"微博";
//    
//    [self.view addSubview:lable_sina];
    
    
    // Do any additional setup after loading the view.
}


//使用第三方登录界面 sinaweibo 登录

-(void)LoginWithSinabo
{
    WBAuthorizeRequest *wbHttp = [WBAuthorizeRequest request];
    
    wbHttp.redirectURI = SinaWeiBo_redirectUri;
    wbHttp.scope = @"all";
    wbHttp.userInfo = @{@"SSO_From": @"LoginViewController",
                        @"Other_info": @"Login"};
    
    [WeiboSDK sendRequest:wbHttp];
    
    
//    [ShareSDK getUserInfoWithType:ShareTypeSinaWeibo authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
//    {
//        NSLog(@"%d", result);
//        if(result) //授权成功后，跳转到主页面
//        {
//            NSMutableDictionary *dicuser = [[NSMutableDictionary alloc] initWithCapacity:20];
//            
//            //NSLog(@"nickname = %@", [userInfo nickname]);
//            //NSLog(@"imageurl = %@", [userInfo profileImage]);
//            
//            [dicuser setObject:[userInfo uid] forKey:@"uid"];
//            [dicuser setObject:[userInfo nickname] forKey:@"nickname"];
//            [dicuser setObject:[userInfo profileImage] forKey:@"headImageurl"];
//            [dicuser setObject:[userInfo aboutMe] forKey:@"aboutme"];
//            [dicuser setObject:[userInfo url] forKey:@"url"];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:dicuser forKey:@"sinaweibo"];
//            
//            MainTabBarViewController *tabBar = [[MainTabBarViewController alloc] initWithNibName:@"MainTabBarViewController" bundle:nil];
//            
//            [self presentViewController:tabBar animated:YES completion:nil];
//            
//            
//            
//            //[self performSegueWithIdentifier:@"GoToMainViewSegue" sender:self];
//            
//        }
//        else
//        {
//            
//        }
//    }];
    
}

-(void)LoginWithqq
{
    NSLog(@"loginwithqqzone");
    
//    [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
//     {
//         NSLog(@"%d", result);
//         if(result) //成功登录后
//         {
//             //[userInfo ]
//             
//             
//         }
//         else
//         {
//             
//         }
//     }];
    
}


-(void)LoginWithweixin
{
    NSLog(@"LoginWithweixin");
//    
//    [ShareSDK getUserInfoWithType:ShareTypeWeixiFav authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error)
//     {
//         NSLog(@"%d", result);
//         if(result) //成功登录后
//         {
//             
//             
//             
//         }
//     }];
//
    
//    BOOL blret = [WXApi openWXApp];
//    
//    if(blret)
//    {
//        NSLog(@"open WXApp");
//    }
    
}

-(CGRect)frameofsinaweiboButton
{
    CGRect rect = CGRectZero;
    
    CGSize Size = button_sina.bounds.size;
    
    if(CGSizeEqualToSize(Size, CGSizeZero))
    {
        Size = CGSizeMake(25, 25);
    }
    
    rect = CGRectMake(SCREEN_WIDTH/4 - Size.width/2, SCREEN_HEIGHT - 35, Size.width, Size.height);
    
    return rect;
}

-(CGRect)frameofqqButton
{
    CGRect rect = CGRectZero;
    
    CGSize size = button_qq.bounds.size;
    
    if(CGSizeEqualToSize(size,CGSizeZero))
    {
        size = CGSizeMake(25, 25);
    }
    
    rect = CGRectMake(SCREEN_WIDTH/2 - size.width/2, SCREEN_HEIGHT - 35, size.width, size.height);
    
    return rect;
}

-(CGRect)frameofweixinButton
{
    CGRect rect = CGRectZero;
    
    CGSize size = button_weixin.bounds.size;
    
    if(CGSizeEqualToSize(size,CGSizeZero))
    {
        size = CGSizeMake(25, 25);
    }
    
    rect = CGRectMake(SCREEN_WIDTH*3/4 - size.width/2, SCREEN_HEIGHT - 35, size.width, size.height);
    
    return rect;
}

- (UIImage *)roundedRectImage:(UIImage *)srcimage withradius:(float)radius cornerMask:(UIImageRoundedCorner)cornerMask
{
    UIImageView *bkImageViewTmp = [[UIImageView alloc] initWithImage:srcimage];
    
    int w = srcimage.size.width;
    int h = srcimage.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    [self addRoundedRectToPath:context withrect:bkImageViewTmp.frame radius:radius mask:cornerMask];
    
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), srcimage.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage    *newImage = [UIImage imageWithCGImage:imageMasked];
    
    CGImageRelease(imageMasked);
    
    return newImage;
}

-(void)addRoundedRectToPath:(CGContextRef)context withrect:(CGRect)rect radius:(float)radius mask:(UIImageRoundedCorner)cornerMask
{
    //原点在左下方，y方向向上。移动到线条2的起点。
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
    
    //画出线条2, 目前画线的起始点已经移动到线条2的结束地方了。
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
    
    //如果左上角需要画圆角，画出一个弧线出来。
    if (cornerMask & UIImageRoundedCornerTopLeft) {
        
        //已左上的正方形的右下脚为圆心，半径为radius， 180度到90度画一个弧线，
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius,
                        radius, M_PI, M_PI / 2, 1);
    }
    
    else {
        //如果不需要画左上角的弧度。从线2终点，画到线3的终点，
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
        
        //线3终点，画到线4的起点
        CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y + rect.size.height);
    }
    
    //画线4的起始，到线4的终点
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius,
                            rect.origin.y + rect.size.height);
    
    //画右上角
    if (cornerMask & UIImageRoundedCornerTopRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius,
                        rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height - radius);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
    
    //画右下角弧线
    if (cornerMask & UIImageRoundedCornerBottomRight) {
        CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius,
                        radius, 0.0f, -M_PI / 2, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y);
    }
    
    CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
    
    //画左下角弧线
    if (cornerMask & UIImageRoundedCornerBottomLeft) {
        CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius,
                        -M_PI / 2, M_PI, 1);
    }
    else {
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
        CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + radius);
    }
    
    CGContextClosePath(context);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)SetField: (UITextField *)field forkey: (NSString *)key
{
    if(field.text != nil)
    {
        [[NSUserDefaults standardUserDefaults] setObject:field.text forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
}

-(BOOL)CheckInputVaild
{
    BOOL blVaild = YES;
    
    if(self.uiUserNameTF.text.length == 0)
    {
        [self.uiUserNameTF becomeFirstResponder]; // 弹出键盘
        blVaild = NO;
    }
    else if(self.uiPassWordTF.text.length == 0)
    {
        [self.uiPassWordTF becomeFirstResponder]; //弹出键盘
        blVaild = NO;
    }
    
    return blVaild;
}

- (IBAction)TextFile_DidEnd:(id)sender {
    [_uiPassWordTF becomeFirstResponder];
    
}
- (IBAction)Password_Done:(id)sender {
    [_uiPassWordTF resignFirstResponder];
}

- (IBAction)LogIn:(id)sender {
    
    //[self performSegueWithIdentifier:@"GoToMainViewSegue" sender:self];
    //return ;
    
    if([self CheckInputVaild])
    {
        [self SetField:self.uiUserNameTF forkey: XMPP_USER_ID];
        [self SetField:self.uiPassWordTF forkey: XMPP_PASSWORD];
        
        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        
        //id mainstoryboard = [storyboard instantiateViewControllerWithIdentifier:@"LogInView"];
        
        Reachability *reach = [Reachability reachabilityForInternetConnection];
        if([reach currentReachabilityStatus] == NotReachable)
        {
            HUD.labelText = @"网络未连接";
        }
        else
        {
            //[[XMPPManager ShareManager] ConnectThenLogin];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:XMPP_LOGIN_STATUS object:self userInfo:@{XMPP_LOGIN_KEY:[NSNumber numberWithBool:YES]}];
            
        }
        
        
        
        // MBProgressHUD后台新建子线程执行登录服务器并用户认证
        [HUD showWhileExecuting:@selector(waitlogin) onTarget:self withObject:nil animated:YES];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入账号或密码！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        
        [alert show];
    }
    
}


-(void)DidLogStatus:(NSNotification *) notification
{
    NSDictionary *dic = [notification userInfo];
    
    NSNumber *number = [dic objectForKey:XMPP_LOGIN_KEY];
    
    BOOL blLoginStatus = [number boolValue];
    
    if(blLoginStatus == YES)
    {
        //[self performSegueWithIdentifier:@"GoToMainViewSegue" sender:self];
        
        [self LoginWithSinabo];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登录失败，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        
        [alert show];
    }
}

// 子线程中
-(void) waitlogin {
    // 显示进度条
    sleep(5);
    
    // 返回主线程执行
    //[self  performSelectorOnMainThread:@selector(goToMainView:) withObject:Data waitUntilDone:YES];
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.uiUserNameTF == textField || self.uiPassWordTF == textField)
    {
        [textField resignFirstResponder];
    }
    
    return FALSE;
}


- (IBAction)clickBackground:(id)sender
{
    //DEBUG_LOG(@"click background .....");
    
    [sender endEditing:YES];
}


- (void)KeyboardWillShow:(NSNotification *)note
{
    NSDictionary *userInfo = [note userInfo];
    
    NSValue *avalue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardrect = [avalue CGRectValue];
    
    CGFloat yfloat = keyboardrect.origin.y - self.view.frame.size.height;
    
    NSValue *animationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^(void)
     {
         self.view.transform = CGAffineTransformMakeTranslation(0, yfloat);
     }];
}

- (void)keyboardwillHide:(NSNotification *)note
{
    
    NSDictionary* userInfo = [note userInfo];
    
    NSValue *avalue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardrect = [avalue CGRectValue];
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    
    [animationDurationValue getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration animations:^(void)
     {
         self.view.transform = CGAffineTransformMakeTranslation(0, (self.view.frame.size.height-keyboardrect.origin.y));
     }];
}

#pragma mark -
#pragma WeiBoSDKDelegate

/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if([response isKindOfClass:WBAuthorizeRequest.class]) //
    {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        
        NSMutableDictionary *dicuser = [[NSMutableDictionary alloc] initWithCapacity:20];
    
        NSLog(@"access_token is %@", self.wbtoken);
        
    
        [dicuser setObject:self.wbtoken forKey:@"access_token"];
        [dicuser setObject:self.wbCurrentUserID forKey:@"userID"];
     
        [[NSUserDefaults standardUserDefaults] setObject:dicuser forKey:@"sinaweibo"];
        
        MainTabBarViewController *tabBar = [[MainTabBarViewController alloc] initWithNibName:@"MainTabBarViewController" bundle:nil];
        
        [self presentViewController:tabBar animated:YES completion:nil];
    }
}



#pragma mark -
#pragma WBHttpRequestDelegate

///**
// 收到一个来自微博Http请求的响应
// 
// @param response 具体的响应对象
// */
//
//- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
//{
//    
//}
//
///**
// 收到一个来自微博Http请求失败的响应
// 
// @param error 错误信息
// */
//
//- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
//{
//    
//}
//
///**
// 收到一个来自微博Http请求的网络返回
// 
// @param result 请求返回结果
// */
//
//- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
//{
//    
//}
//
///**
// 收到一个来自微博Http请求的网络返回
// 
// @param data 请求返回结果
// */
//
//- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
//{
//    
//}
//
///**
// 收到快速SSO授权的重定向
// 
// @param URI
// */
//
//- (void)request:(WBHttpRequest *)request didReciveRedirectResponseWithURI:(NSURL *)redirectUrl
//{
//    
//}


@end

