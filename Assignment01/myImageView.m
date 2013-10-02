//
//  myImageView.m
//  Homework01
//
//  Created by Khaled Alyousefi on 9/11/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//

#import "myImageView.h"

@implementation myImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGPoint screenCenterPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextFillEllipseInRect(context, CGRectMake(screenCenterPoint.x-2, screenCenterPoint.y-2, 5.0, 5.0));
    
    for (int r = 10; r < screenCenterPoint.y; r += 25)
    {
        [self drawCircle:r forCenterPoint:screenCenterPoint];
    }
   /*
    [self drawLine:CGPointMake(0.0, 0.0) To:CGPointMake(300.0, 385.0) t:0.005];
    [self drawLine:CGPointMake(20.0, 0.0) To:CGPointMake(320.0, 0.0) t:0.001];
    [self drawLine:CGPointMake(0.0, 205.0) To:CGPointMake(320.0, 205.0) t:0.005];
    [self drawLine:CGPointMake(160.0, 0.0) To:CGPointMake(160.0, 460.0) t:0.005];
    
     
     [self drawBresenhamCircleLine:CGPointMake(0.0, 0.0) To:CGPointMake(300.0, 385.0)];
     [self drawBresenhamCircleLine:CGPointMake(320.0, 0.0) To:CGPointMake(0.0, 410.0)];
     [self drawBresenhamCircleLine:CGPointMake(0.0, 205.0) To:CGPointMake(320.0, 205.0)];
     [self drawBresenhamCircleLine:CGPointMake(160.0, 0) To:CGPointMake(160.0, 460.0)];
     */
    
    int height = self.frame.size.height ;
    int width = self.frame.size.width;
    int ox = width / 2;
    int oy = height / 2;
    
    for (int i = 0; i < 270; i += 5) {
        int x = (int) (200 * cos(i * M_PI / 180.0));
        int y = (int) (200 * sin(i * M_PI / 180.0));
        //drawLine(ox, oy, ox + x, oy + y, myImage, 0xffff00);
        [self drawLine:CGPointMake(ox, oy) To:CGPointMake(ox+x,oy+y) t:0.01];
    }
    /*

    
    // My implementation
    int[][] myImage = new int[height][width];


    */
 
}


// Draw a line ----- My Implementation
- (void) drawLine:(CGPoint)startPoint To:(CGPoint)endPoint t:(double) t
{
    int dx = abs(endPoint.x - startPoint.x);
    int dy = abs(endPoint.y - startPoint.y);
    int x,y;
    int height = self.frame.size.height ;
    int width = self.frame.size.width;
    for (double i=0.0; i<=1; i+=t) {
        x = [[NSNumber numberWithDouble:(startPoint.x + dx * i)] intValue];
        y = [[NSNumber numberWithDouble:(startPoint.y + dy * i)] intValue];
        if ((x >= 0) && (x < width) && (y >= 0) && (y < height)) {
            [self drawDotForX:x Y:y withCorlor:2]; // draw the line
        }
    }    
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

- (void) drawDotForX:(int)x Y:(int)y withCorlor:(int) YellowOrRed
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (YellowOrRed == 1) {
        CGContextSetRGBFillColor(context, 1.0, 1.0, 0.0, 1.0); // yellow color
    } else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); // red color
    }
    CGContextFillRect(context, CGRectMake(x, y, 1.0, 1.0));
}

@end
