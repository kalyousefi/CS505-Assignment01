//
//  LineViewController.m
//  Homework01
//
//  Created by Khaled Alyousefi on 9/10/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//

#import "LineViewController.h"
#import "LineView.h"

#define startPoint      CGPointMake(0, 0)
#define endPoint        CGPointMake(305, 405)

@interface LineViewController ()

@end

@implementation LineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    LineView *line = [[LineView alloc] initWithFrame:self.view.bounds start:startPoint end:endPoint];
    [self.view addSubview:line];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <INBresenhamAlgorithmDelegate>

- (void)pointFounded:(CGPoint)point {
    //[self removeTileForCoord:point];
}
@end
