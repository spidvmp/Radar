//
//  Squares.m
//  Radar
//
//  Created by Vicente de Miguel on 27/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

#import "Squares.h"
#import "Square.h"

@implementation Squares


-(id)init{
    if ( self = [super init]){
        _squares = [[NSMutableArray alloc]init];
        _colors = [NSArray arrayWithArray:[self createColors]];
        
    }
    return self;
    
}

-(NSArray*) createColors{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (int red = 0.0f; red< 250.0f; red+=50){
        UIColor *c = [UIColor colorWithRed:red/255.0f green:100 blue:100 alpha:1.0];
        [arr addObject:c];
    }
        
    return arr;
}

-(Square *) objectFromRow:(NSUInteger) row {
    return [self.squares objectAtIndex:row];
}

-(NSUInteger) countOfSquares {
    return self.squares.count;
}

-(void) startWithSize:(int) size {
    //restart the array with new size of squares
    [self.squares removeAllObjects];
    self.squares = [self createArrayWithSize:size];
    
}

-(NSMutableArray *) createArrayWithSize:(int) size {
    //size is always a par value
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //insert (size x size )/2, and insert 2 values with same color for each iteration
    int insert = ( size * size ) / 2;
    for ( int i=0; i< insert; i++ ){
        //create de square
        Square *s = [[Square alloc]initWithColor:[self.colors objectAtIndex:i]];
        [arr addObject:s];
        [arr addObject:s];
        
    }
    
    
    return arr;
}

@end
