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
@property (strong, nonatomic) NSIndexPath *lastIndexPathCell;
@property NSInteger size;
@property (strong, nonnull) UIPickerView *picker;
@property BOOL showingPicker;



+(NSString *) cellId;

@end

@implementation ViewController

#pragma mark - Class Methods
+(NSString *) cellId { return @"cellId"; }

-(id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    if ( self = [super initWithCollectionViewLayout:layout]) {
        _items = [[Squares alloc]init];
        _lastIndexPathCell = nil;
        _tapCounter = 0;
        _size = 2;
        _picker = [[UIPickerView alloc]init];
        _showingPicker = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.title = [NSString stringWithFormat:@"Attemps: %d",self.tapCounter];
    
    [self registerCell];
    
    //starts with 4x4
    [self.items startWithSize: self.size];
    
    //reset button
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset:)];
    self.navigationItem.leftBarButtonItem = resetButton;
    //size button
    UIBarButtonItem *sizeButton = [[UIBarButtonItem alloc] initWithTitle:@"Change Size" style:UIBarButtonItemStylePlain target:self action:@selector(changeSize:)];
    self.navigationItem.rightBarButtonItem = sizeButton;
    
    CGRect fr = self.picker.frame;
    fr.size.width = self.view.frame.size.width;
    fr.origin.y = self.view.frame.size.height - fr.size.height;
    self.picker.frame = fr;
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.backgroundColor = [UIColor grayColor];
    
    
}

#pragma mark - CollectionView Delegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Square *s = [self.items objectFromRow:indexPath.row];
    
    //Controll cells taped
    if ( !s.isCompleted && indexPath != self.lastIndexPathCell){
        //make cell visible
        s.isVisible = true;
        [collectionView reloadItemsAtIndexPaths:(@[indexPath])];
        
        //check if is the first cell of the pair
        if ( self.lastIndexPathCell != nil) {
            Square *last = [self.items objectFromRow:self.lastIndexPathCell.row];
            if ( last.identify == s.identify) {
                //completed
                [self.items completed:@[indexPath, self.lastIndexPathCell]];
                
            } else {
                //diferents cells
                [self differentCellsInArray:@[self.lastIndexPathCell, indexPath]];
                
            }
            self.lastIndexPathCell = nil;
        } else {
            self.lastIndexPathCell = indexPath;
        }
    
    }
    //increase tapCounter
    self.tapCounter++;
    self.title = [NSString stringWithFormat:@"Attemps: %d", self.tapCounter];
    
    if ( [self.items checkIfIsFinished]) {
        //show congratulations message
        NSString *msg = [NSString stringWithFormat:@"You solved the puzzle in %d attemps", self.tapCounter];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Congratulations" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self reset:nil];
        }];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
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

#pragma mark - UIPickerView DataSource
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 8;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSInteger s = 2 + ( row * 2);
    return [NSString stringWithFormat:@"%ld x %ld", s, s];
}
-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

#pragma mark - PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    //get new size
    self.size = 2 + ( row * 2 );

}

#pragma mark - utils
-(void)differentCellsInArray:(NSArray *) indexes {
    //put them face down
    [self.items faceDown:indexes];
    
    //run this after 1 second
    dispatch_time_t delay = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(delay, dispatch_get_main_queue(), ^(void){
        [self.collectionView reloadItemsAtIndexPaths:indexes];
    });
}

-(void) registerCell {
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[ViewController cellId]];
}

#pragma mark - Actions
-(void) reset:(id) sender {
    //reset the game
    [self.items startWithSize: self.size];
    self.tapCounter = 0;
    self.title = [NSString stringWithFormat:@"Attemps: %d",self.tapCounter];
    [self.collectionView reloadData];
    
}

-(void) changeSize:(id)sender {
    //check if picker exist. If exist, we are changing size
    if ( self.showingPicker) {
        [self.navigationItem.rightBarButtonItem setTitle:@"Change Size"];
        [self.picker removeFromSuperview];
        self.showingPicker = NO;
        
        //reload layout
        [self reset:nil];
        
    } else {
        
        [self.navigationItem.rightBarButtonItem setTitle:@"Change it!"];
        
        [self.view addSubview:self.picker];
        self.showingPicker = YES;
    }
    
}


#pragma mark - Memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
