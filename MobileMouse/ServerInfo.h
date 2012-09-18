//
//  ServerInfo.h
//  MobileMouse
//
//  Created by Jianjun Yu on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDAsyncSocket;

typedef enum {
    
    ServerTypeWindows,
    ServerTypeMac
}ServerType;

@interface ServerInfo : NSObject


@property (nonatomic,assign) ServerType serverType;

@property (nonatomic, assign) CGFloat serverScreenWidth;
@property (nonatomic, assign) CGFloat serverScreenHeight;

@property (nonatomic, retain) GCDAsyncSocket *asyncSocket;

@property (nonatomic, retain) NSString *serverIPAddress;

+ (id)sharedManager;

@end
