//
//  HomeViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "HomeViewController.h"
#import "AddDiaryViewController.h"

@interface HomeViewController (){
    
    UIScrollView *baseView;
    UILabel *timeLabel;
    UIView *contentView;
    UITextView *contentTextView;
    UIImageView *myPicture;
    NSData *pictureData;
    UIButton *emotion;
    UIButton *weather;
    NSString *emotionString;
    NSString *weatherString;
    
}

@end

@implementation HomeViewController

#pragma mark -- 保存日记
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
            [mDic setObject:emotionString forKey:@"emotion"];
            [mDic setObject:weatherString forKey:@"weather"];
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
            [mDic setObject:emotionString forKey:@"emotion"];
            [mDic setObject:weatherString forKey:@"weather"];
            if (pictureData) {
                NSLog(@"have image");
                [mDic setObject:pictureData forKey:@"image"];
            }else{
                NSLog(@"no image");
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

#pragma mark -- 时间
- (void)timeLabel{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];//实例化设置时间格式的类
    [df setDateFormat:@"YYYY.MM.dd EE"];//设置时间格式
    NSString *lastUpdated = [NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];//获取系统时间
    NSLog(@"%@",lastUpdated);//打印结果2013-6月-11 at 11:34 上午 中国标准时间
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, 220, 25)];
    [baseView addSubview:timeLabel];
    timeLabel.text = lastUpdated;
    timeLabel.font = [UIFont fontWithName:@"Chalkduster" size:15];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.backgroundColor = [UIColor clearColor];
}

#pragma mark -- 日记内容
- (void)contentTextView{
    
    contentView = [[UIView alloc]initWithFrame:CGRectMake(10,50,kScreenWidth-20, kScreenHeight-120)
                   ];
    contentView.layer.cornerRadius = 5.0;
    contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bar_bg.jpg"]];
    [baseView addSubview:contentView];
    
    myPicture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 140, contentView.frame.size.width-40, 0)];
    myPicture.backgroundColor = [UIColor clearColor];
    myPicture.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:myPicture];
    
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-40, kScreenHeight-220)];
    [contentView addSubview:contentTextView];
    contentTextView.font = [UIFont fontWithName:@"经典行书简" size:20];//Chalkduster Regular 经典行书简
    contentTextView.textColor = [UIColor whiteColor];
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.delegate = self;
    
}

- (void)getAnPictureByCamera{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
    
}

- (void)getAnPictureByAlbum{
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentModalViewController:picker animated:YES];
    
}

- (void)emotionsViews{
    
    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterItem setMenuActionWithBlock:^{
        [emotion setImage:[UIImage imageNamed:@"emtion_1.png"] forState:UIControlStateNormal];
        emotionString = @"emtion_1.png";
        [self.emotionMenu close];
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"emtion_1.png"]];
    [twitterItem addSubview:twitterIcon];
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailItem setMenuActionWithBlock:^{
        [emotion setImage:[UIImage imageNamed:@"emotion_love.png"] forState:UIControlStateNormal];
        emotionString = @"emotion_love.png";
        [self.emotionMenu close];
    }];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40 , 40)];
    [emailIcon setImage:[UIImage imageNamed:@"emotion_love.png"]];
    [emailItem addSubview:emailIcon];
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [facebookItem setMenuActionWithBlock:^{
        [emotion setImage:[UIImage imageNamed:@"emotion21.png"] forState:UIControlStateNormal];
        emotionString = @"emotion21.png";
        //emotion.image = [UIImage imageNamed:@"emotion21.png"];
        [self.emotionMenu close];
        
    }];
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
    [facebookIcon setImage:[UIImage imageNamed:@"emotion21.png"]];
    [facebookItem addSubview:facebookIcon];
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        [emotion setImage:[UIImage imageNamed:@"emotion57.png"] forState:UIControlStateNormal];
        emotionString = @"emotion57.png";
        [self.emotionMenu close];
    }];
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"emotion57.png"]];
    [browserItem addSubview:browserIcon];

    UIView *emotion5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion5 setMenuActionWithBlock:^{
        [emotion setImage:[UIImage imageNamed:@"emotion_2.png"] forState:UIControlStateNormal];
        emotionString = @"emotion_2.png";
        //emotion.image = [UIImage imageNamed:@"emotion57.png"];
        [self.emotionMenu close];
    }];
    UIImageView *emotion5Icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion5Icon setImage:[UIImage imageNamed:@"emotion_2.png"]];
    [emotion5 addSubview:emotion5Icon];//emotion_3
    
    UIView *emotion6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion6 setMenuActionWithBlock:^{
        [emotion setImage:[UIImage imageNamed:@"emotion_3.png"] forState:UIControlStateNormal];
        emotionString = @"emotion_3.png";
        [self.emotionMenu close];
    }];
    UIImageView *emotion6Icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion6Icon setImage:[UIImage imageNamed:@"emotion_3.png"]];
    [emotion6 addSubview:emotion6Icon];
    
    UIView *emotion7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion7 setMenuActionWithBlock:^{
        [emotion setImage:[UIImage imageNamed:@"emotion24.png"] forState:UIControlStateNormal];
        emotionString = @"emotion24.png";
        [self.emotionMenu close];
    }];
    UIImageView *emotion7Icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion7Icon setImage:[UIImage imageNamed:@"emotion24.png"]];
    [emotion7 addSubview:emotion7Icon];
    
    
    self.emotionMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem, emailItem, facebookItem, browserItem,emotion5,emotion6,emotion7]];
    [self.emotionMenu setItemSpacing:5.0f];
    [self.view addSubview:self.emotionMenu];
    self.emotionMenu.menuPosition = HMSideMenuPositionBottom;
    
}


