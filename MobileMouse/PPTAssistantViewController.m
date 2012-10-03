//
//  PPTAssistantViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "PPTAssistantViewController.h"
#import "GCDAsyncSocket.h"
#import "ServerInfo.h"
#import "Constants.h"

#define PPT_PLAY_DES_STRING @"Play"
#define PPT_EXIT_DES_STRING @"Exit"

@interface PPTAssistantViewController ()

@end

@implementation PPTAssistantViewController
@synthesize playOrExitButton;

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
    
    self.navigationItem.title = NSLocalizedString(@"PPT Assistant", nil);
    
    ServerInfo *sharedInstance = [ServerInfo sharedManager];
    
    [sharedInstance.asyncSocket setDelegate:self];
    
    asyncSocket = sharedInstance.asyncSocket;
    
}

- (void)viewDidUnload
{
    [self setPlayOrExitButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)pptAssistantButtonPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    NSString *string;
    NSData *data;
    
    switch (button.tag) {
        case KeyTypeLeft:
        {
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_PRE];
            
            data = [string dataUsingEncoding:NSUTF8StringEncoding];

            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:KeyTypeLeft];
            
            break;
        }
        case KeyTypeRight:
        {
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_NEX];
            
            data = [string dataUsingEncoding:NSUTF8StringEncoding];
            
            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:KeyTypeRight];
            
            break;
        }
            
        case KeyTypeUp:
        {
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_UP];
            
            data = [string dataUsingEncoding:NSUTF8StringEncoding];
            
            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:KeyTypeUp];
            
            break;
        }
            
        case KeyTypeDown:
        {
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_DOWN];
            
            data = [string dataUsingEncoding:NSUTF8StringEncoding];
            
            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:KeyTypeDown];
            
            break;
        }
            
        case KeyTypeF5orESC:
        {
            if (pptIsPlaying) {
                
                
                 string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_ESC];
 
                
            }else {
                
                string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_F5];
                
            }
            
            data = [string dataUsingEncoding:NSUTF8StringEncoding];
            
            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:KeyTypeF5orESC];
            
            break;
        }
        case KeyTypeClose:
        {
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_CLOSE];
            
            data = [string dataUsingEncoding:NSUTF8StringEncoding];
            
            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:KeyTypeClose];
            
            break;
        }
        case KeyTypeOpen:
        {
            
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_ENTER];
            
            data = [string dataUsingEncoding:NSUTF8StringEncoding];
            
            [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:KeyTypeOpen];
            
            break;
        }
        
        default:
            break;
    }
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
    if (tag == KeyTypeF5orESC) {
        
        pptIsPlaying = !pptIsPlaying;
        
        if (pptIsPlaying) {
            //[self.playOrExitButton setTitle:PPT_EXIT_DES_STRING forState:UIControlStateNormal];
            
            [self.playOrExitButton setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
            

        }else {
            //[self.playOrExitButton setTitle:PPT_PLAY_DES_STRING forState:UIControlStateNormal];
            
            [self.playOrExitButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];

        }
    }
}

- (void)dealloc {
    [playOrExitButton release];
    [super dealloc];
}
@end
