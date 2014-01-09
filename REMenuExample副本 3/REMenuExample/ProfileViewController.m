//
//  ProfileViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Profile";
    /*
    UIScrollView *basc = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:basc];
    basc.pagingEnabled = NO;
    basc.scrollEnabled= YES;
    basc.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*3);
    
    NSArray* fontArrays = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    for (int i = 0; i<fontArrays.count; i++) {
        NSString* fontName = [fontArrays objectAtIndex:i];
        UILabel *fontLable = [[UILabel alloc]initWithFrame:CGRectMake(10+160*(i%2), 5+20*i, 150, 50)];
        fontLable.text = [NSString stringWithFormat:@"%@,ys维45",fontName];
        fontLable.font = [UIFont fontWithName:fontName size:13];
        [basc addSubview:fontLable];
    }
    for(NSString* temp in fontArrays) {
        NSLog(@"Font name  = %@", temp);
        
    }*/
    
    
}

@end
