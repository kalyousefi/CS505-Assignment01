//
//  CircleView.m
//  Homework01
//
//  Created by Khaled Alyousefi on 9/11/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGPoint screenCenterPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);

    [self drawCircle:100 forCenterPoint:screenCenterPoint];
    [self drawBresenhamCircle:150 forCenterPoint:screenCenterPoint];
}




// Draw a Circle --------My Implementation
- (void) drawCircle:(CGFloat)radius forCenterPoint: (CGPoint) centerPoint
{        
    for (int i=0; i<=360; i++) {
        int x = centerPoint.x + radius * cos(i);
        int y = centerPoint.y + radius * sin(i);
        [self drawDotForX:x Y:y  withCorlor:1]; // draw the Circle
        NSLog(@"%i : point (%i,%i)",i,x,y);
    }
    
}

// Draw Bresenham's Circle
- (void) drawBresenhamCircle:(CGFloat)radius forCenterPoint: (CGPoint) centerPoint
{
    
     //I used the algorthim from this source: answers.com/Q/Bresenham_circle_drawing_algorithms:
     
    int xc = centerPoint.x;
    int yc = centerPoint.y;
    int x = 0;
    int y = radius;
    int d = 3-2*radius;
    while (x<y) {
        x++;
        if (d<0) {
            d = d + ( 4 * x ) + 6;
        } else {
            y--;
            d = d + (( x - y ) * 4 ) + 10;
        }
        [self drawDotForX:xc+x Y:yc+y withCorlor:2];
        [self drawDotForX:xc-x Y:yc+y withCorlor:2];
        [self drawDotForX:xc+x Y:yc-y withCorlor:2];
        [self drawDotForX:xc-x Y:yc-y withCorlor:2];
        [self drawDotForX:xc+y Y:yc+x withCorlor:2];
        [self drawDotForX:xc-y Y:yc+x withCorlor:2];
        [self drawDotForX:xc+y Y:yc-x withCorlor:2];
        [self drawDotForX:xc-y Y:yc-x withCorlor:2];
        
    }
}

- (void) drawDotForX:(int)x Y:(int)y withCorlor:(int) BlueOrRed
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (BlueOrRed == 1) {
        CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0); // blue color
    } else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); // red color
    }
    CGContextFillRect(context, CGRectMake(x, y, 1.0, 1.0));
}
@end
