//
//  TestViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 9/16/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "TestViewController.h"
#import "ServerInfo.h"

@interface TestViewController ()

@end

@implementation TestViewController
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
    
    self.navigationItem.title = NSLocalizedString(@"Remote Desktop", nil);
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
//    NSLog(@"screenWidth = %f", screenWidth);
//    NSLog(@"screenHeight = %f", screenHeight);
    
//    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
//    NSLog(@"screenScale = %f", screenScale);
    
    self.screenSize = CGSizeMake(screenWidth , screenHeight);
    
 //   NSLog(@"(%f, %f)", self.screenSize.width, self.screenSize.height);
    
   
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    [self.imageView addGestureRecognizer:tapGestureRecognizer];
    
    [tapGestureRecognizer release];
    
    
    self.imageView.image = [UIImage imageNamed:@"test.jpeg"];

 //   CGRect frame = self.imageView.frame;
    
//    NSLog(@"frame.size.width = %f", frame.size.width);
//    NSLog(@"frame.size.height = %f", frame.size.height);
    
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    [self.imageView addGestureRecognizer:panGestureRecognizer];
    
    [panGestureRecognizer release];
}


-(void)panAction:(UIPanGestureRecognizer *)sender {
    
    
    CGPoint curPoint = [sender locationInView:self.imageView];
    
    NSLog(@"point(%f, %f)", curPoint.x , curPoint.y);
    
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



-(void)imageViewTapped:(UITapGestureRecognizer *)sender {
    
    NSLog(@"imageViewTapped");
    
 //   [self showBar];
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
    
   // [self performSelector:@selector(hideBar) withObject:nil afterDelay:5.0];
    
    [self layoutRemoteDeskpViewWithOrientation:self.interfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//      
//    } else {
//       
//    }
    
    [self layoutRemoteDeskpViewWithOrientation:toInterfaceOrientation];
    
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    
    NSLog(@"didRotateFromInterfaceOrientation");
    
//    CGRect screenRect = [[UIScreen mainScreen] bounds];
//    CGFloat screenWidth = screenRect.size.width;
//    CGFloat screenHeight = screenRect.size.height;
//    
//    
//    NSLog(@"screenWidth = %f", screenWidth);
//    NSLog(@"screenHeight = %f", screenHeight);
//    
//    CGFloat screenScale = [[UIScreen mainScreen] scale];
//    
//    NSLog(@"screenScale = %f", screenScale);
//    
//    self.screenSize = CGSizeMake(screenWidth * screenScale, screenHeight * screenScale);
//    
//    NSLog(@"(%f, %f)", self.screenSize.width, self.screenSize.height);
//    
//    
//    CGRect frame = self.imageView.frame;
//    
//    NSLog(@"frame.size.width = %f", frame.size.width);
//    NSLog(@"frame.size.height = %f", frame.size.height);
    
    
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
   // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    
//    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft || interfaceOrientation==UIInterfaceOrientationLandscapeRight)
//        return YES;
//    
//    return NO;
    
    return YES;
}



- (void)dealloc {
    [imageView release];
    [super dealloc];
}
@end
