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
    UIImageView *myPicture;
    
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
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, 220, 25)];
    [self.view addSubview:timeLabel];
    timeLabel.text = lastUpdated;
    timeLabel.font = [UIFont fontWithName:@"Chalkduster" size:15];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.backgroundColor = [UIColor clearColor];
}

- (void)contentTextView{
    
    myPicture = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, contentTextView.frame.size.width-20, 0)];
    myPicture.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:myPicture];
    
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 50, kScreenWidth-20, kScreenHeight-120)];
    contentTextView.layer.cornerRadius = 5.0;
    [self.view addSubview:contentTextView];
    contentTextView.font = [UIFont fontWithName:@"经典行书简" size:20];//Chalkduster Regular 经典行书简
    contentTextView.textColor = [UIColor whiteColor];
    contentTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bar_bg.jpg"]];
    contentTextView.delegate = self;
    
}

- (void)getAnPicture{
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = kGreenColor;
    
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.frame = CGRectMake(0, 0, 30, 30);
    [pictureBtn setImage:[UIImage imageNamed:@"zw_photo@2x.png"] forState:UIControlStateNormal];
    [pictureBtn addTarget:self action:@selector(getAnPicture) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = pictureBtn;
}

#pragma mark -- UIImagePackerCV Delegate
//- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    
//    
//    
//}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    myPicture.frame = CGRectMake(0, 0, kScreenWidth, 120);
    myPicture.image = image;
    
    contentTextView.frame = CGRectMake(10, 50+myPicture.frame.size.height, kScreenWidth-20, kScreenHeight-120);
    
    [picker dismissModalViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
