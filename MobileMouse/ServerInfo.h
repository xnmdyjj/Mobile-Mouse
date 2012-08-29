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

@property (nonatomic, retain) GCDAsyncSocket *asyncSocket;

+ (id)sharedManager;

@end
