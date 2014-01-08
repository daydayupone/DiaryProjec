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
    UIView *contentView;
    NSData *pictureData;
    NSString *emotionString;
    NSString *weatherString;
    HMSideMenu *moreAction;
    
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
            [mDic setObject:self.timeLabel.text forKey:@"time"];
            [mDic setObject:self.contentTextView.text forKey:@"content"];
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
            [mDic setObject:self.timeLabel.text forKey:@"time"];
            [mDic setObject:self.contentTextView.text forKey:@"content"];
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
            [self.contentTextView resignFirstResponder];
            
            
        });
        
    });
    
    
    
    
    
    
    
}

- (void)hideKeyBoard{
    
    [self.contentTextView resignFirstResponder];
    
}

#pragma mark -- shareMyDiary
- (void)shareMyDiary{
    
    NSLog(@"shareMyDiary");
    
}

#pragma mark -- 选择图片
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

#pragma mark -- 表情
- (void)emotionsViews{
    
    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterItem setMenuActionWithBlock:^{
        [self.emotion setImage:[UIImage imageNamed:@"emtion_1.png"] forState:UIControlStateNormal];
        emotionString = @"emtion_1.png";
        [self.emotionMenu close];
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"emtion_1.png"]];
    [twitterItem addSubview:twitterIcon];
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailItem setMenuActionWithBlock:^{
        [self.emotion setImage:[UIImage imageNamed:@"emotion_love.png"] forState:UIControlStateNormal];
        emotionString = @"emotion_love.png";
        [self.emotionMenu close];
    }];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40 , 40)];
    [emailIcon setImage:[UIImage imageNamed:@"emotion_love.png"]];
    [emailItem addSubview:emailIcon];
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [facebookItem setMenuActionWithBlock:^{
        [self.emotion setImage:[UIImage imageNamed:@"emotion21.png"] forState:UIControlStateNormal];
        emotionString = @"emotion21.png";
        //emotion.image = [UIImage imageNamed:@"emotion21.png"];
        [self.emotionMenu close];
        
    }];
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(2, 2, 35, 35)];
    [facebookIcon setImage:[UIImage imageNamed:@"emotion21.png"]];
    [facebookItem addSubview:facebookIcon];
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        [self.emotion setImage:[UIImage imageNamed:@"emotion57.png"] forState:UIControlStateNormal];
        emotionString = @"emotion57.png";
        [self.emotionMenu close];
    }];
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"emotion57.png"]];
    [browserItem addSubview:browserIcon];

    UIView *emotion5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion5 setMenuActionWithBlock:^{
        [self.emotion setImage:[UIImage imageNamed:@"emotion_2.png"] forState:UIControlStateNormal];
        emotionString = @"emotion_2.png";
        //emotion.image = [UIImage imageNamed:@"emotion57.png"];
        [self.emotionMenu close];
    }];
    UIImageView *emotion5Icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion5Icon setImage:[UIImage imageNamed:@"emotion_2.png"]];
    [emotion5 addSubview:emotion5Icon];//emotion_3
    
    UIView *emotion6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion6 setMenuActionWithBlock:^{
        [self.emotion setImage:[UIImage imageNamed:@"emotion_3.png"] forState:UIControlStateNormal];
        emotionString = @"emotion_3.png";
        [self.emotionMenu close];
    }];
    UIImageView *emotion6Icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion6Icon setImage:[UIImage imageNamed:@"emotion_3.png"]];
    [emotion6 addSubview:emotion6Icon];
    
    UIView *emotion7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emotion7 setMenuActionWithBlock:^{
        [self.emotion setImage:[UIImage imageNamed:@"emotion24.png"] forState:UIControlStateNormal];
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

#pragma mark -- 天气
- (void)weatherViews{
    
    UIView *twitterItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [twitterItem setMenuActionWithBlock:^{
        [self.weather setImage:[UIImage imageNamed:@"Weather_01.png"] forState:UIControlStateNormal];
        weatherString = @"Weather_01.png";
        [self.weatherMenu close];
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [twitterIcon setImage:[UIImage imageNamed:@"Weather_01.png"]];
    [twitterItem addSubview:twitterIcon];
    
    UIView *emailItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [emailItem setMenuActionWithBlock:^{
        [self.weather setImage:[UIImage imageNamed:@"Weather_02.png"] forState:UIControlStateNormal];
        weatherString = @"Weather_02.png";
        [self.weatherMenu close];
    }];
    UIImageView *emailIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40 , 40)];
    [emailIcon setImage:[UIImage imageNamed:@"Weather_02.png"]];
    [emailItem addSubview:emailIcon];
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [facebookItem setMenuActionWithBlock:^{
        [self.weather setImage:[UIImage imageNamed:@"Weather_04.png"] forState:UIControlStateNormal];
        weatherString = @"Weather_04.png";
        //emotion.image = [UIImage imageNamed:@"emotion21.png"];
        [self.weatherMenu close];
        
    }];
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [facebookIcon setImage:[UIImage imageNamed:@"Weather_04.png"]];
    [facebookItem addSubview:facebookIcon];
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        [self.weather setImage:[UIImage imageNamed:@"Weather_03.png"] forState:UIControlStateNormal];
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

#pragma mark -- 保存、分享
- (void)saveandshareviews{
    
    UIView *facebookItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [facebookItem setMenuActionWithBlock:^{
        [self saveMyDiary];
    }];
    UIImageView *facebookIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [facebookIcon setImage:[UIImage imageNamed:@"ckwys-2_55@2x.png"]];
    [facebookItem addSubview:facebookIcon];
    
    UIView *browserItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [browserItem setMenuActionWithBlock:^{
        nil;
    }];
    UIImageView *browserIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    [browserIcon setImage:[UIImage imageNamed:@"Weather_03.png"]];
    [browserItem addSubview:browserIcon];
    
    moreAction = [[HMSideMenu alloc] initWithItems:@[facebookItem, browserItem]];
    [moreAction setItemSpacing:5.0f];
    [self.view addSubview:moreAction];
    moreAction.menuPosition = HMSideMenuPositionRight;
    
}

#pragma mark -- 选择表情
- (void)selectEmotion{
    
    if (self.emotionMenu.isOpen)
        [self.emotionMenu close];
    else
        [self.emotionMenu open];
    
}

#pragma mark -- 选择天气
- (void)selectWeather{
    
    if (self.weatherMenu.isOpen)
        [self.weatherMenu close];
    else
        [self.weatherMenu open];
    
}

#pragma mark -- 更多操作
- (void)getmoreaciton{
    
    if (moreAction.isOpen) {
        [moreAction close];
    }else{
        [moreAction open];
    }
    
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
    NSDateFormatter *df = [[NSDateFormatter alloc]init];//实例化设置时间格式的类
    [df setDateFormat:@"YYYY.MM.dd EE"];//设置时间格式
    NSString *lastUpdated = [NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];//获取系统时间
    NSLog(@"%@",lastUpdated);//打印结果2013-6月-11 at 11:34 上午 中国标准时间
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 10, 220, 25)];
    [baseView addSubview:self.timeLabel];
    self.timeLabel.text = lastUpdated;
    self.timeLabel.font = [UIFont fontWithName:@"Chalkduster" size:15];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.backgroundColor = [UIColor clearColor];
    
    
    //日记内容
    contentView = [[UIView alloc]initWithFrame:CGRectMake(10,50,kScreenWidth-20, kScreenHeight-120)
                   ];
    contentView.layer.cornerRadius = 5.0;
    contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menu_bar_bg.jpg"]];
    [baseView addSubview:contentView];
    
    self.myPicture = [[UIImageView alloc]initWithFrame:CGRectMake(0, 140, contentView.frame.size.width-40, 0)];
    self.myPicture.backgroundColor = [UIColor clearColor];
    self.myPicture.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:self.myPicture];
    
    self.contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-40, kScreenHeight-220)];
    [contentView addSubview:self.contentTextView];
    self.contentTextView.font = [UIFont fontWithName:@"经典行书简" size:20];//Chalkduster Regular 经典行书简
    self.contentTextView.textColor = [UIColor whiteColor];
    self.contentTextView.backgroundColor = [UIColor clearColor];
    self.contentTextView.delegate = self;
    
    //隐藏手势
    UITapGestureRecognizer *hideKeyBoard = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
    [self.view addGestureRecognizer:hideKeyBoard];
    
    //右侧存储操作
    [self saveandshareviews];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"ckwys-2_55@2x.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(saveMyDiary) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];

    
    //导航条中间图片
    UIButton *pictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pictureBtn.frame = CGRectMake(0, 0, 30, 30);
    [pictureBtn setImage:[UIImage imageNamed:@"zw_photo@2x.png"] forState:UIControlStateNormal];
    [pictureBtn addTarget:self action:@selector(getAnPicture) forControlEvents:UIControlEventTouchUpInside];
    //ckwys-2_55@2x.png
    UIView *buttonsView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 30)];
    buttonsView.backgroundColor = kGreenColor;
    buttonsView.layer.cornerRadius = 5.0;
    
    //拍照按钮
    UIButton *up = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 30, 30)];
    [up setBackgroundImage:[UIImage imageNamed:@"CameraBtnNormal_.png"] forState:UIControlStateNormal];
    //[up setBackgroundImage:[UIImage imageNamed:@"CameraBtnNormal_2.png"] forState:UIControlStateHighlighted];
    [up addTarget:self action:@selector(getAnPictureByCamera) forControlEvents:UIControlEventTouchUpInside];

    UIView *center = [[UIView alloc]initWithFrame:CGRectMake(59, 0, 1, 29)];
    center.backgroundColor = kBlueColor;
    
    //图片按钮
    UIButton *down = [[UIButton alloc]initWithFrame:CGRectMake(75, 0, 30, 30)];
    [down setImage:[UIImage imageNamed:@"AlbumBtnNormal_.png"] forState:UIControlStateNormal];
    [down addTarget:self action:@selector(getAnPictureByAlbum) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *center1 = [[UIView alloc]initWithFrame:CGRectMake(119, 0, 1, 29)];
    center1.backgroundColor = kBlueColor;
    
    UIButton *sharebut = [[UIButton alloc]initWithFrame:CGRectMake(140, 5, 18, 18)];
    [sharebut setImage:[UIImage imageNamed:@"smImage@2x.png"] forState:UIControlStateNormal];
    [sharebut addTarget:self action:@selector(shareMyDiary) forControlEvents:UIControlEventTouchUpInside];
    [buttonsView addSubview:up];
    [buttonsView addSubview:center];
    [buttonsView addSubview:down];
    [buttonsView addSubview:center1];
    [buttonsView addSubview:sharebut];
    
    self.navigationItem.titleView = buttonsView;
    
    
    //心情
    emotionString = [[NSString alloc]init];
    emotionString = @"EmotionDefaul_.png";
    [self emotionsViews];
    self.emotion = [UIButton buttonWithType:UIButtonTypeCustom];
    self.emotion.frame = CGRectMake( 220,13 , 30, 30);
    [self.emotion addTarget:self action:@selector(selectEmotion) forControlEvents:UIControlEventTouchDown];
    [self.emotion setImage:[UIImage imageNamed:@"EmotionDefaul_.png"] forState:UIControlStateNormal];
    [baseView addSubview:self.emotion];
    
    
    //天气
    weatherString = [[NSString alloc]init];
    weatherString = @"Weather.png";
    [self weatherViews];
    self.weather = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weather.frame = CGRectMake(260, 13, 30, 30);
    [self.weather setImage:[UIImage imageNamed:@"Weather.png"] forState:UIControlStateNormal];
    [self.weather addTarget:self action:@selector(selectWeather) forControlEvents:UIControlEventTouchDown];
    [baseView addSubview:self.weather];
}



#pragma mark -- UIImagePackerCV Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    CGSize newSize = CGSizeMake(320, 480);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.myPicture.frame = CGRectMake(0, 10, kScreenWidth-60, 120);
    self.myPicture.image = newImage;
    
    pictureData = UIImageJPEGRepresentation(image, 0.001);
    
    self.contentTextView.frame = CGRectMake(10, 10+self.myPicture.frame.size.height, kScreenWidth-40, kScreenHeight-220);
    
    [picker dismissModalViewControllerAnimated:YES];
    
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    baseView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight*2-200);
    contentView.frame = CGRectMake(10,50,kScreenWidth-20, kScreenHeight+60);
}



@end
