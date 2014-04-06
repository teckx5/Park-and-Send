//
//  NumberPlateListViewController.h
//  ParkAndSend
//
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NumberPlateListViewController : UITableViewController

/*
 // Core Data Items
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



@property (nonatomic, strong) NSMutableArray *plateNumbers;



@end
