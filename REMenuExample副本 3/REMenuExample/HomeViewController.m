//
//  HomeViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "HomeViewController.h"
#import "DemoViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Home";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDiary)];//addBtnImage@2x.png
    /*
    UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBut.frame = CGRectMake(0, 0, 30, 30);
    [rightBut setBackgroundImage:[UIImage imageNamed:@"addBtnImage@2x.png"] forState:UIControlStateNormal];
    [rightBut addTarget:self action:@selector(addDiary) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBut];*/

}

- (void)addDiary{
    
    NSLog(@"HomeViewController addDiary");
   DemoViewController *nv = [[DemoViewController alloc] initWithNibName:@"DemoViewController" bundle:nil];
    [self.navigationController pushViewController:nv animated:YES];
    
}






@end
