//
//  LineView.h
//  Homework01
//
//  Created by Khaled Alyousefi on 9/10/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineView : UIView
@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

- (id)initWithFrame:(CGRect)frame start:(CGPoint)s end:(CGPoint)e;
- (void)drawRect:(CGRect)rect;
@end
