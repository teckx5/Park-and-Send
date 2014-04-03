//
//  History.h
//  ParkAndSend
//
//  Created by Stephanie on 05/08/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface History : NSManagedObject

@property (nonatomic, retain) NSString * selectedZone;
@property (nonatomic, retain) NSString * selectedMins;
@property (nonatomic, retain) NSString * selectedCar;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * selectedDetails;

@end
