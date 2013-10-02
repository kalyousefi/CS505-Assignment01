//
//  MainViewController.m
//  Homework01
//
//  Created by Khaled Alyousefi on 9/11/13.
//  Copyright (c) 2013 Khaled Alyousefi. All rights reserved.
//
 
#import "MainViewController.h"

@interface MainViewController (){
    int height;
    int width;
    UIColor *image[320][320];
}

@end

@implementation MainViewController
@synthesize imageView;
- (void)viewDidLoad
{
    [super viewDidLoad];
    height = 320;
    width = 320;
    CGPoint centerPoint = CGPointMake(width / 2, height / 2);
    
    // ######################
    // Drawing My Lines      
    
    for (double i=0.25; i<1; i+=0.25) {
        CGPoint start = CGPointMake(i * width, 0);
        CGPoint end = CGPointMake((1-i) *width, height);
        [self drawLine:start To:end withColor:[UIColor redColor]];
        
        start = CGPointMake(0, i * height);
        end = CGPointMake(width, (1-i) *height);
        [self drawLine:start To:end withColor:[UIColor redColor]];                
    }

   // ######################
    // Drawing My Circles
    for (int r = 10; r < 230; r += 30)
    {
        [self drawCircle:r forCenterPoint:centerPoint];
    }

    // Create an Image
    [self createImageWithFileName:@"theStarImageUsingMyAlgorithm.png"];
    
    // Flush the array
    memset(&image[0], 0, sizeof(image));
    
    
    // ######################
    // Draw Bresenham Lines
    for (int i = 0; i < 360; i += 30) {
        int x = (int) (width * cos(i * M_PI / 180.0));
        int y = (int) (height * sin(i * M_PI / 180.0));
        [self drawBresenhamLine:CGPointMake(centerPoint.x, centerPoint.y) To:CGPointMake(centerPoint.x+x,centerPoint.y+y)];
    }
    // ######################    
    // Draw Bresenham Circles
    for (int r = 10; r < 230; r += 30)
    {
        [self drawBresenhamCircle:r forCenterPoint:centerPoint isFill:NO];
    }        
    
    // ######################
    // Create the image
    [self createImageWithFileName:@"theStarImageUsingBresenhamAlgorithm.png"];
}


//  @@@@@@ My Implementation of Drawing a line @@@@@@
- (void) drawLine:(CGPoint)startPoint To:(CGPoint)endPoint withColor:(UIColor *) color
{
    int x,y;
    double t = 0.001;
    
    for (double i=0.0; i<=1; i+=t) {
        x = [[NSNumber numberWithDouble:(startPoint.x + (endPoint.x - startPoint.x) * i)] intValue];
        y = [[NSNumber numberWithDouble:(startPoint.y + (endPoint.y - startPoint.y) * i)] intValue];
        if ((x >= 0) && (x < width) && (y >= 0) && (y < height))
        image[y][x] = color;
    }
}

//  @@@@@@ My Implementation of Drawing a Circle @@@@@@
- (void) drawCircle:(CGFloat)radius forCenterPoint: (CGPoint) centerPoint
{
    for (int i=0; i<=360; i++) {
        int x = centerPoint.x + radius * cos(i);
        int y = centerPoint.y + radius * sin(i);
        if ((x >= 0) && (x < width) && (y >= 0) && (y < height)) 
        image[y][x] = [UIColor yellowColor];
    }
}

//  @@@@@@ Bresenham's Implementation of Drawing a Line @@@@@@
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
        if (steep){
            if ((x >= 0) && (x < width) && (y >= 0) && (y < height))
                image[y][x] = [UIColor redColor];
        }else{
            if ((x >= 0) && (x < width) && (y >= 0) && (y < height))
                image[x][y] = [UIColor redColor];
        }
        error -= deltay;
        if (error < 0) {
            y += ystep;
            error += deltax;
        }
    }    
}

//  @@@@@@ Bresenham's Implementation of Drawing a Circle @@@@@@
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

        if ((x >= 0) && (y >= 0)){
            if ((xc+x < width) && (yc+y < height)){
                image[xc+x][yc+y] = [UIColor yellowColor];
            }
            
            if ((xc-x < width) && (yc+y < height)&& (xc-x >= 0)){
                image[xc-x][yc+y] = [UIColor yellowColor];
            }
            
            if ((xc+x < width) && (yc-y < height) && (yc-y >= 0)){
                image[xc+x][yc-y] = [UIColor yellowColor];
            }
            
            if ((xc-x < width) && (yc-y < height) && (xc-x >= 0) && (yc-y >= 0)){
                image[xc-x][yc-y] = [UIColor yellowColor];
            }
            
            if ((xc+y < width) && (yc+x < height)){
                image[xc+y][yc+x] = [UIColor yellowColor];
            }
                        
            if ((xc-y < width) && (yc+x < height) && (xc-y >= 0)){
                image[xc-y][yc+x] = [UIColor yellowColor];
            }
            
            if ((xc+y < width) && (yc-x < height) && (yc-x >= 0)){
                image[xc+y][yc-x] = [UIColor yellowColor];
            }
            
            if ((xc-y < width) && (yc-x < height) && (xc-y >= 0) && (yc-x >= 0)){
                image[xc-y][yc-x] = [UIColor yellowColor];
            }
        }
        x++;
    }
}

// &&&&&&&&&& DRAWING & CREATING IMAGE &&&&&&&&&&
- (void)createImageWithFileName:(NSString *) filename
{
    NSLog(@"Creating image");
    
    NSString *targetPath = [NSString stringWithFormat:@"/Users/khaledalyousefi/Documents/%@",filename];
    
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor blackColor] CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    UIColor *currentColor;
    
    for (int i = 0; i < height; ++i) {
        for (int j = 0; j < width; ++j) {
            currentColor = image[j][i];
            CGContextSetFillColorWithColor(context, [currentColor CGColor]);
            CGContextFillRect(context, CGRectMake(i, j, 1.0, 1.0));
        }
    }
    
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        
    [UIImagePNGRepresentation(result) writeToFile:targetPath atomically:YES];    
    imageView.image = result;
    [imageView setNeedsDisplay];    
    NSLog(@"Image creation finished");
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
