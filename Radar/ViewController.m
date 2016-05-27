//
//  ViewController.m
//  Radar
//
//  Created by Vicente de Miguel on 26/5/16.
//  Copyright © 2016 Vicente de Miguel. All rights reserved.
//

#import "ViewController.h"
#import "Squares.h"

@interface ViewController ()

@property (strong, nonatomic) Squares *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.items = [[Squares alloc] init];
    [self.items startWithSize:2];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
