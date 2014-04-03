//
//  PlateNumbers+Customisation.m
//  ParkAndSend
//
//  Created by Stephanie on 09/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import "PlateNumbers+Customisation.h"
#import "PlateNumbers.h"

@implementation PlateNumbers (Customisation)

-(NSArray *) sortedPlateNumbers {

    
    return [self.sortedPlateNumbers sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [[ (PlateNumbers *) obj1 created] compare:[(PlateNumbers *) obj2 created]];
    }];
    
}


@end
