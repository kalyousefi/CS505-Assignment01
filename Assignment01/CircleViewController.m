//
//  CircleViewController.m
//  Homework01
//
//  Created by Khaled Alyousefi on 9/10/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//

#import "CircleViewController.h"
#import "CircleView.h"

@interface CircleViewController ()

@end

@implementation CircleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    CircleView *circle = [[CircleView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:circle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
