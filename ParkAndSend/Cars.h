//
//  Cars.h
//  ParkAndSend
//
//  Created by Stephanie on 11/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Cars : NSManagedObject

@property (nonatomic, retain) NSString * numbers;
@property (nonatomic, retain) NSDate * created;

@end
