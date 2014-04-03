//
//  AppDelegate.h
//  ParkAndSend
//
//  Created by Stephanie on 27/06/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

//Does this need to be here for Localytics to work?
//@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//Does this need to be here for Localytics to work?
//@property (nonatomic, strong) ViewController *viewController;

@property (strong, nonatomic) UIWindow *window;


/*
// Core Data Items
*/
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
 // END Core Data Items



@end
