//
//  KeyboardViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 9/2/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "KeyboardViewController.h"
#import "ServerInfo.h"
#import "GCDAsyncSocket.h"
#import "Constants.h"
@interface KeyboardViewController ()

@end

@implementation KeyboardViewController
@synthesize textField;

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
    
    [self.textField becomeFirstResponder];
    
    ServerInfo *sharedInstance = [ServerInfo sharedManager];
    
    [sharedInstance.asyncSocket setDelegate:self];
    
    asyncSocket = sharedInstance.asyncSocket;
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [textField release];
    [super dealloc];
}
- (IBAction)functionButtonPressed:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    NSString *string = [NSString stringWithFormat:@"F%d", button.tag];
    
    NSLog(@"string = %@", string);
}

- (IBAction)directionKeyPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSString *string;
    
    switch (button.tag) {
        case DirectionKeyTypeUp:
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_UP];
            break;
        case DirectionKeyTypeDown:
             string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_DOWN];
            break;
        case DirectionKeyTypeLeft:
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_PRE];
            break;
            
        case DirectionKeyTypeRight:
            string = [NSString stringWithFormat:@"%@%@", COMMAND_TAG, STRING_COMMAND_PPT_NEX];
            break;
        default:
            break;
    }
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [asyncSocket writeData:data withTimeout:NO_TIME_OUT tag:TAG_WRITE_KEYDOWN_MESSAGE];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *sendString = [NSString stringWithFormat:@"keyup:%@|", string];
    
    NSLog(@"sendString = %@", sendString);
    
    [asyncSocket writeData:[sendString dataUsingEncoding:NSUTF8StringEncoding] withTimeout:NO_TIME_OUT tag:TAG_WRITE_KEYDOWN_MESSAGE];
    
    return NO;
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    
    if (tag == TAG_WRITE_KEYDOWN_MESSAGE) {
        
        NSLog(@"TAG_WRITE_KEYDOWN_MESSAGE send");
    }
}

@end
