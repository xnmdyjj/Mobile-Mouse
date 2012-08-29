//
//  ConnectViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCDAsyncSocket;

@interface ConnectViewController : UIViewController {
    
    GCDAsyncSocket *asyncSocket;
}

@property (retain, nonatomic) IBOutlet UITextField *ipAddressTextField;
- (IBAction)connectAction:(id)sender;
- (IBAction)autoConnectAction:(id)sender;
@end
