//
//  RemoteToolViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 9/2/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "RemoteToolViewController.h"
#import "GCDAsyncSocket.h"
#import "ServerInfo.h"
#import "Constants.h"



@interface RemoteToolViewController ()

@end

@implementation RemoteToolViewController

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
    
    self.navigationItem.title = NSLocalizedString(@"Remote Tool", nil);
    
    ServerInfo *sharedInstance = [ServerInfo sharedManager];
    
    [sharedInstance.asyncSocket setDelegate:self];
    
    asyncSocket = sharedInstance.asyncSocket;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)shutDownAction:(id)sender {
    NSString *string = [NSString stringWithFormat:@"%@shutdown -s -t 30", DOS_COMMANT_TAG];

    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_DOSORSHELL_MESSAGE];
    
}

- (IBAction)lockScreenAction:(id)sender {
    
    NSString *string = [NSString stringWithFormat:@"%@%@",COMMAND_TAG, STRING_COMMAND_LOCK_SCREEN];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_LOCKSCREEN_MESSAGE];
}

- (IBAction)cancelShutDownAction:(id)sender {
    
    NSString *string = [NSString stringWithFormat:@"%@shutdown -a", DOS_COMMANT_TAG];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_DOSORSHELL_MESSAGE];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSString *text = textField.text;
    
    if (text != nil && [text length] > 0) {
        
        NSString *trimmedText = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if ([trimmedText length] > 0) {
            
            [textField resignFirstResponder];
            
            NSString *string = [NSString stringWithFormat:@"%@%@", DOS_COMMANT_TAG, trimmedText];
            
            NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
            
            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_DOSORSHELL_MESSAGE];
            
            return YES;
            
        }
    }
    return NO;
}

@end
