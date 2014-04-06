//
//  ViewController.m
//  ParkAndSend
//
//  Created by Stephanie on 27/06/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Cars.h"
#import "NumberPlateListViewController.h"

#import "LocalyticsSession.h"


@interface ViewController ()



@end

@implementation ViewController


/*
 // Core Data Items
 */
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


// Parking Picker
@synthesize parkZonePicker;
@synthesize parkZonesArray, parkTimeArray;
@synthesize parkZonesLabel, parkTimeLabel, parkCarLabel;

//Parking Text Array To Send
@synthesize parkTextToSend;


@synthesize pickerPlateNumbers = _pickerPlateNumbers;
@synthesize chosenPickerNumber = _chosenPickerNumber;



@synthesize sendTextButton;

@synthesize parkingTagSignup;
@synthesize parkingTagSignupButtonButton;
@synthesize addCarButtonFirst;

@synthesize plateNoLabel;
@synthesize yourChoseDeets;
@synthesize zoneLabelDeets;
@synthesize minsLabelDeets;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //  Status Bar Color
    
    // [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    // [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    
    // Set View Background Nav Bar Colour
    // self.view.backgroundColor = [UIColor colorWithRed:40/255.0f green:42/255.0f blue:57/255.0f alpha:1.0f];
    // self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:148/255.0f green:154/255.0f blue:172/255.0f alpha:1.0f];
    
   
    

    
    // Load up Zones NSArrary object
    self.parkZonesArray = [[NSArray alloc] initWithObjects: @"Yellow",@"Red",@"White",@"Green",@"Orange",@"Blue", nil];
    // Load up Time NSArrary object
    self.parkTimeArray = [[NSArray alloc] initWithObjects:@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"55",@"60",@"90",@"100",@"110",@"120", nil];
    // Load up Car Number Plates NSArrary object
    
    self.pickerPlateNumbers = [[NSMutableArray alloc] init];
    [self setPickerPlateNumbers:[[NSMutableArray alloc] initWithCapacity:100]];

    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewWillAppear:(BOOL)animated {
    
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
  

    //request setPropertiesToFetch = [NSArray arrayWithObject:[[cars propertiesByName] objectForKey:@"numbers"]];
    
    request.resultType = NSDictionaryResultType;
    request.propertiesToFetch = [NSArray arrayWithObject:[[cars attributesByName] objectForKey:@"numbers"]];
    request.returnsDistinctResults = YES;
    
    
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    
    if (mutableFetchResults == nil) {
        // Handle Error ?
    }
    
    //Populate stored data into the actuall array.
    
    [self setPickerPlateNumbers:mutableFetchResults];
    NSLog(@"There are a %u in the car array", [self.pickerPlateNumbers count]);
    

    [self.parkZonePicker reloadAllComponents];
    
       
    
    
 //TODO
    
    //STEP 1 Construct Panels
//    MYIntroductionPanel *panel = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage1"] description:@"Park & Send is an assistant app\rfor all Parking Tag customers.\rWe make it even quicker to pay for\rand extend your parking time.\r\rYou simply scroll through the\r zone and time options,\rwe compose your Parking Tag SMS,\ryou just tap send."];
    
    //You may also add in a title for each panel
//    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithimage:[UIImage imageNamed:@"SampleImage2"] title:@"Getting Started!" description:@"Please add the vehicle license plate number registered with your Parking Tag account." ];
    

    
    
    
    
    //Show Hide Buttons Send Text and Add Car
    if ([self.pickerPlateNumbers count] == 0) {
        //Hide UIButton Add Car
        [self.addCarButtonFirst setHidden:FALSE];
        [self.parkingTagSignup setHidden:FALSE];
        [self.parkingTagSignupButtonButton setHidden:FALSE];
       
        //Show All Send As SMS Items
        [self.yourChoseDeets setHidden:TRUE];
        [self.zoneLabelDeets setHidden:TRUE];
        [self.minsLabelDeets setHidden:TRUE];
        [self.plateNoLabel setHidden:TRUE];
        
        [self.sendTextButton setHidden:TRUE];
     
        // Initate Introduction Slides
        
//        [introductionView showInView:self.view];
        
    } else {
        //Show All Send As SMS Items
        [self.addCarButtonFirst setHidden:TRUE];
        [self.parkingTagSignup setHidden:TRUE];
        [self.parkingTagSignupButtonButton setHidden:TRUE];
        
        //Hide All First Launch Items
        [self.sendTextButton setHidden:FALSE];
        
        [self.yourChoseDeets setHidden:FALSE];
        [self.zoneLabelDeets setHidden:FALSE];
        [self.minsLabelDeets setHidden:FALSE];
        [self.plateNoLabel setHidden:FALSE];
        
        
    }
    
    self.parkZonesLabel.text = [NSString stringWithFormat:@"Zone: %@",
                               [self.parkZonesArray objectAtIndex:[parkZonePicker selectedRowInComponent:0]]];
    
    self.parkTimeLabel.text = [NSString stringWithFormat:@"Time: %@ Mins",
                               [self.parkTimeArray objectAtIndex:[parkZonePicker selectedRowInComponent:1]]];
    
    if (![self.pickerPlateNumbers count] == 0) {
        [self.parkCarLabel setHidden:FALSE];
        self.chosenPickerNumber = [NSString stringWithFormat:@"%@", [self.pickerPlateNumbers objectAtIndex:[parkZonePicker selectedRowInComponent:2]]];
       
        NSString *stringWithoutSpaces9 = [self.chosenPickerNumber stringByReplacingOccurrencesOfString:@"{" withString:@""];
        NSString *stringWithoutSpaces8 = [stringWithoutSpaces9 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *stringWithoutSpaces7 = [stringWithoutSpaces8 stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *stringWithoutSpaces6 = [stringWithoutSpaces7 stringByReplacingOccurrencesOfString:@"numbers" withString:@""];
        NSString *stringWithoutSpaces5 = [stringWithoutSpaces6 stringByReplacingOccurrencesOfString:@"=" withString:@""];
        NSString *stringWithoutSpaces4 = [stringWithoutSpaces5 stringByReplacingOccurrencesOfString:@";" withString:@""];
        NSString *stringWithoutSpaces = [stringWithoutSpaces4 stringByReplacingOccurrencesOfString:@"}" withString:@""];

        self.parkCarLabel.text = [NSString stringWithFormat:@"Vehicle: %@", stringWithoutSpaces];

        
    } else {
        [self.parkCarLabel setHidden:TRUE];
    }
    

    
    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [[LocalyticsSession shared] tagScreen:@"Send SMS Screen"];
    

}



#pragma mark - UIPickerView Methods DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    
    if ([self.pickerPlateNumbers count] == 0) {
        return 2;
        
    } else {
        return 3;
        
        
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [parkZonesArray count];
    } else if (component == 1) {
        return [parkTimeArray count];
    } else if (component == 2) {
       
        return [self.pickerPlateNumbers count];
    };

    return 0;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [parkZonesArray objectAtIndex:row];
    } else if (component == 1) {
        return [parkTimeArray objectAtIndex:row];
    } else if (component == 2) {
        return [self.pickerPlateNumbers objectAtIndex:row][@"numbers"];
        
        
    };
    return 0;
   
}

