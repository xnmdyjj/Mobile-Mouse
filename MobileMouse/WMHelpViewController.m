//
//  WMHelpViewController.m
//  MobileMouse
//
//  Created by Yu Jianjun on 10/1/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import "WMHelpViewController.h"

#define CELL_HEIGHT 44.0

@interface WMHelpViewController ()

@end

@implementation WMHelpViewController

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
    
    self.navigationItem.title = NSLocalizedString(@"Help", nil);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 4;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont systemFontOfSize:17.0];
        
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15.0];
        
        cell.detailTextLabel.textColor = [UIColor blueColor];
        
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = NSLocalizedString(@"Q:How to move mouse pointer?", nil);
            
            cell.detailTextLabel.text = NSLocalizedString(@"A:Use one finger to drag", nil);
            
            break;
            
        case 1:
            cell.textLabel.text = NSLocalizedString(@"Q:How to click?", nil);
            
            cell.detailTextLabel.text = NSLocalizedString(@"A:Use one finger to tap", nil);

            break;
        case 2:
            cell.textLabel.text = NSLocalizedString(@"Q:How to double click?", nil);
            
            cell.detailTextLabel.text = NSLocalizedString(@"A:Use one finger to tap twice", nil);
            break;
        case 3:
            cell.textLabel.text = NSLocalizedString(@"Q:How to right click?", nil);
            
            cell.detailTextLabel.text = NSLocalizedString(@"A:Use two fingers to tap", nil);
            break;
        default:
            break;
    }

    // Configure the cell...
    
    return cell;
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CELL_HEIGHT;
}

@end
