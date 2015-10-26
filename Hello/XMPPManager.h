//
//  XMPPManager.h
//  Hello
//
//  Created by 111 on 15-7-1.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "GloabDef.h"

@interface XMPPManager : NSObject

@property (nonatomic, strong, readonly) XMPPStream *xmppStream;
@property (nonatomic, strong, readonly) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong, readonly) XMPPRoster *xmppRoster;
@property (nonatomic, strong, readonly) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong, readonly) XMPPvCardCoreDataStorage *xmppvCardStorage;
@property (nonatomic, strong, readonly) XMPPvCardTempModule *xmppvCardTempModule;
@property (nonatomic, strong, readonly) XMPPvCardAvatarModule *xmppvCardAvatarModule;
@property (nonatomic, strong, readonly) XMPPCapabilities *xmppCapabilities;
@property (nonatomic, strong, readonly) XMPPCapabilitiesCoreDataStorage *xmppCapabilitiesStorage;


@property (nonatomic, strong) XMPPJID *myJID;


+(instancetype)ShareManager;



-(BOOL)Connect;

-(BOOL)ConnectThenLogin;

-(void)DisConnect;

-(void)GetFriendList;

@end
