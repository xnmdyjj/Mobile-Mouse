//
//  PPTAssistantViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCDAsyncSocket;

typedef enum {
    KeyTypeLeft,
    KeyTypeRight,
    KeyTypeUp,
    KeyTypeDown,
    KeyTypeF5orESC,
    KeyTypeClose,
    KeyTypeOpen
}KeyType;

@interface PPTAssistantViewController : UIViewController {
    
    BOOL pptIsPlaying;
    
    GCDAsyncSocket *asyncSocket;
}

@property (nonatomic, assign) KeyType keyType;
@property (retain, nonatomic) IBOutlet UIButton *playOrExitButton;

- (IBAction)pptAssistantButtonPressed:(id)sender;

@end
