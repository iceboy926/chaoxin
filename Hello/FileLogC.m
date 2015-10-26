//
//  FileLogC.m
//  U61ICBCDemo
//
//  Created by lijian on 15-1-9.
//  Copyright (c) 2015年 DynamiCode. All rights reserved.
//

#import "FileLogC.h"
#import <Foundation/Foundation.h>
#import <mach/mach_time.h>

static uint64_t s_begin = 0;

static uint64_t s_end  = 0;



double MachTimeToSecs(uint64_t time)
{
    mach_timebase_info_data_t timebase;
    mach_timebase_info(&timebase);
    return (double)time * (double)timebase.numer /  (double)timebase.denom / 1e6;
}
void writeFileLog(char* szSubject ,char * szFormat , ...)
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"DCTime.log"];// 注意不是NSData!
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    NSString *strLogMessage;
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if(NO == [defaultManager fileExistsAtPath:logFilePath])
    {
        NSString *strTest = @"begian log\r\n";
        NSData *aData=[strTest dataUsingEncoding: NSUTF8StringEncoding];
        [defaultManager createFileAtPath:logFilePath contents:aData attributes:nil];
    }
    
    
    if(NULL != szFormat)
    {
        NSFileHandle *outFile;
        NSData *buffer;
        outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        if(outFile == nil)
        {
            NSLog(@"Open of file for writing failed");
        }
        
        [outFile seekToEndOfFile];
        char szBuffer[4096] = {0};
        char szMsg[4096] = {0};
        
        
        if(0 == s_begin )
        {
            s_begin =mach_absolute_time();
        }
        s_end =mach_absolute_time();
        
       // double spendtime = MachTimeToSecs(s_end - s_begin);
        if(NULL != szSubject)
        {
            sprintf(szMsg,"%s ",szSubject);
        }
        
    
        va_list pArgs;
        va_start(pArgs, szFormat);
        vsprintf(szBuffer, szFormat, pArgs);
        va_end(pArgs);
        
        strcat(szBuffer, "\r\n");
        strcat(szMsg,szBuffer);
        
        
        //找到并定位到outFile的末尾位置(在此后追加文件)
        strLogMessage = [NSString stringWithUTF8String:szMsg];
        strLogMessage =[strLogMessage stringByAppendingString:@"\r\n"];
        buffer = [strLogMessage dataUsingEncoding:NSUTF8StringEncoding];
        [outFile writeData:buffer];
        //关闭读写文件
        [outFile closeFile];
        s_begin = s_end;
    }
}