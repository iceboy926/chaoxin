//
//  FriendsDetail.h
//  Hello
//
//  Created by 111 on 15-7-27.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsDetail : NSObject

@property(nonatomic, retain) NSString *FriendID;
@property(nonatomic, retain) NSString *FriendName;
@property(nonatomic, retain) NSString *FriendLocation;
@property(nonatomic, retain) NSString *FriendDescription;
@property(nonatomic, retain) NSString *FriendImageName;


+(BOOL)SaveNewFriends:(FriendsDetail *)Friends;
+(BOOL)DeleteFriends:(NSString *)FriendID;
+(BOOL)UpdateFriends:(FriendsDetail *)Friends;
+(BOOL)CheckUserExist:(NSString *)FriendID;

+(NSMutableArray *)FetchAllFriends;
-(NSDictionary *)ToDictionary;
+(FriendsDetail *)FriendsFromDictionary:(NSDictionary *)dic;

@end
