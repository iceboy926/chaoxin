//
//  main.m
//  Hello
//
//  Created by 111 on 15-6-16.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "LoggerClient.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        LoggerSetViewerHost(NULL, NULL, 0);
        LoggerSetOptions(NULL, kLoggerOption_BufferLogsUntilConnection|kLoggerOption_UseSSL|kLoggerOption_CaptureSystemConsole|kLoggerOption_BrowseBonjour);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
