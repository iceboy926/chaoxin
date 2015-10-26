//
//  AsynImageView.m
//  AsynImage
//
//  Created by administrator on 13-3-5.
//  Copyright (c) 2013年 enuola. All rights reserved.
//

#import "AsynImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+ResizeImage.h"
#import <CommonCrypto/CommonDigest.h>

@implementation AsynImageView

@synthesize imageURL = _imageURL;
@synthesize placeholderImage = _placeholderImage;

@synthesize fileName = _fileName;

@synthesize imageFilePath = _imageFilePath;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2.0;
        self.backgroundColor = [UIColor grayColor];
        
        memCacheDic = [[NSMutableDictionary alloc] init];
        
       // diskCachePathStr = [[NSMutableString alloc] init];
        
    }
    return self;
}

//重写placeholderImage的Setter方法
-(void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if(placeholderImage != _placeholderImage)
    {
        //[_placeholderImage release];
        
        _placeholderImage = placeholderImage;
        self.image = _placeholderImage;    //指定默认图片
    }
}

//重写imageURL的Setter方法
//-(void)setImageURL:(NSString *)imageURL
//{
//    if(imageURL != _imageURL)
//    {
//        self.image = _placeholderImage;    //指定默认图片
//       //[_imageURL release];
//        //_imageURL = [imageURL retain];
//        _imageURL = imageURL;
//    }
//    
//    if(_imageURL)
//    {
//        
//        //确定图片的缓存地址
//        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//        NSString *docDir=[path objectAtIndex:0];
//        NSString *tmpPath=[docDir stringByAppendingPathComponent:@"AsynImage"];
//        
//        NSFileManager *fm = [NSFileManager defaultManager];
//        if(![fm fileExistsAtPath:tmpPath])
//        {
//            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
//        }
//        NSArray *lineArray = [_imageURL componentsSeparatedByString:@"/"];
//        self.fileName = [NSString stringWithFormat:@"%@/%@", tmpPath, [lineArray objectAtIndex:[lineArray count] - 1]];
//        
//        //判断图片是否已经下载过，如果已经下载到本地缓存，则不用重新下载。如果没有，请求网络进行下载。
//        if(![[NSFileManager defaultManager] fileExistsAtPath:_fileName])
//        {
//            //下载图片，保存到本地缓存中
//            [self loadImage];
//        }
//        else
//        {
//            //本地缓存中已经存在，直接指定请求的网络图片
//            self.image = [UIImage imageWithContentsOfFile:_fileName];
//        }
//    }
//}

//带缓存的image加载

//处理网络图片缓存步骤：
//1、根据图片URL查找内存是否有这张图片，有则返回图片，没有则进入第二步
//2、查找物理存储是否有这张图片，有则返回图片，没有则进入第三步
//3、从网络上下载该图片，下载完后保存到内存和物理存储上，并返回该图片
//注：因为URL包含特殊字符和长度不确定，要对URL进行MD5处理或其他处理

-(NSString *)urlMD5:(NSString *)str
{
    const char *cstr = [str UTF8String];
    unsigned char result[16] = {0};
    CC_MD5(cstr, (CC_LONG)strlen(cstr), result);
    
    return [NSString stringWithFormat:@"%02X%02x%02X%02x%02X%02x%02X%02x%02X%02x%02X%02x%02X%02x%02X%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12],
            result[13], result[14], result[15]];
}


