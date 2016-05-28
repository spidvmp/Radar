//
//  Square.m
//  Radar
//
//  Created by Vicente de Miguel on 27/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

#import "Square.h"

@implementation Square


-(id)initWithColor:(UIColor *)aColor andIdentify:(int)ident{
    if ( self = [super init]){
        _isVisible = FALSE;
        _isCompleted = FALSE;
        _color = aColor;
        _identify = ident;
    }
    return self;
    
}

@end
