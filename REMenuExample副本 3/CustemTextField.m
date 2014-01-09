//
//  CustemTextField.m
//  REMenuExample
//
//  Created by jiawei on 14-1-9.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "CustemTextField.h"

@implementation CustemTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawPlaceholderInRect:CGRectMake(30, 15, 120, 30)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawPlaceholderInRect:(CGRect)rect

{
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    
    [[UIColor whiteColor] setFill];
    
    
    
    [[self placeholder] drawInRect:rect withFont:[UIFont fontWithName:@"苏新诗古印宋简" size:13]];
    
}

@end
