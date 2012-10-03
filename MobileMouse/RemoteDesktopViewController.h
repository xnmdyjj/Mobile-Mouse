//
//  RemoteDesktopViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 9/10/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCDAsyncSocket.h"

@interface RemoteDesktopViewController : UIViewController {
    
    GCDAsyncSocket *desktopAsyncSocket;
    
    GCDAsyncSocket *mouseAsyncSocket;
    
    UIStatusBarStyle _previousStatusBarStyle;
}


@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, assign) CGSize screenSize;

@property (nonatomic, assign) CGFloat desktopScale;

@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end
