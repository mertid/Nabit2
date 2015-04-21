//
//  Annotation.m
//  NabiT
//
//  Created by Merritt Tidwell on 10/14/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

-(void)setCoordinate:(CLLocationCoordinate2D)newCoordinate

{
    _coordinate = newCoordinate;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title= title;
    
}

@end
