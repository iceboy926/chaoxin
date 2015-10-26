//
//  XMPPManager.m
//  Hello
//
//  Created by 111 on 15-7-1.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#import "XMPPManager.h"

@implementation XMPPManager

+(instancetype)ShareManager
{
    static XMPPManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc ] init];
        // Setup the XMPP stream
        [_sharedManager setupStream];
    });

    
    return _sharedManager;
}



-(void)setupStream
{
    _xmppStream = [[XMPPStream alloc] init];
    
    _xmppReconnect = [[XMPPReconnect alloc] init];
    
    
    _xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
    
    // 不用每次都重新创建数据库，否则会导致未读消息数丢失，good idea
	_xmppRosterStorage.autoRemovePreviousDatabaseFile = NO;
    _xmppRosterStorage.autoRecreateDatabaseFile = NO;
    
	_xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:_xmppRosterStorage];
	_xmppRoster.autoFetchRoster = YES;
	_xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;

    
    _xmppvCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
	_xmppvCardTempModule = [[XMPPvCardTempModule alloc] initWithvCardStorage:_xmppvCardStorage];
	
	_xmppvCardAvatarModule = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_xmppvCardTempModule];
    

    _xmppCapabilitiesStorage = [XMPPCapabilitiesCoreDataStorage sharedInstance];
    _xmppCapabilities = [[XMPPCapabilities alloc] initWithCapabilitiesStorage:_xmppCapabilitiesStorage];
    
    _xmppCapabilities.autoFetchHashedCapabilities = YES;
    _xmppCapabilities.autoFetchNonHashedCapabilities = NO;
    
	// Activate xmpp modules
    
	[_xmppReconnect         activate:_xmppStream];
	[_xmppRoster            activate:_xmppStream];
	[_xmppvCardTempModule   activate:_xmppStream];
	[_xmppvCardAvatarModule activate:_xmppStream];
	[_xmppCapabilities      activate:_xmppStream];
   
    
	// Add ourself as a delegate to anything we may be interested in
    
	[_xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
	[_xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];

    
}

#pragma mark LogIn Action

-(BOOL)Connect
{
    BOOL blret = NO;
    NSError *error = nil;
    
    NSString *UserID = [[NSUserDefaults standardUserDefaults] objectForKey:XMPP_USER_ID];
    
    if(UserID == nil)
    {
        return NO;
    }
    
    XMPPJID *myJid =[XMPPJID jidWithUser:UserID domain:XMPP_DOMAIN resource:nil];
    _xmppStream.myJID = myJid;
    _xmppStream.hostName = XMPP_HOST_NAME;
    _xmppStream.hostPort = 5222;
    
    
    blret = [_xmppStream connectWithTimeout:10 error:&error];
    
    if(error)
    {
        NSLog(@"error log is %@", [error localizedDescription]);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"连接服务器失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        
        [alert show];
        
        return NO;
    }
    
    
    return blret;
    
}

-(BOOL)ConnectThenLogin
{
    
    if([_xmppStream isDisconnected])
    {
        return [self Connect];
    }
    else
    {
        return [self DoLogIn];
    }
}

-(BOOL)DoLogIn
{
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:XMPP_PASSWORD];
    
    if ( password == nil) {
        return NO;
    }
    
    NSError *error = nil;
	if (![_xmppStream authenticateWithPassword:password error:&error])
	{
		NSLog(@"Error authenticating: %@", [[error userInfo] description]);
        return NO;
	}
    
    NSLog(@"DoLogIn authenticateWithPassword");
    
    return YES;
}


-(void)DisConnect
{
    
    [_xmppStream disconnect];
}

- (void)goOnline
{
	XMPPPresence *presence = [XMPPPresence presence]; // type="available" is implicit
    
	[[self xmppStream] sendElement:presence];
}

- (void)goOffline
{
	XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
	
	[[self xmppStream] sendElement:presence];
}

- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"xmppStreamDidConnect ");
    if(![self DoLogIn])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误，请重新输入" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"Unable to connect to server. Check xmppStream.hostName");
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:XMPP_LOGIN_STATUS object:self userInfo: @{XMPP_LOGIN_KEY:[NSNumber numberWithBool:NO]}];
    
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	NSLog(@"xmppStreamDidAuthenticate ");
	
    self.myJID = self.xmppStream.myJID;
    [self goOnline];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:XMPP_LOGIN_STATUS object:self userInfo: @{XMPP_LOGIN_KEY:[NSNumber numberWithBool:YES]}];

}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
	NSLog(@"didNotAuthenticate error%@", [error description]);
    
        [[NSNotificationCenter defaultCenter] postNotificationName:XMPP_LOGIN_STATUS object:self userInfo: @{XMPP_LOGIN_KEY:[NSNumber numberWithBool:NO]}];
}



- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    BOOL blRet = NO;
    
    NSLog(@" did ReceiveIQ");
    
    if ([@"result" isEqualToString:iq.type]) {
        NSXMLElement *query = iq.childElement;
        if ([@"query" isEqualToString:query.name]) {
            NSArray *items = [query children];
            for (NSXMLElement *item in items) {
                NSString *jid = [item attributeStringValueForName:@"jid"];
                XMPPJID *xmppJID = [XMPPJID jidWithString:jid];
                //[self.xmppRoster addObject:xmppJID];
            }
        }
    }
    
    return blRet;
}


- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@" did receiveMessage");
}

-(void)GetFriendList
{
    int value = (arc4random()%65536) + 1;
    
    NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:@"jabber:iq:roster"];
    NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
    XMPPJID *myJID = self.xmppStream.myJID;
    [iq addAttributeWithName:@"from" stringValue:myJID.description];
    [iq addAttributeWithName:@"to" stringValue:myJID.domain];
    [iq addAttributeWithName:@"id" stringValue: [NSString stringWithFormat:@"%d", value]];
    [iq addAttributeWithName:@"type" stringValue:@"get"];
    [iq addChild:query];
    [self.xmppStream sendElement:iq];
}

#pragma mark XMPPRoster

- (void)xmppRoster:(XMPPRoster *)sender didReceiveRosterItem:(NSXMLElement *)item
{
    NSLog(@"did receiveRosterItem");
}



@end
