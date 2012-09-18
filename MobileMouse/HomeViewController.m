//
//  HomeViewController.m
//  MobileMouse
//
//  Created by Jianjun Yu on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "HomeViewController.h"
#import "PPTAssistantViewController.h"
#import "WirelessMouseViewController.h"
#import "RemoteToolViewController.h"
#import "KeyboardViewController.h"
#import "RemoteDesktopViewController.h"
#import "TestViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    
    self.navigationItem.title = NSLocalizedString(@"主页", nil);
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

- (IBAction)homeButtonPressed:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case 0:
        {
            PPTAssistantViewController *controller = [[PPTAssistantViewController alloc] initWithNibName:@"PPTAssistantViewController" bundle:nil];
            
            
            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            break;
        }
            
        case 1:
        {
            WirelessMouseViewController *controller = [[WirelessMouseViewController alloc] initWithNibName:@"WirelessMouseViewController" bundle:nil];
            
            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            
            break;
        }
        case 2:
            
        {
            KeyboardViewController *controller = [[KeyboardViewController alloc] initWithNibName:@"KeyboardViewController" bundle:nil];
            
            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            
            break;
        }
            
        case 3:
        {
            RemoteDesktopViewController *controller = [[RemoteDesktopViewController alloc] initWithNibName:@"RemoteDesktopViewController" bundle:nil];
            
            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            
            break;
            
        }
            
        case 5:
        {
            RemoteToolViewController *controller = [[RemoteToolViewController alloc] initWithNibName:@"RemoteToolViewController" bundle:nil];
            
            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            
            break;
        }
            
        case 6:
        {
            TestViewController *controller = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
            
            [self.navigationController pushViewController:controller animated:YES];
            
            [controller release];
            
            break;
        }
            
        default:
            break;
    }
    
   
}
@end
