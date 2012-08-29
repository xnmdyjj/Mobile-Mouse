//
//  PPTAssistantViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    KeyTypeLeft,
    KeyTypeRight,
    KeyTypeUp,
    KeyTypeDown,
    KeyTypePlay,
    KeyTypeESC,
    KeyTypeClose,
    KeyTypeOpen
}KeyType;

@interface PPTAssistantViewController : UIViewController

@property (nonatomic, assign) KeyType keyType;

@end