#pragma mark UIPickerView Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0)
    {
        NSString *resultString = [[NSString alloc] initWithFormat: @"Zone: %@", [parkZonesArray objectAtIndex:row]];
        parkZonesLabel.text = resultString;
        [parkZonesLabel setNeedsDisplay];
        
    } else if (component == 1){
        NSString *resultString = [[NSString alloc] initWithFormat: @"Time: %@ Mins", [parkTimeArray objectAtIndex:row]];
        parkTimeLabel.text = resultString;
        [parkTimeLabel setNeedsDisplay];
        
    } else if (component == 2){
        
        
        NSString *resultString = [[NSString alloc] initWithFormat: @"Vehicle: %@", [self.pickerPlateNumbers objectAtIndex:row][@"numbers"]];
        parkCarLabel.text = resultString;
        
        [parkCarLabel setNeedsDisplay];
    }
    
}

    

#pragma mark UIPickerView Component Width Sizes
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    switch(component) {
        case 0: return 90;
        case 1:
            if ([self.pickerPlateNumbers count] == 0) {
                return 192;
            } else {
                return 80;
            };
            
        case 2: return 112;
        default: return 292;
    }
    
    //NOT REACHED
    return 292;
}



- (IBAction)parkingTagSignupButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.parkingtag.ie"]];
}

