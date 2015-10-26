//
//  GloabDef.h
//  Hello
//
//  Created by 111 on 15-7-1.
//  Copyright (c) 2015年 mit. All rights reserved.
//

#ifndef Hello_GloabDef_h
#define Hello_GloabDef_h

// 是否为本地地址测试
#define LOCAL_TEST 1

#if LOCAL_TEST
#define XMPP_DOMAIN         @"dy-pc"
#define XMPP_HOST_NAME      @"192.168.200.108"
#else
#define XMPP_DOMAIN         @"121.41.129.248"
#define XMPP_HOST_NAME      @"121.41.129.248"
#endif//LOCAL_TEST

// XMPP
#define XMPP_RESOURCE       @"iPhoneXMPP"
#define XMPP_DEFAULT_GROUP_NAME @"friends"

#define XMPP_USER_ID        @"XMPP_USER_ID"
#define XMPP_PASSWORD       @"XMPP_PASSWORD"

#define XMPP_LOGIN_STATUS   @"XMPP_LOGIN_STATUS"
#define XMPP_LOGIN_KEY      @"XMPP_LOGIN_KEY"

#endif
