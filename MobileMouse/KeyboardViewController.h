//
//  KeyboardViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 9/2/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    DirectionKeyTypeUp,
    DirectionKeyTypeDown,
    DirectionKeyTypeLeft,
    DirectionKeyTypeRight

}DirectionKeyType;

@class GCDAsyncSocket;

@interface KeyboardViewController : UIViewController {
    
    GCDAsyncSocket *asyncSocket;
    
    DirectionKeyType directionKeyType;
}

@property (retain, nonatomic) IBOutlet UITextField *textField;

- (IBAction)functionButtonPressed:(id)sender;
- (IBAction)directionKeyPressed:(id)sender;

@end
