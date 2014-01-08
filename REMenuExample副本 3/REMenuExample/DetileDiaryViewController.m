//
//  DetileDiaryViewController.m
//  REMenuExample
//
//  Created by jiawei on 14-1-8.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "DetileDiaryViewController.h"

@interface DetileDiaryViewController ()

@end

@implementation DetileDiaryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)backAction{

    NSLog(@"backAction");
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.emotion setImage:[UIImage imageNamed:[self.dairyDic objectForKey:dicEmotion]] forState:UIControlStateNormal];
    self.emotion.enabled = NO;
    
    [self.weather setImage:[UIImage imageNamed:[self.dairyDic objectForKey:dicWeather]] forState:UIControlStateNormal];
    self.weather.enabled = NO;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 45, 45);
    [backButton setImage:[UIImage imageNamed:@"backBtnImage_.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.navigationItem.titleView = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    self.contentTextView.text = [self.dairyDic objectForKey:dicContent];
    self.contentTextView.frame = CGRectMake(10, 10, kScreenWidth-40, kScreenHeight-220);
    self.contentTextView.editable = NO;
    
    if ([self.dairyDic objectForKey:dicImage]) {
        [self.myPicture setImage:[UIImage imageWithData:[NSData dataWithData:[self.dairyDic objectForKey:dicImage]]]];
        self.myPicture.frame =  CGRectMake(0, 10, kScreenWidth-60, 120);
        self.myPicture.backgroundColor = [UIColor clearColor];
        self.contentTextView.frame = CGRectMake(10, 130, kScreenWidth-40, kScreenHeight-220);
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
