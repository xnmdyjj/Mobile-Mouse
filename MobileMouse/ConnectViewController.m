//
//  ConnectViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "ConnectViewController.h"
#import "GCDAsyncSocket.h"
#import "Constants.h"
#import "ShowAlert.h"
#import "HomeViewController.h"
#import "ServerInfo.h"

@interface ConnectViewController ()

@end

@implementation ConnectViewController
@synthesize ipAddressTextField;

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
    
    self.ipAddressTextField.text = @"192.168.1.107";
    
    asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

- (void)viewDidUnload
{
    [self setIpAddressTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [ipAddressTextField release];
    [asyncSocket release];
    [super dealloc];
}

- (IBAction)connectAction:(id)sender {
    NSError *error = nil;
	NSString *host = self.ipAddressTextField.text;
    
    if (![asyncSocket connectToHost:host onPort:SERVER_PORT error:&error])
	{
		NSLog(@"Unable to connect to due to invalid configuration: %@", [error description]);
        
        [self showAlertMessage:[error description]];
        
	}
	else
	{
		NSLog(@"Connecting to \"%@\" on port %d...", host, SERVER_PORT);
	}
    
}


- (IBAction)autoConnectAction:(id)sender {
    
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"socket:didConnectToHost:%@ port:%hu", host, port);
    
    NSLog(@"Cool, I'm connected! That was easy.");
    
    [asyncSocket readDataWithTimeout:NO_TIME_OUT tag:TAG_SERVER_SCREEN_INFO];

}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == TAG_SERVER_SCREEN_INFO)
    {
        
        NSString *screenInfo = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"screenInfo = %@", screenInfo);
        
        [screenInfo release];
        
        
        NSString *deviceName =  [[UIDevice currentDevice] name];
        
        NSData *data = [deviceName dataUsingEncoding:NSUTF8StringEncoding];
        
        [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_MOBILE_INFO];
        
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{

    if (tag == TAG_WRITE_MOBILE_INFO) {
        
        NSLog(@"Mobile name has been sent");
        
        ServerInfo *sharedInstance = [ServerInfo sharedManager];
        
        sharedInstance.asyncSocket = asyncSocket;
        
        HomeViewController *controller = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
        
        
        [self.navigationController pushViewController:controller animated:YES];
        
        [controller release];
    }
}

@end
