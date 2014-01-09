//
//  FirstViewController.h
//  REMenuExample
//
//  Created by jiawei on 14-1-9.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "RootViewController.h"
#import "CustemTextField.h"
#import "HomeViewController.h"

@interface FirstViewController : RootViewController<UITextFieldDelegate>

@property (strong, nonatomic) CustemTextField *password;
@property (strong, nonatomic) CustemTextField *userNumber;//其实是编号
@property (strong, nonatomic) UIView *logView;
@end
