//
//  HomeViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "HomeViewController.h"
#import "DemoViewController.h"
#import "AddDiaryViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Home";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addDiary)];//addBtnImage@2x.png
    
    
    

}

- (void)addDiary{
    
    NSLog(@"HomeViewController addDiary");
    AddDiaryViewController *nv = [[AddDiaryViewController alloc] init];
    [self.navigationController pushViewController:nv animated:YES];
    
}






@end
