//
//  RemoteDesktopViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 9/10/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "RemoteDesktopViewController.h"
#import "Constants.h"
#import "ShowAlert.h"
#import "ServerInfo.h"

#define IMAGE_RESPONSE_TERMINATOR @"19871104"
#define HIDE_BAR_TIME_INTERVAL 4.0
#define HIDE_BAR_OBJECT_STRING @"Hide Bar"


@interface RemoteDesktopViewController ()

@end

@implementation RemoteDesktopViewController
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    ServerInfo *sharedInstance = [ServerInfo sharedManager];
    
    desktopAsyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
    NSError *error = nil;
    
    if (![desktopAsyncSocket connectToHost:sharedInstance.serverIPAddress onPort:SERVER_DESKTOP_PORT error:&error])
	{
		NSLog(@"Unable to connect to due to invalid configuration: %@", [error description]);
        
        [self showAlertMessage:[error description]];
        
	}
	else
	{
		NSLog(@"Connecting to \"%@\" on port %d...", sharedInstance.serverIPAddress, SERVER_DESKTOP_PORT);
	}
    
    [sharedInstance.asyncSocket setDelegate:self];
    
    mouseAsyncSocket = sharedInstance.asyncSocket;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;

    self.screenSize = CGSizeMake(screenWidth, screenHeight);
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    [self.imageView addGestureRecognizer:panGestureRecognizer];
    
    [panGestureRecognizer release];
    
    
    UITapGestureRecognizer *oneFingerOneTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction:)];
    
    oneFingerOneTapGestureRecognizer.numberOfTouchesRequired = 1;
    oneFingerOneTapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self.imageView addGestureRecognizer:oneFingerOneTapGestureRecognizer];
    
    [oneFingerOneTapGestureRecognizer release];
    
    
    UITapGestureRecognizer *oneFingerTwoTapsGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction:)];
    
    oneFingerTwoTapsGestureRecognizer.numberOfTouchesRequired = 1;
    oneFingerTwoTapsGestureRecognizer.numberOfTapsRequired = 2;
    
    [self.imageView addGestureRecognizer:oneFingerTwoTapsGestureRecognizer];
    
    [oneFingerTwoTapsGestureRecognizer release];
    
    
    UITapGestureRecognizer *twoFingerOneTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedAction:)];
    
    twoFingerOneTapGestureRecognizer.numberOfTouchesRequired = 2;
    twoFingerOneTapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self.imageView addGestureRecognizer:twoFingerOneTapGestureRecognizer];
    
    [twoFingerOneTapGestureRecognizer release];
    
    UITapGestureRecognizer *twoFingerTwoTapsGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingerTwoTapsAction:)];
    
    twoFingerTwoTapsGestureRecognizer.numberOfTouchesRequired = 2;
    twoFingerTwoTapsGestureRecognizer.numberOfTapsRequired = 2;
    
    [self.imageView addGestureRecognizer:twoFingerTwoTapsGestureRecognizer];
    
    [twoFingerTwoTapsGestureRecognizer release];
}

-(void)twoFingerTwoTapsAction:(UITapGestureRecognizer *)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideBar) object:nil];
    
    [self showBar];
    
    [self performSelector:@selector(hideBar) withObject:nil afterDelay:HIDE_BAR_TIME_INTERVAL];
}

-(void)tappedAction:(UITapGestureRecognizer *)sender {
    
    CGPoint point = [sender locationInView:self.imageView];
    
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
        
        [mouseAsyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_TAP_MESSAGE];
    }
}


-(void)panAction:(UIPanGestureRecognizer *)sender {
    
    CGPoint curPoint = [sender locationInView:self.imageView];
    
    NSLog(@"point(%f, %f)", curPoint.x , curPoint.y);
    
    CGFloat desktopMapPointX = curPoint.x * self.desktopScale;
  
    CGFloat desktopMapPointY = curPoint.y * self.desktopScale;
    
    NSUInteger desktopMapPointX_intValue = (NSUInteger)desktopMapPointX/1.0;
    NSUInteger desktopMapPointY_intValue = (NSUInteger)desktopMapPointY/1.0;

    NSString *string = [NSString stringWithFormat:@"moveMouse:%d:%d|",desktopMapPointX_intValue, desktopMapPointY_intValue];
    
    [mouseAsyncSocket writeData:[string dataUsingEncoding:NSUTF8StringEncoding] withTimeout:NO_TIME_OUT tag:TAG_WRITE_MOVE_MOUSE_MESSAGE];
}