-(void)showImage:(NSString *)imageURL
{
    NSString *strFileName = [self urlMD5:imageURL];
    
    //1、查找内存缓存中是否有图片
    if([memCacheDic objectForKey:imageURL]) //有缓存
    {
        NSData *imageData = [memCacheDic objectForKey:imageURL];
        
        UIImage *imageTemp = [UIImage imageWithData:imageData];
        
        //[self setImageFilePath:filePath];
        
        _imageURL = imageURL;
    
        self.image = imageTemp;//[UIImage resizeImageView:imageTemp];
        
        //NSLogImage(self.image.size.width, self.image.size.height, loadData);
        
        return;
    }
    else  //内存中没有缓存,查找沙盒物理缓存中
    {
        
        NSArray *arrypath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        diskCachePathStr = [[arrypath objectAtIndex:0] stringByAppendingPathComponent:@"imageCache"];
        
        NSString *filePath = [diskCachePathStr stringByAppendingString:[NSString stringWithFormat:@"//%@", strFileName]];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        if(![fm fileExistsAtPath:diskCachePathStr]) //物理缓存文件夹不存在，则先创建文件夹，从网络下载图片后保存到物理缓存和内存中
        {
            [fm createDirectoryAtPath:diskCachePathStr withIntermediateDirectories:YES attributes:nil error:nil];
            
            //url 做MD5hash 作为文件名保存
            
            //创建文件
            BOOL blres = [fm createFileAtPath:filePath contents:nil attributes:nil];
            if(blres)
            {
                [self setImageFilePath:filePath];
                
                //下载完成后保存到物理缓存和内存缓存中
                [self setImageURL:imageURL];
                
                
            }
            else
            {
                NSLog(@"创建文件失败。。。。");
            }
            
        }
        else //文件夹存在
        {
            //1、判断URL MD5文件是否存在
            
            if([fm fileExistsAtPath:filePath]) //文件存在
            {
                //从文件中读取图片数据，转化为image对象
                NSData *imageData = [NSData dataWithContentsOfFile:filePath];
                UIImage *tempImage = [UIImage imageWithData:imageData];
                
                //保存到内存中
                [memCacheDic setObject:imageData forKey: imageURL];
                
                _imageURL = imageURL;
                
                [self setImageFilePath:filePath];
                
                self.image = tempImage;
                
            }
            else //文件不存在,则执行从网络下载图片
            {
                
                //创建文件
                BOOL blres = [fm createFileAtPath:filePath contents:nil attributes:nil];
                if(blres)
                {
                    [self setImageFilePath:filePath];
                    
                    //下载完成后保存到物理缓存和内存缓存中
                    [self setImageURL:imageURL];
                    
                    
                }
                else
                {
                    NSLog(@"创建文件失败。。。。");
                }
                
            }
            
        }
        
    }
    
}

-(void)setImageURL:(NSString *)imageURL
{
    if(imageURL != _imageURL)
    {
        self.image = _placeholderImage;    //指定默认图片
        _imageURL = imageURL;
    }
    
    if(_imageURL)
    {
        [self loadImage];
    }
    
}

//网络请求图片，缓存到本地沙河中
-(void)loadImage
{
    //对路径进行编码
    @try {
        //请求图片的下载路径
        //定义一个缓存cache
        NSURLCache *urlCache = [NSURLCache sharedURLCache];
        /*设置缓存大小为1M*/
        [urlCache setMemoryCapacity:1*124*1024];
        
        //设子请求超时时间为30s
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_imageURL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
        
        //从请求中获取缓存输出
        NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
        if(response != nil)
        {
            //            NSLog(@"如果又缓存输出，从缓存中获取数据");
            [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
        }
        
        /*创建NSURLConnection*/
        if(!connection)
            connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        //开启一个runloop，使它始终处于运行状态
        
        UIApplication *app = [UIApplication sharedApplication];
        app.networkActivityIndicatorVisible = YES;

        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    }
    @catch (NSException *exception) {
        //        NSLog(@"没有相关资源或者网络异常");
    }
    @finally {
        ;//.....
    }
}

#pragma mark - NSURLConnection Delegate Methods
//请求成功，且接收数据(每接收一次调用一次函数)
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(loadData==nil)
    {
        loadData=[[NSMutableData alloc]initWithCapacity:2048];
    }
    [loadData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
}

-(NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return cachedResponse;
    //    NSLog(@"将缓存输出");
}

-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    //    NSLog(@"即将发送请求");
    return request;
}
//下载完成，将文件保存到沙河里面
-(void)connectionDidFinishLoading:(NSURLConnection *)theConnection
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    self.image = [UIImage imageWithData:loadData];
    
    NSData *imageZipData = UIImageJPEGRepresentation(self.image, 0.5);
    
    //保存到物理缓存中
    [imageZipData writeToFile:_imageFilePath atomically:YES];
    
    //保存到内存中
    [memCacheDic setObject:imageZipData forKey:_imageURL];
    

    connection = nil;
    loadData = nil;
    
}
//网络连接错误或者请求成功但是加载数据异常
-(void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
    UIApplication *app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = NO;
    
    //如果发生错误，则重新加载
    connection = nil;
    loadData = nil;
    [self loadImage];
}


@end
