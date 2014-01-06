//
//  AddDiaryViewController.m
//  REMenuExample
//
//  Created by jiawei on 14-1-6.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "AddDiaryViewController.h"
#import "CSNotificationView.h"

@interface AddDiaryViewController (){
    UILabel *timeLabel;
    UITextView *contentTextView;
}

@end

@implementation AddDiaryViewController

- (void)saveMyDiary{
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kDiaryName]]) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        NSMutableArray *diaryAr = [[NSMutableArray alloc]init];
        [mDic setObject:timeLabel.text forKey:@"time"];
        [mDic setObject:contentTextView.text forKey:@"content"];
        [diaryAr insertObject:mDic atIndex:0];
        [diaryAr writeToFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName] atomically:YES];
        
    }else{
        NSMutableArray * mArrReports = [NSMutableArray arrayWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName]];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        [mDic setObject:timeLabel.text forKey:@"time"];
        [mDic setObject:contentTextView.text forKey:@"content"];
        [mArrReports insertObject:mDic atIndex:0];
        [mArrReports writeToFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName] atomically:YES ];
    }
    
    [CSNotificationView showInViewController:self
                                   tintColor:kGreenColor
                                       image:[UIImage imageNamed:@"ckwys-2_55@2x.png"]
                                     message:@"     OK    "
                                    duration:0.8f];
    
    [contentTextView resignFirstResponder];
    
}

- (void)hideKeyBoard{
    
    [contentTextView resignFirstResponder];
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self timeLabel];
        
        [self contentTextView];
        
        UITapGestureRecognizer *hideKeyBoard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
        [self.view addGestureRecognizer:hideKeyBoard];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveMyDiary)];
        
        
        
        
    }
    return self;
}

- (void)timeLabel{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];//实例化设置时间格式的类
    [df setDateFormat:@"YYYY.MM.dd HH:mm:ss"];//设置时间格式
    NSString *lastUpdated = [NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];//获取系统时间
    NSLog(@"%@",lastUpdated);//打印结果2013-6月-11 at 11:34 上午 中国标准时间
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 120, 25)];
    [self.view addSubview:timeLabel];
    timeLabel.text = lastUpdated;
    timeLabel.font = [UIFont fontWithName:@"Chalkduster" size:15];
    timeLabel.backgroundColor = kGreenColor;
}

- (void)contentTextView{
    
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 50, kScreenWidth-20, kScreenHeight-80)];
    contentTextView.layer.cornerRadius = 3.5;
    [self.view addSubview:contentTextView];
    contentTextView.font = [UIFont fontWithName:@"Chalkduster" size:15];
    contentTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    contentTextView.delegate = self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
