//
//  Squares.h
//  Radar
//
//  Created by Vicente de Miguel on 27/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

@import UIKit;
@class Square;

@interface Squares : NSObject

@property(strong, nonatomic) NSMutableArray *squares;
@property(strong, nonatomic) NSArray *colors;

-(NSUInteger) countOfSquares;
-(void) startWithSize:(NSInteger) size;
-(void) completed:(NSArray *) indexes;
-(void)faceDown:(NSArray *) indexes;
-(Square *) objectFromRow:(NSUInteger) row;
-(BOOL) checkIfIsFinished;


@end
