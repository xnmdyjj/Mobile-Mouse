//
//  WindowsTouchView.h
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WindowsTouchViewDelegate <NSObject>

-(void)touchesMovedWithDeltaX:(float)deltaX withDeltaY:(float)deltaY;

@end

@interface WindowsTouchView : UIView

@property (nonatomic,assign) id<WindowsTouchViewDelegate> delegate;

@end
