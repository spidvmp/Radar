//
//  Squares.h
//  Radar
//
//  Created by Vicente de Miguel on 27/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

@import UIKit;

@interface Squares : NSObject

@property(strong, nonatomic) NSMutableArray *squares;
@property(strong, nonatomic) NSArray *colors;

-(NSUInteger) countOfSquares;
-(void) startWithSize:(int) size;


@end
