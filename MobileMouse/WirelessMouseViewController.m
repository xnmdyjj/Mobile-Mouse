//
//  WirelessMouseViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "WirelessMouseViewController.h"
#import "ServerInfo.h"
#import "Constants.h"
#import "GCDAsyncSocket.h"

@interface WirelessMouseViewController ()

@end

@implementation WirelessMouseViewController
@synthesize touchpadView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    touchpadView.delegate = self;
    
    UITapGestureRecognizer *oneFingerOneTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction:)];
    
    oneFingerOneTapGestureRecognizer.numberOfTouchesRequired = 1;
    oneFingerOneTapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self.touchpadView addGestureRecognizer:oneFingerOneTapGestureRecognizer];
    
    [oneFingerOneTapGestureRecognizer release];
    
    
    UITapGestureRecognizer *oneFingerTwoTapsGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction:)];
    
    oneFingerTwoTapsGestureRecognizer.numberOfTouchesRequired = 1;
    oneFingerTwoTapsGestureRecognizer.numberOfTapsRequired = 2;
    
    [self.touchpadView addGestureRecognizer:oneFingerTwoTapsGestureRecognizer];
    
    [oneFingerTwoTapsGestureRecognizer release];
    
    
    UITapGestureRecognizer *twoFingerOneTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction:)];
    
    twoFingerOneTapGestureRecognizer.numberOfTouchesRequired = 2;
    twoFingerOneTapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self.touchpadView addGestureRecognizer:twoFingerOneTapGestureRecognizer];
    
    [twoFingerOneTapGestureRecognizer release];
    
//    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//    
//    [self.touchpadView addGestureRecognizer:panGestureRecognizer];
//    
//    [panGestureRecognizer release];
    
    ServerInfo *sharedInstance = [ServerInfo sharedManager];
    
    [sharedInstance.asyncSocket setDelegate:self];
    
    asyncSocket = sharedInstance.asyncSocket;
    
}

-(void)tappedAction:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:self.touchpadView];
    
    int pointX = (int)point.x/1.0;
    int pointY = (int)point.y/1.0;

    NSString *string;
    
    if (sender.state == UIGestureRecognizerStateEnded) {
                
        if (sender.numberOfTouchesRequired  == 1 && sender.numberOfTapsRequired == 1) {
            NSLog(@"One finger one tapped");
            
            string = [NSString stringWithFormat:@"click:%d:%d|", pointX, pointY];
            
        }
        
        if (sender.numberOfTouchesRequired == 1 && sender.numberOfTapsRequired == 2 ) {
            NSLog(@"one finger two tapped");
            
            string = @"#doubleClick";
            
        }
        
        if (sender.numberOfTouchesRequired == 2 && sender.numberOfTapsRequired == 1) {
            NSLog(@"two finger one tapped");
            
            string = [NSString stringWithFormat:@"rightClick:%d,%d|", pointX, pointY];
        }
        
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_TAP_MESSAGE];
    }
}



-(void)touchesMovedWithDeltaX:(float)deltaX withDeltaY:(float)deltaY {
    
    int deltaXIntValue = (int)(deltaX / 1.0);
    
    NSLog(@"deltaX = %d",deltaXIntValue);
    
    int deltaYIntValue= (int)(deltaY / 1.0);
    
    NSLog(@"deltaY = %d", deltaYIntValue);
    
    NSString *string = [NSString stringWithFormat:@"moveAdd:%d:%d|", deltaXIntValue, deltaYIntValue];
    
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_MOVEADD_MESSAGE];
}


- (void)viewDidUnload
{
    [self setTouchpadView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
    if (tag == TAG_WRITE_MOVEADD_MESSAGE) {
        
        NSLog(@"TAG_WRITE_MOUSEADD_MESSAGE send");
    }
    
    if (tag == TAG_WRITE_TAP_MESSAGE) {
        
        NSLog(@"TAG_WRITE_TAP_MESSAGE send");
    }
}


- (void)dealloc {
    [touchpadView release];
    [super dealloc];
}
@end
