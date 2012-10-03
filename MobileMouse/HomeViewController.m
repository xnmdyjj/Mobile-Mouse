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
    
    self.navigationItem.title = NSLocalizedString(@"Mobile Mouse", nil);
    
    self.dataArray = [NSArray arrayWithObjects:NSLocalizedString(@"PPT Assistant",nil), NSLocalizedString(@"Wireless Mouse",nil), NSLocalizedString(@"Remote Command", nil), NSLocalizedString(@"Remote Desktop", nil), nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.section];
    
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            PPTAssistantViewController *controller;
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                controller = [[PPTAssistantViewController alloc] initWithNibName:@"PPTAssistantViewController" bundle:nil];
            }else {
                
                controller = [[PPTAssistantViewController alloc] initWithNibName:@"PPTAssistantView_iPad" bundle:nil];
            }
 
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
            RemoteToolViewController *controller;
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                controller = [[RemoteToolViewController alloc] initWithNibName:@"RemoteToolViewController" bundle:nil];
                
            }else {
                controller = [[RemoteToolViewController alloc] initWithNibName:@"RemoteToolView_iPad" bundle:nil];
                
            }
            
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
        
        default:
            break;
    }
}

-(void)dealloc {
    
    [_dataArray release];
    [super dealloc];
}

@end