- (IBAction)sendText:(id)sender {
    

    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *textSheet = [[MFMessageComposeViewController alloc] init];
        textSheet.messageComposeDelegate = self;
        
        [textSheet setRecipients:[NSArray arrayWithObjects:@"53311", nil]];

        
        // Catch Results of Picker and Create as Individual Strings


                                   
                                   
        self.chosenPickerNumber = [NSString stringWithFormat:@"%@", [self.pickerPlateNumbers objectAtIndex:[parkZonePicker selectedRowInComponent:2]]];
        
        
        NSString *stringWithoutSpaces9 = [self.chosenPickerNumber stringByReplacingOccurrencesOfString:@"{" withString:@""];
        NSString *stringWithoutSpaces8 = [stringWithoutSpaces9 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSString *stringWithoutSpaces7 = [stringWithoutSpaces8 stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *stringWithoutSpaces6 = [stringWithoutSpaces7 stringByReplacingOccurrencesOfString:@"numbers" withString:@""];
        NSString *stringWithoutSpaces5 = [stringWithoutSpaces6 stringByReplacingOccurrencesOfString:@"=" withString:@""];
        NSString *stringWithoutSpaces4 = [stringWithoutSpaces5 stringByReplacingOccurrencesOfString:@";" withString:@""];
        NSString *stringWithoutSpaces = [stringWithoutSpaces4 stringByReplacingOccurrencesOfString:@"}" withString:@""];
        

        
        
        NSString *fullRow = [NSString stringWithFormat:@"Park %@ %@ %@",
                             [self.parkZonesArray objectAtIndex:[parkZonePicker selectedRowInComponent:0]],
                             [self.parkTimeArray objectAtIndex:[parkZonePicker selectedRowInComponent:1]],
                             stringWithoutSpaces
                             //[self.pickerPlateNumbers objectAtIndex:[parkZonePicker selectedRowInComponent:2]]
                             ];
        NSLog(@"Full Row = %@", fullRow);
        
        // Start begining of text message as string and append above row objects to it.
    
         
        // Finally Create Message Body
        [textSheet setBody: fullRow];
        
        
        
        [self presentViewController:textSheet animated:YES completion:nil];
       
        [[LocalyticsSession shared] tagEvent:@"SMS Sent"];
        
    } else {
        NSString *result = @"SMS sending is not supported with this device";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        NSLog(@"%@", result);
    }
}



// SMS Message Alert Responses

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    NSString *output = nil;
    
    switch (result) {
        case MessageComposeResultSent:
            output = @"Message Sent Successfully";
            NSLog(@"%@", output);
            break;
            
        case MessageComposeResultCancelled:
            output = @"You Canceled The Message";
            NSLog(@"%@", output);
            break;
            
        case MessageComposeResultFailed:
            output = @"An Error Occured While Sending";
            NSLog(@"%@", output);
            break; 
            
        default:
            break;
    }
 
    UIAlertView *resultView = [[UIAlertView alloc] initWithTitle:@"Result" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [resultView show];
    
    [self dismissViewControllerAnimated:YES completion:nil]; 

}






- (void)viewDidUnload {
    [self setYourChoseDeets:nil];
    [self setZoneLabelDeets:nil];
    [self setMinsLabelDeets:nil];
    [self setParkingTagSignup:nil];
    [super viewDidUnload];
}
@end
