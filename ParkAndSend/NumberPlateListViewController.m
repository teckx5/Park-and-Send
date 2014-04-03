//
//  NumberPlateListViewController.m
//  ParkAndSend
//
//  Created by Stephanie on 04/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import "NumberPlateListViewController.h"
#import "AppDelegate.h"
#import "Cars.h"
#import "AddNumberPlateListItemViewController.h"

#import "LocalyticsSession.h"

@interface NumberPlateListViewController ()

@end

@implementation NumberPlateListViewController


/*
 // Core Data Items
 */
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


@synthesize plateNumbers = _plateNumbers;





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Set Color of Toolbar
    // self.navigationController.toolbar.tintColor = [UIColor colorWithRed:40/255.0f green:42/255.0f blue:57/255.0f alpha:1.0f];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self setPlateNumbers:[[NSMutableArray alloc] initWithCapacity:100]];
    
    UIImage *defaultBG = [UIImage imageNamed:@"BackgroundGray.png"];
    UIImageView *defaultBGView = [[UIImageView alloc] initWithImage:defaultBG];
    self.tableView.backgroundView = defaultBGView;
    
    [self.tableView setSeparatorColor:[UIColor darkGrayColor]];
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    // New Grab Data From CoreData Store and populate PlateNumbers Array
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
    
    //Grab the Data
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *cars = [NSEntityDescription entityForName:@"Cars" inManagedObjectContext:_managedObjectContext];
    
    [request setEntity:cars];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (mutableFetchResults == nil) {
        // Handle Error ?
    }
    
    //Populate stored data into the actuall array.
    
    [self setPlateNumbers:mutableFetchResults];
    
    NSLog(@"There are a %u in the car array", [self.plateNumbers count]);
    [self.tableView reloadData];
    
    // Show Toolbar
    // [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setToolbarHidden:YES animated:YES];
}


-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[LocalyticsSession shared] tagScreen:@"Vehicle List Screen"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"AddPlateNumberSegue"]) {
        
        UINavigationController *navCon = segue.destinationViewController;
        
        AddNumberPlateListItemViewController *addNumberPlateListItemViewController = [navCon.viewControllers objectAtIndex:0];
        
        addNumberPlateListItemViewController.numberPlateListViewController = self;
    }
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica Nueue Light" size:28];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.plateNumbers count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PlateNumberCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Cars *currentNumber = (Cars *)[self.plateNumbers objectAtIndex:indexPath.row];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [currentNumber numbers];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.plateNumbers objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
    
        [self.plateNumbers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [[LocalyticsSession shared] tagEvent:@"Vehicle Deleted"];
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Cars *movedPlateNumber = [self.plateNumbers objectAtIndex:fromIndexPath.row];
    [self.plateNumbers removeObjectAtIndex:fromIndexPath.row];
    [self.plateNumbers insertObject:movedPlateNumber atIndex:toIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
 */


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}






@end
