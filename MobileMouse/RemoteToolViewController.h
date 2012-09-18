//
//  RemoteToolViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 9/2/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCDAsyncSocket;


@interface RemoteToolViewController : UIViewController <UITextFieldDelegate>{
    GCDAsyncSocket *asyncSocket;
    
}
- (IBAction)shutDownAction:(id)sender;
- (IBAction)lockScreenAction:(id)sender;
- (IBAction)cancelShutDownAction:(id)sender;

@end
