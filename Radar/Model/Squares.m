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
    
    for (int i = 0; i < 300; i++){

            UIColor *c = [UIColor colorWithHue:[self randomFloat] saturation:1.0 brightness:[self randomFloat] alpha:[self randomFloat]];
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

-(void)completed:(NSArray *)indexes {
    //change values to change
    for (NSIndexPath *ip in indexes) {
        Square *s = [self.squares objectAtIndex:ip.row];
        s.isCompleted = TRUE;
        [self.squares replaceObjectAtIndex:ip.row withObject:s];
    }
}

-(void)faceDown:(NSArray *) indexes {
    //change values to put face down
    for (NSIndexPath *ip in indexes) {
        Square *s = [self.squares objectAtIndex:ip.row];
        s.isVisible = FALSE;
        [self.squares replaceObjectAtIndex:ip.row withObject:s];
    }
}

-(void) startWithSize:(NSInteger) size {
    //restart the array with new size of squares
    [self.squares removeAllObjects];
    self.squares = [self createArrayWithSize:size];
    
}

-(NSMutableArray *) createArrayWithSize:(NSInteger) size {
    //size is always a par value
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //insert (size x size )/2, and insert 2 values with same color for each iteration
    NSInteger insert = ( size * size ) / 2;
    int ident = 0;
    for ( int i=0; i< insert; i++ ){
        //create de square
        Square *s = [[Square alloc]initWithColor:[self.colors objectAtIndex:i] andIdentify:ident];
        [arr addObject:s];
        [arr addObject:s];
        
        //increase identify
        ident++;
        
    }
    
    //generaterandom order
    for(int i=0; i<arr.count; i++){
        int rnd = (arc4random() % arr.count);
        //swap i position and rnd position
        Square *s = [arr objectAtIndex:i];
        [arr replaceObjectAtIndex:i withObject:[arr objectAtIndex:rnd]];
        [arr replaceObjectAtIndex:rnd withObject:s];
        
    }
    
    return arr;
}


-(float) randomFloat{
    return (arc4random() % 255) / 255.0f;
}


@end
