//
//  LineView.m
//  Homework01
//
//  Created by Khaled Alyousefi on 9/10/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//

#import "LineView.h"

@implementation LineView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame start:(CGPoint)s end:(CGPoint)e
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.startPoint = s;
        self.endPoint = e;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self drawBresenhamCircleLine:CGPointMake(10.0, 10.0) To:CGPointMake(200.0, 200.0)];
    
    [self drawLine:CGPointMake(10.0, 40.0) To:CGPointMake(200.0, 230.0) t:0.1];
    [self drawLine:CGPointMake(10.0, 70.0) To:CGPointMake(200.0, 260.0) t:0.01];
    [self drawLine:CGPointMake(10.0, 100.0) To:CGPointMake(200.0, 290.0) t:0.001];
    [self drawLine:CGPointMake(10.0, 130.0) To:CGPointMake(200.0, 315.0) t:0.0001];
}

// Draw a line ----- My Implementation
- (void) drawLine:(CGPoint)startPoint To:(CGPoint)endPoint t:(double) t
{
    int dx = abs(endPoint.x - startPoint.x);
    int dy = abs(endPoint.y - startPoint.y);
    int x,y;
    for (double i=0.0; i<=1; i+=t) {
        x = startPoint.x + dx * i;
        y = startPoint.y + dy * i;
        [self drawDotForX:x Y:y withCorlor:1]; // draw the line
    }
    
}

// Draw Bresenham's Line
- (void) drawBresenhamCircleLine:(CGPoint)startPoint To:(CGPoint)endPoint
{
    int x0 = startPoint.x;
    int y0 = startPoint.y;
    int x1 = endPoint.x;
    int y1 = endPoint.y;
    
    BOOL steep = abs(y1 - y0) > abs(x1 - x0);
    if (steep) {
        int tmp = x0;
        x0 = y0;
        y0 = tmp;
        tmp = x1;
        x1 = y1;
        y1 = tmp;
    }
    if (x0 > x1) {
        int tmp = x0;
        x0 = x1;
        x1 = tmp;
        tmp = y0;
        y0 = y1;
        y1 = tmp;
    }
    int deltax = x1 - x0;
    int deltay = abs(y1 - y0);
    int error = deltax / 2;
    int ystep = -1;
    int y = y0;
    if (y0 < y1)
        ystep = 1;
    for (int x = x0; x <= x1; x++) {
        if (steep)
        [self drawDotForX:y Y:x withCorlor:2];
        else
        [self drawDotForX:x Y:y withCorlor:2];
        
        error -= deltay;
        if (error < 0) {
            y += ystep;
            error += deltax;
        }
    }
    
}

- (void) drawDot:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0); // blue color
    CGContextFillRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height));
}

- (void) drawDotForX:(int)x Y:(int)y withCorlor:(int) BlueOrRed
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (BlueOrRed == 1) {
        CGContextSetRGBFillColor(context, 0.0, 0.0, 1.0, 1.0); // Blue color
    } else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); // red color
    }
    CGContextFillRect(context, CGRectMake(x, y, 1.0, 1.0));
}

/*
 Best Bresenham Line implementation
 function line(x0, y0, x1, y1){
 var dx = Math.abs(x1-x0);
 var dy = Math.abs(y1-y0);
 var sx = (x0 < x1) ? 1 : -1;
 var sy = (y0 < y1) ? 1 : -1;
 var err = dx-dy;
 
 while(true){
 setPixel(x0,y0);  // Do what you need to for this
 
 if ((x0==x1) && (y0==y1)) break;
 var e2 = 2*err;
 if (e2 >-dy){ err -= dy; x0  += sx; }
 if (e2 < dx){ err += dx; y0  += sy; }
 }
 }
 */

@end
