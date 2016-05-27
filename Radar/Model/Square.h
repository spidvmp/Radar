//
//  Square.h
//  Radar
//
//  Created by Vicente de Miguel on 27/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//


@import UIKit;

@interface Square : NSObject

@property (strong, nonatomic) UIColor *color;
@property BOOL isVisible;

-(id) initWithColor:(UIColor*) aColor;


@end
