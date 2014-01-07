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

@interface HomeViewController (){
    UIScrollView *baseView;
    UILabel *timeLabel;
    UIView *contentView;
    UITextView *contentTextView;
    UIImageView *myPicture;
    NSData *pictureData;
}

@end

@implementation HomeViewController

- (void)saveMyDiary{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] <7.0) {
        
        CGFloat red =  24.0/255.0;
        CGFloat blue = 146.0/255.0;
        CGFloat green = 145.0/255.0;
        
        CGColorRef color = CGColorRetain([UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor);
        
        [[[MMProgressHUD sharedHUD] overlayView] setOverlayColor:color];
        
        CGColorRelease(color);
        
        [MMProgressHUD showWithTitle:nil status:@"Save…"];
        
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        if (![[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kDiaryName]]) {
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
            NSMutableArray *diaryAr = [[NSMutableArray alloc]init];
            [mDic setObject:timeLabel.text forKey:@"time"];
            [mDic setObject:contentTextView.text forKey:@"content"];
            if (pictureData) {
                NSLog(@"have image");
                [mDic setObject:pictureData forKey:@"image"];
            }else{
                NSLog(@"no image");
                //[mDic setObject:pictureData forKey:@"image"];
            }
            
            
            [diaryAr insertObject:mDic atIndex:0];
            [diaryAr writeToFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName] atomically:YES];
            
        }else{
            NSMutableArray * mArrReports = [NSMutableArray arrayWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName]];
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
            [mDic setObject:timeLabel.text forKey:@"time"];
            [mDic setObject:contentTextView.text forKey:@"content"];
            if (pictureData) {
                NSLog(@"have image");
                [mDic setObject:pictureData forKey:@"image"];
            }else{
                NSLog(@"no image");
                //[mDic setObject:pictureData forKey:@"image"];
            }
            [mArrReports insertObject:mDic atIndex:0];
            [mArrReports writeToFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName] atomically:YES ];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
                [CSNotificationView showInViewController:self
                                               tintColor:kGreenColor
                                                   image:[UIImage imageNamed:@"ckwys-2_55@2x.png"]
                                                 message:@"     OK    "
                                                duration:0.8f];
            }else{
                
                [MMProgressHUD dismissWithSuccess:@"OK!" title:nil afterDelay:0.5];
                
            };
            [contentTextView resignFirstResponder];
            
            
        });
        
    });
    
    
    
    
    
    
    
}

- (void)hideKeyBoard{
    
    [contentTextView resignFirstResponder];
    
}

- (void)timeLabel{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];//实例化设置时间格式的类
    [df setDateFormat:@"YYYY.MM.dd HH:mm:ss"];//设置时间格式
    NSString *lastUpdated = [NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];//获取系统时间
    NSLog(@"%@",lastUpdated);//打印结果2013-6月-11 at 11:34 上午 中国标准时间
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, 220, 25)];
    [baseView addSubview:timeLabel];
    timeLabel.text = lastUpdated;
    timeLabel.font = [UIFont fontWithName:@"Chalkduster" size:15];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.backgroundColor = [UIColor clearColor];
}

- (void)contentTextView{
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(10,50,kScreenWidth-20, kScreenHeight-120)];
    contentView.layer.cornerRadius = 5.0;
    contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bar_bg.jpg"]];
    [baseView addSubview:contentView];
    
    myPicture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 140, contentView.frame.size.width-40, 0)];
    myPicture.backgroundColor = [UIColor whiteColor];
    myPicture.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:myPicture];
    
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-40, kScreenHeight-220)];
    [contentView addSubview:contentTextView];
    contentTextView.font = [UIFont fontWithName:@"经典行书简" size:20];//Chalkduster Regular 经典行书简
    contentTextView.textColor = [UIColor whiteColor];
    contentTextView.backgroundColor = [UIColor clearColor];
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

    //底层
    baseView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    baseView.delegate = self;
    baseView.pagingEnabled = NO;
    baseView.scrollEnabled = YES;
    baseView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:baseView];
    
    //时间
    [self timeLabel];
    
    //日记内容
    [self contentTextView];
    
    //隐藏手势
    UITapGestureRecognizer *hideKeyBoard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:hideKeyBoard];
    
    //导航条右侧存储
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveMyDiary)];
    
    //导航条中间图片
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.frame = CGRectMake(0, 0, 30, 30);
    [pictureBtn setImage:[UIImage imageNamed:@"zw_photo@2x.png"] forState:UIControlStateNormal];
    [pictureBtn addTarget:self action:@selector(getAnPicture) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = pictureBtn;
    
}


#pragma mark -- UIImagePackerCV Delegate
//调用相机的代理方法
/*
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [self dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    [NSThread detachNewThreadSelector:@selector(useImage:) toTarget:self withObject:image];
    
}*/

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    CGSize newSize = CGSizeMake(320, 480);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    myPicture.frame = CGRectMake(0, 0, kScreenWidth, 120);
    myPicture.image = newImage;
    
    pictureData = UIImageJPEGRepresentation(image, 0.001);
    
    contentTextView.frame = CGRectMake(10, 10+myPicture.frame.size.height, kScreenWidth-40, kScreenHeight-220);
    
    [picker dismissModalViewControllerAnimated:YES];
    
}

/*新开启的线程所用到的方法。
 功能：在组件上显示图片、把图片存储到本地
- (void)useImage:(UIImage *)image {
    
    //对图片进行压缩
    CGSize newSize = CGSizeMake(320, 480);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    myPicture.frame = CGRectMake(0, 0, kScreenWidth, 120);
    myPicture.image = newImage;
    
    pictureData = UIImageJPEGRepresentation(newImage, 0.001);
    
    contentTextView.frame = CGRectMake(10, 10+myPicture.frame.size.height, kScreenWidth-40, kScreenHeight-220);
    
}*/

#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    baseView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*2-200);
    contentView.frame = CGRectMake(10,50,kScreenWidth-20, kScreenHeight+60);
}



@end
