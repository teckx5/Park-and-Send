//
//  AddNumberPlateListItemViewController.m
//  ParkAndSend
//
//  Created by Stephanie on 04/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import "AddNumberPlateListItemViewController.h"
#import "AppDelegate.h"
#import "Cars.h"
#import "NumberPlateListViewController.h"
#import "ViewController.h"

#import "LocalyticsSession.h"

@interface AddNumberPlateListItemViewController ()

@end

@implementation AddNumberPlateListItemViewController


/*
 // Core Data Items
 */
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


@synthesize plateNumberField;
@synthesize numberPlateListViewController = _numberPlateListViewController;

@synthesize viewController = _viewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    [plateNumberField becomeFirstResponder];
    
    

    
  
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[LocalyticsSession shared] tagScreen:@"Add Vehicle Screen"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    cell.backgroundColor = [UIColor clearColor];
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    
    // create the parent view that will hold header Label
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
	
	// create the button object
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor darkTextColor];
	headerLabel.highlightedTextColor = [UIColor clearColor];
    // headerLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    // headerLabel.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
	//headerLabel.font = [UIFont boldSystemFontOfSize:18];
    headerLabel.font = [UIFont fontWithName:@"Helvetica Nueue Light" size:18];
	headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 44.0);
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
	// If you want to align the header text as centered
	// headerLabel.frame = CGRectMake(150.0, 0.0, 300.0, 44.0);
    
	headerLabel.text = @"Add Car License Plate Number";// i.e. array element
	[customView addSubview:headerLabel];
    
	return customView;
    
}




#pragma mark IBActions Buttons


- (void)cancelButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)doneButtonPressed:(id)sender {
    
        Cars *cars = [NSEntityDescription insertNewObjectForEntityForName:@"Cars" inManagedObjectContext:_managedObjectContext];
        
        [cars setNumbers:plateNumberField.text];
        cars.created = [NSDate date];
        
        NSError *error =nil;
        if (![_managedObjectContext save:&error]) {
            //Handle The Error ?
        }
        NSLog(@"Plate Number Added %@", plateNumberField.text);
    
    
   
    
    
    //Localytics
    [[LocalyticsSession shared] tagEvent:@"Vehicle Added"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_numberPlateListViewController.tableView reloadData];
}


@end
