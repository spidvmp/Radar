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

@end

@implementation ViewController

-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    if ( self = [super initWithCollectionViewLayout:layout]) {
        _items = [[Squares alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.items startWithSize:2];
    
    
}

#pragma mark - CollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Pulsan la celda %@", indexPath);
    
    
}

#pragma mark - CollectionView DataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //get data from model
    Square *s = [self.items objectFromRow:indexPath.row];
    
    return cell;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.items countOfSquares];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
