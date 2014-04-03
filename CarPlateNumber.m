//
//  CarPlateNumber.m
//  ParkAndSend
//
//  Created by Stephanie on 04/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import "CarPlateNumber.h"

@implementation CarPlateNumber

@synthesize plateNumberItem = _plateNumberItem;

-(id)initWithName:(NSString *)plateNumberItem {
    
    self = [super init];
    
    if (self) {
        
        self.plateNumberItem = plateNumberItem;
        
    }
    return self;
    
}

@end
