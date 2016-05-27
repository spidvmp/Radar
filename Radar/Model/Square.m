//
//  Square.m
//  Radar
//
//  Created by Vicente de Miguel on 27/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

#import "Square.h"

@implementation Square


-(id)initWithColor:(UIColor *)aColor {
    if ( self = [super init]){
        _isVisible = FALSE;
        _color = aColor;
    }
    return self;
    
}

@end