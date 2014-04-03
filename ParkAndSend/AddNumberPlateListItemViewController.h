//
//  AddNumberPlateListItemViewController.h
//  ParkAndSend
//
//  Created by Stephanie on 04/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumberPlateListViewController;

@class ViewController;

@interface AddNumberPlateListItemViewController : UITableViewController


/*
 // Core Data Items
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



- (IBAction)cancelButtonPressed:(id)sender;

- (IBAction)doneButtonPressed:(id)sender;


@property (nonatomic, strong) IBOutlet UITextField * plateNumberField;

@property (nonatomic, strong) NumberPlateListViewController *numberPlateListViewController;


@property (nonatomic,strong) ViewController * viewController;

@end
