//
//  WirelessMouseViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WindowsTouchView.h"

@class GCDAsyncSocket;

@interface WirelessMouseViewController : UIViewController<WindowsTouchViewDelegate> {
    
    GCDAsyncSocket *asyncSocket;
}

@property (retain, nonatomic) IBOutlet WindowsTouchView *touchpadView;



@end