- (void)layoutRemoteDeskpViewWithOrientation:(UIInterfaceOrientation)orientation
{
    ServerInfo *sharedInstance = [ServerInfo sharedManager];
    
    if (UIInterfaceOrientationIsPortrait(orientation)) {
        
        CGFloat imageViewWidth = self.screenSize.width;
        
        CGFloat imageViewHeight = imageViewWidth * sharedInstance.serverScreenHeight / sharedInstance.serverScreenWidth;
        
        self.desktopScale = sharedInstance.serverScreenWidth/imageViewWidth;
        
        CGRect frame = self.imageView.frame;
        
        frame.size = CGSizeMake(imageViewWidth, imageViewHeight);
        
        
        [self.imageView setFrame:frame];
        
        [self.imageView setCenter:self.view.center];
        
        
        NSLog(@"imageViewWidth1 = %f", imageViewWidth);
        NSLog(@"imageViewHeight1 = %f", imageViewHeight);
        
        
    } else {
        
        CGFloat imageViewHeight = self.screenSize.width;
        
        CGFloat imageViewWidth = imageViewHeight * sharedInstance.serverScreenWidth / sharedInstance.serverScreenHeight;
        
        if (imageViewWidth > self.screenSize.height) {
            
            imageViewWidth = self.screenSize.height;
            imageViewHeight = imageViewWidth * sharedInstance.serverScreenHeight /  sharedInstance.serverScreenWidth;
        }
        
        self.desktopScale = sharedInstance.serverScreenHeight / imageViewHeight;
        
        CGRect frame = self.imageView.frame;
        
        frame.size = CGSizeMake(imageViewWidth, imageViewHeight);
        
        [self.imageView setFrame:frame];
        
        [self.imageView setCenter:self.view.center];
        
        NSLog(@"imageViewWidth2 = %f", imageViewWidth);
        NSLog(@"imageViewHeight2 = %f", imageViewHeight);
    }
}


-(void)hideBar {
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)showBar {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleBlackTranslucent];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    self.navigationController.navigationBar.translucent = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleDefault];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(hideBar) withObject:nil afterDelay:HIDE_BAR_TIME_INTERVAL];
    
    [self layoutRemoteDeskpViewWithOrientation:self.interfaceOrientation];
}

- (void)viewDidUnload
{
    [self setImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 //   return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {

    
    [self layoutRemoteDeskpViewWithOrientation:toInterfaceOrientation];
    
}


- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    
    if (sock == desktopAsyncSocket) {
        NSLog(@"socket:didConnectToHost:%@ port:%hu", host, port);
        
        NSLog(@"Cool, I'm connected! That was easy.");
        
        NSString *string = @"your_phone_dimen(320,480)";
        
        [desktopAsyncSocket writeData:[string dataUsingEncoding:NSUTF8StringEncoding] withTimeout:NO_TIME_OUT tag:TAG_WRITE_PHONE_DIMEN];
    }
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
    if (sock == mouseAsyncSocket) {
        if (tag == TAG_WRITE_MOVE_MOUSE_MESSAGE) {
            
            NSLog(@"TAG_WRITE_MOVE_MOUSE_MESSAGE success !");
        }
        
        if (tag == TAG_WRITE_TAP_MESSAGE) {
            
            NSLog(@"TAG_WRITE_TAP_MESSAGE success!");
        }
    }
    
    if (sock == desktopAsyncSocket) {
        if (tag == TAG_WRITE_PHONE_DIMEN) {
            
            NSLog(@"TAG_WRITE_PHONE_DIMEN");
            
            NSData *responseTerminatorData = [IMAGE_RESPONSE_TERMINATOR dataUsingEncoding:NSASCIIStringEncoding];
            
            [desktopAsyncSocket readDataToData:responseTerminatorData withTimeout:NO_TIME_OUT tag:TAG_READ_IMAGE_SIZE];
            
        }
    }
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
    
    if (sender == desktopAsyncSocket) {
        if (tag == TAG_READ_IMAGE_SIZE)
        {
            
            NSLog(@"length = %d", [data length]);
            
            UIImage *image = [UIImage imageWithData:data];
            
            self.imageView.image = image;
            
            NSData *responseTerminatorData = [IMAGE_RESPONSE_TERMINATOR dataUsingEncoding:NSASCIIStringEncoding];
            
            [desktopAsyncSocket readDataToData:responseTerminatorData withTimeout:NO_TIME_OUT tag:TAG_READ_IMAGE_SIZE];
            
        }
    }
}

-(void)dealloc {
    [desktopAsyncSocket disconnect];
    desktopAsyncSocket.delegate = nil;
    [desktopAsyncSocket release];
    [imageView release];
    [super dealloc];
}

@end
