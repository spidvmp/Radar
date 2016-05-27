//
//  ViewController.m
//  Radar
//
//  Created by Vicente de Miguel on 26/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

#import "ViewController.h"
#import "Squares.h"
#import "Square.h"

@interface ViewController()

@property (strong, nonatomic) Squares *items;
@property int tapCounter;

+(NSString *) cellId;

@end

@implementation ViewController

#pragma mark - Class Methods
+(NSString *) cellId { return @"cellId"; }

-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    if ( self = [super initWithCollectionViewLayout:layout]) {
        _items = [[Squares alloc]init];
        _tapCounter = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"Intentos: %d",_tapCounter];
    
    [self registerCell];
    
    //starts with 2x2
    [self.items startWithSize:2];
    
    
}

#pragma mark - CollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Pulsan la celda %@", indexPath);
    
    
    
    //increase tapCounter
    self.tapCounter++;
    self.title = [NSString stringWithFormat:@"Intentos: %d",_tapCounter];
    
}

#pragma mark - CollectionView DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[ViewController cellId] forIndexPath:indexPath];
    
    //get data from model
    Square *s = [self.items objectFromRow:indexPath.row];
    
    if ( s.isVisible )
        cell.backgroundColor = s.color;
    else
        cell.backgroundColor = [UIColor blackColor];
    
    return cell;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items countOfSquares];
}

#pragma mark - utils
-(void) registerCell {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[ViewController cellId]];
}

#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
