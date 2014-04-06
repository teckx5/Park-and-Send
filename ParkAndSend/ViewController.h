//
//  ViewController.h
//  ParkAndSend
//
//  Created by Stephanie on 27/06/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>



@interface ViewController : UIViewController <MFMessageComposeViewControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, NSFetchedResultsControllerDelegate>{
    UIPickerView *parkZonePicker;
    NSArray *parkZones;
    NSArray *parkTime;
    UILabel *parkZonesLabel;
    UILabel *parkTimeLabel;
    UILabel *parkCarLabel;
    NSMutableArray *pickerPlateNumbers;

}


/*
 // Core Data Items
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



@property (nonatomic, strong) IBOutlet UIPickerView *parkZonePicker;
@property (nonatomic, strong) NSArray *parkZonesArray;
@property (nonatomic, strong) NSArray *parkTimeArray;
@property (nonatomic, retain) IBOutlet UILabel *parkZonesLabel;
@property (nonatomic, retain) IBOutlet UILabel *parkTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *parkCarLabel;

@property (nonatomic, strong) NSString * parkTextToSend;

@property (nonatomic, strong) NSMutableArray *pickerPlateNumbers;

@property (nonatomic, strong) NSString *chosenPickerNumber;

@property (strong, nonatomic) IBOutlet UIButton *sendTextButton;
@property (strong, nonatomic) IBOutlet UIButton *addCarButtonFirst;
@property (strong, nonatomic) IBOutlet UILabel *parkingTagSignup;
@property (strong, nonatomic) IBOutlet UIButton *parkingTagSignupButtonButton;

- (IBAction)parkingTagSignupButton:(id)sender;



- (IBAction)sendText:(id)sender;


@property (strong, nonatomic) IBOutlet UILabel *yourChoseDeets;
@property (strong, nonatomic) IBOutlet UILabel *zoneLabelDeets;
@property (strong, nonatomic) IBOutlet UILabel *minsLabelDeets;

@property (strong, nonatomic) IBOutlet UILabel *plateNoLabel;



@end

