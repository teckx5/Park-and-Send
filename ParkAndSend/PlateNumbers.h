//
//  PlateNumbers.h
//  ParkAndSend
//
//  Created by Stephanie on 09/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PlateNumbers : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSDate * created;

@end
