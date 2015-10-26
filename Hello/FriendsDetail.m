//
//  FriendsDetail.m
//  Hello
//
//  Created by 111 on 15-7-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "FriendsDetail.h"
#import "FMDB.h"

#define DATABASE_PATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingString:@"/Friends.db"]

@implementation FriendsDetail

@synthesize FriendID, FriendName, FriendLocation, FriendDescription ,FriendImageName;


+(BOOL)CheckTableCreate:(FMDatabase *)db
{
    BOOL blret = NO;
    
    NSString *strsql = @"CREATE TABLE IF NOT EXISTS 'friend'('FriendID' VARCHAR PRIMARY KEY  NOT NULL  UNIQUE, 'FriendName' VARCHAR, 'FriendLocation' VARCHAR, 'FriendDescription' VARCHAR, 'FriendImageName' VARCHAR)";
    
    blret = [db executeUpdate:strsql];
    
    
    return blret;
}

+(BOOL)SaveNewFriends:(FriendsDetail *)Friends
{
    BOOL blret = YES;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    
    if(![db open])
    {
        NSLog(@"db open error !");
        return NO;
    }
    
    [FriendsDetail CheckTableCreate:db];
    
    NSString *strInsert = @"INSERT INTO 'friend' ('FriendID', 'FriendName', 'FriendLocation', 'FriendDescription' , 'FriendImageName') VALUES (?, ?, ?, ?, ?)";
    
    blret = [db executeUpdate:strInsert, Friends.FriendID, Friends.FriendName, Friends.FriendLocation, Friends.FriendDescription, Friends.FriendImageName];
    
    [db close];
    
    
    return blret;
}

+(BOOL)DeleteFriends:(NSString *)FriendID
{
    BOOL blret = NO;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    
    if(![db open])
    {
        NSLog(@"db open error !");
        return NO;
    }
    
    [FriendsDetail CheckTableCreate:db];

    
    NSString *strDelete = [NSString stringWithFormat:@"DELETE FROM friend where FriendID = '%@'", FriendID];
    
    blret = [db executeUpdate:strDelete];
    
    [db close];
    
    return blret;
}

+(BOOL)UpdateFriends:(FriendsDetail *)Friends
{
    BOOL blret = NO;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    
    if(![db open])
    {
        NSLog(@"db open error !");
        return NO;
    }
    
    [FriendsDetail CheckTableCreate:db];

    NSString *strUpdate = [NSString stringWithFormat:@"Update friend set FriendName = '%@', FriendLocation = '%@', FriendDescription = '%@', FriendImageName = '%@' where FriendID = '%@'", Friends.FriendName, Friends.FriendLocation, Friends.description, Friends.FriendImageName, Friends.FriendID];
    
    blret = [db executeUpdate:strUpdate];
    
    [db close];
    
    return blret;
}

+(BOOL)CheckUserExist:(NSString *)FriendID
{
    BOOL blret = NO;
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    
    if(![db open])
    {
        NSLog(@"db open error !");
        return NO;
    }
    
    [FriendsDetail CheckTableCreate:db];
    
    NSString *strCheck = [NSString stringWithFormat:@"SELECT * FROM friend WHERE FriendID = '%@'", FriendID];
    
    FMResultSet *result = [db executeQuery:strCheck];
    
    while ([result next]) {
        int count = [result intForColumnIndex:0];
        if(count != 0)
        {
            [result close];
            [db close];
            return YES;
        }
        else
        {
            [result close];
            [db close];
            return NO;
        }
    }
    
    
    [db close];
    return YES;
}

+(NSMutableArray *)FetchAllFriends
{
    NSMutableArray *resultArry = [[NSMutableArray alloc] init];
    
    FMDatabase *db = [FMDatabase databaseWithPath:DATABASE_PATH];
    
    if(![db open])
    {
        NSLog(@"open database failed...");
        return resultArry;
    }
    
    FMResultSet *result = [db executeQuery:@"SELECT * FROM friend"];
    
    while ([result next]) {
        
        FriendsDetail *friend = [[FriendsDetail alloc] init];
        
        friend.FriendID = [result stringForColumn:@"FriendID"];
        friend.FriendName = [result stringForColumn:@"FriendName"];
        friend.FriendLocation = [result stringForColumn:@"FriendLocation"];
        friend.FriendDescription = [result stringForColumn:@"FriendDescription"];
        friend.FriendImageName = [result stringForColumn:@"FriendImageName"];
        
        [resultArry addObject:friend];
    }
    
    
    [result close];
    
    [db close];
    return resultArry;
}

-(NSDictionary *)ToDictionary
{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:FriendID, @"FriendID", FriendName, @"FriendName", FriendLocation,@"FriendLocation", FriendDescription, @"FriendDescription",FriendImageName, @"FriendImageName",nil];
    
    
    return dic;
}

+(FriendsDetail *)FriendsFromDictionary:(NSDictionary *)dic
{
    FriendsDetail *friend = [[FriendsDetail alloc] init];
    
    [friend setFriendID:[dic objectForKey:@"FriendID"]];
    [friend setFriendName:[dic objectForKey:@"FriendName"]];
    [friend setFriendLocation:[dic objectForKey:@"FriendLocation"]];
    [friend setFriendDescription:[dic objectForKey:@"FriendDescription"]];
    [friend setFriendImageName:[dic objectForKey:@"FriendImageName"]];
    
    return friend;
}

@end
