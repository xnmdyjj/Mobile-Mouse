//
//  WindowsTouchView.m
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "WindowsTouchView.h"

@implementation WindowsTouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *aTouch = [touches anyObject];
    
    CGPoint loc = [aTouch locationInView:self];
    CGPoint prevloc = [aTouch previousLocationInView:self];
    
    float deltaX = loc.x - prevloc.x;
    float deltaY = loc.y - prevloc.y;
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchesMovedWithDeltaX:withDeltaY:)]) {
        
        [self.delegate touchesMovedWithDeltaX:deltaX withDeltaY:deltaY];
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}



@end
