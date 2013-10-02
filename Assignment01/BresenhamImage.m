//
//  BresenhamImage.m
//  Homework01
//
//  Created by Khaled Alyousefi on 9/11/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//

#import "BresenhamImage.h"


@implementation BresenhamImage{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    NSLog(@"%f",self.frame.size.height);
    NSLog(@"%f",self.frame.size.width);
    CGPoint screenCenterPoint = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    for (int r = 10; r < screenCenterPoint.y; r += 25)
    {
        [self drawBresenhamCircle:r forCenterPoint:screenCenterPoint isFill:NO];
    }
    
   // [self drawBresenhamCircle:3 forCenterPoint:screenCenterPoint isFill:YES];
    
    int height = self.frame.size.height ;
    int width = self.frame.size.width;
    int ox = width / 2;
    int oy = height / 2;
    
    for (int i = 0; i < 360; i += 30) {
        int x = (int) (width * cos(i * M_PI / 180.0));
        int y = (int) (height * sin(i * M_PI / 180.0));
        //drawLine(ox, oy, ox + x, oy + y, myImage, 0xffff00);
        [self drawBresenhamLine:CGPointMake(ox, oy) To:CGPointMake(ox+x,oy+y)];
    }
}

// Draw Bresenham's Line
- (void) drawBresenhamLine:(CGPoint)startPoint To:(CGPoint)endPoint
{
    //I used the algorthim from this source: java-gaming.org/index.php?topic=24497
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

// Draw Bresenham's Circle
- (void) drawBresenhamCircle:(CGFloat)radius forCenterPoint: (CGPoint) centerPoint isFill:(BOOL) fill
{
    
    //I used the algorthim from this source: answers.com/Q/Bresenham_circle_drawing_algorithms:
    
    int xc = centerPoint.x;
    int yc = centerPoint.y;
    int x = 0;
    int y = radius;
    int d = 3-2*radius;
    while (x<y) {
        
        if (d<0) {
            d = d + ( 4 * x ) + 6;
        } else {
            y--;
            d = d + (( x - y ) * 4 ) + 10;
        }
        if (fill == NO) {
            [self drawDotForX:xc+x Y:yc+y withCorlor:1];
            [self drawDotForX:xc-x Y:yc+y withCorlor:1];
            [self drawDotForX:xc+x Y:yc-y withCorlor:1];
            [self drawDotForX:xc-x Y:yc-y withCorlor:1];
            [self drawDotForX:xc+y Y:yc+x withCorlor:1];
            [self drawDotForX:xc-y Y:yc+x withCorlor:1];
            [self drawDotForX:xc+y Y:yc-x withCorlor:1];
            [self drawDotForX:xc-y Y:yc-x withCorlor:1];
        }
        
        if (fill == YES) {
        [self FillFrom:CGPointMake(xc+x, yc+y) To:CGPointMake(xc-x, yc+y) withCorlor:1];
        [self FillFrom:CGPointMake(xc+x, yc-y) To:CGPointMake(xc-x, yc-y) withCorlor:1];
        [self FillFrom:CGPointMake(xc+y, yc+x) To:CGPointMake(xc-y, yc+x) withCorlor:1];
        [self FillFrom:CGPointMake(xc+y, yc-x) To:CGPointMake(xc-y, yc-x) withCorlor:1];            
        }
       
        x++;
    }
}

- (void) drawDotForX:(int)x Y:(int)y withCorlor:(int) BlueOrRed
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (BlueOrRed == 1) {
        CGContextSetRGBFillColor(context, 1.0, 1.0, 0.0, 1.0); // yellow color
    } else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); // red color
    }
    CGContextFillRect(context, CGRectMake(x, y, 1.0, 1.0));
}

- (void) FillFrom:(CGPoint)firstPoint To:(CGPoint)lastPoint withCorlor:(int) BlueOrRed
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (BlueOrRed == 1) {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); // red color
    } else {
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0); // yellow color
    }
    
        for (int i=firstPoint.x; i>lastPoint.x; i--) {
            CGContextFillRect(context, CGRectMake(i, lastPoint.y, 1.0, 1.0));
        }
   
}

@end