- (void)weatherViews{
    
    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterItem setMenuActionWithBlock:^{
        [weather setImage:[UIImage imageNamed:@"Weather_01.png"] forState:UIControlStateNormal];
        weatherString = @"Weather_01.png";
        [self.weatherMenu close];
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"Weather_01.png"]];
    [twitterItem addSubview:twitterIcon];
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailItem setMenuActionWithBlock:^{
        [weather setImage:[UIImage imageNamed:@"Weather_02.png"] forState:UIControlStateNormal];
        weatherString = @"Weather_02.png";
        [self.weatherMenu close];
    }];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40 , 40)];
    [emailIcon setImage:[UIImage imageNamed:@"Weather_02.png"]];
    [emailItem addSubview:emailIcon];
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [facebookItem setMenuActionWithBlock:^{
        [weather setImage:[UIImage imageNamed:@"Weather_04.png"] forState:UIControlStateNormal];
        weatherString = @"Weather_04.png";
        //emotion.image = [UIImage imageNamed:@"emotion21.png"];
        [self.weatherMenu close];
        
    }];
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [facebookIcon setImage:[UIImage imageNamed:@"Weather_04.png"]];
    [facebookItem addSubview:facebookIcon];
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        [weather setImage:[UIImage imageNamed:@"Weather_03.png"] forState:UIControlStateNormal];
        weatherString = @"Weather_03.png";
        //emotion.image = [UIImage imageNamed:@"emotion57.png"];
        [self.weatherMenu close];
    }];
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"Weather_03.png"]];
    [browserItem addSubview:browserIcon];
    
    self.weatherMenu = [[HMSideMenu alloc] initWithItems:@[twitterItem, emailItem, facebookItem, browserItem]];
    [self.weatherMenu setItemSpacing:5.0f];
    [self.view addSubview:self.weatherMenu];
    self.weatherMenu.menuPosition = HMSideMenuPositionTop;
    
}

- (void)selectEmotion{
    
    if (self.emotionMenu.isOpen)
        [self.emotionMenu close];
    else
        [self.emotionMenu open];
    
}


- (void)selectWeather{
    
    if (self.weatherMenu.isOpen)
        [self.weatherMenu close];
    else
        [self.weatherMenu open];
    
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
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonSystemItemCompose target:self action:@selector(saveMyDiary)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(saveMyDiary)];
    //导航条中间图片
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.frame = CGRectMake(0, 0, 30, 30);
    [pictureBtn setImage:[UIImage imageNamed:@"zw_photo@2x.png"] forState:UIControlStateNormal];
    [pictureBtn addTarget:self action:@selector(getAnPicture) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *buttonsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    buttonsView.backgroundColor = kGreenColor;
    buttonsView.layer.cornerRadius = 5.0;
    
    //拍照按钮
    UIButton *up = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 30, 30)];
    [up setBackgroundImage:[UIImage imageNamed:@"CameraBtnNormal_.png"] forState:UIControlStateNormal];
    [up setBackgroundImage:[UIImage imageNamed:@"CameraBtnNormal_2.png"] forState:UIControlStateHighlighted];
    [up addTarget:self action:@selector(getAnPictureByCamera) forControlEvents:UIControlEventTouchUpInside];

    UIView *center = [[UIView alloc]initWithFrame:CGRectMake(59, 0, 1, 29)];
    center.backgroundColor = kBlueColor;
    
    //图片按钮
    UIButton *down = [[UIButton alloc]initWithFrame:CGRectMake(75, 0, 30, 30)];
    [down setImage:[UIImage imageNamed:@"AlbumBtnNormal_.png"] forState:UIControlStateNormal];
    [down setImage:[UIImage imageNamed:@"AlbumBtnNormal_1.png"] forState:UIControlStateHighlighted];
    [down addTarget:self action:@selector(getAnPictureByAlbum) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:up];
    [buttonsView addSubview:center];
    [buttonsView addSubview:down];
    
    self.navigationItem.titleView = buttonsView;
    
    
    //心情
    emotionString = [[NSString alloc]init];
    emotionString = @"EmotionDefaul_.png";
    [self emotionsViews];
    emotion = [UIButton buttonWithType:UIButtonTypeCustom];
    emotion.frame = CGRectMake( 220,13 , 30, 30);
    [emotion addTarget:self action:@selector(selectEmotion) forControlEvents:UIControlEventTouchDown];
    [emotion setImage:[UIImage imageNamed:@"EmotionDefaul_.png"] forState:UIControlStateNormal];
    [baseView addSubview:emotion];
    
    
    //天气
    weatherString = [[NSString alloc]init];
    weatherString = @"Weather.png";
    [self weatherViews];
    weather = [UIButton buttonWithType:UIButtonTypeCustom];
    weather.frame = CGRectMake(260, 13, 30, 30);
    [weather setImage:[UIImage imageNamed:@"Weather.png"] forState:UIControlStateNormal];
    [weather addTarget:self action:@selector(selectWeather) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:weather];
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
