//
//  HomeViewController.h
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "MMProgressHUDOverlayView.h"
#import "MMProgressHUD.h"
#import "SVProgressHUD.h"
#import "CSNotificationView.h"
#import "HMSideMenu.h"

@interface HomeViewController : RootViewController<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) HMSideMenu *emotionMenu;
@property (nonatomic, strong) HMSideMenu *weatherMenu;
@property (nonatomic, strong) UIButton *emotion;
@property (nonatomic, strong) UIButton *weather;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIImageView *myPicture;

@end
