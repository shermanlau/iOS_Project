//
//  main.m
//  project
//
//  Created by abc on 7/3/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

//#import <UIKit/UIKit.h>

#import "PicFrame.h"

@implementation PicFrame

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRect(path, nil, self.bounds);
    CGContextAddPath(context, path);
    //[[UIColor colorWithWhite:1.0f alpha:0.0f]setFill];
    [[UIColor colorWithWhite:1 alpha:1.0f] setStroke];
    CGContextSetLineWidth(context, 7.0f);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
}
@end