//
//  CarPlateNumber.h
//  ParkAndSend
//
//  Created by Stephanie on 04/07/2013.
//  Copyright (c) 2013 Jonathan Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarPlateNumber : NSObject

@property (nonatomic, strong) NSString *plateNumberItem;

-(id)initWithName:(NSString *)plateNumberItem;

@end
