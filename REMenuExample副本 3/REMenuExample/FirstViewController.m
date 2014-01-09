//
//  FirstViewController.m
//  REMenuExample
//
//  Created by jiawei on 14-1-9.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "FirstViewController.h"


@interface FirstViewController (){
    UITextField *inputPass;
}

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)hideKeyboardAction{
    
    [_userNumber resignFirstResponder];
    [_password resignFirstResponder];
    
}

- (void)inputPassWord{
    
    NSDictionary *userIfo = [NSDictionary dictionaryWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]];
    NSLog(@"my dic == %@",userIfo);
    if ([[userIfo objectForKey:@"password"] isEqualToString:inputPass.text]) {
        [self passWordRight];
    }else{
        [SVProgressHUD showErrorWithStatus:@"passWord error!"];
    }
    
}


- (void)passWordRight{
    
    [self.navigationController pushViewController:[[HomeViewController alloc]init] animated:YES];
    
}

- (void)userLog{
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
        NSLog(@"creat a doc");
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        [mDic setObject:_password.text forKey:@"password"];
        [mDic writeToFile:[kDocumentPath stringByAppendingPathComponent:kUserInfomation] atomically:YES];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapHide = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboardAction)];
    [self.view addGestureRecognizer:tapHide];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_1.png"]];
    self.navigationItem.leftBarButtonItem = nil;

    if ([[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kUserInfomation]]) {
        
        inputPass = [[UITextField alloc]initWithFrame:CGRectMake(15, 60, kScreenWidth-30, 35)];
        inputPass.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
        inputPass.layer.borderWidth = 3.0;
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"glyphicons_044_keys.png"]];
        inputPass.rightView = img;
        [self.view addSubview:inputPass];
        
        UIButton *loginBT = [UIButton buttonWithType:UIButtonTypeCustom];
        loginBT.backgroundColor = kGreenColor;
        loginBT.layer.cornerRadius = 8;
        [loginBT addTarget:self action:@selector(inputPassWord) forControlEvents:UIControlEventTouchUpInside];
        [loginBT setImage:[UIImage imageNamed:@"bottom_bg.png"] forState:UIControlStateHighlighted];
        [loginBT setTintColor:[UIColor whiteColor]];
        [loginBT setTitle:@"登录" forState:UIControlStateNormal];
        loginBT.frame = CGRectMake(15, 103, kScreenWidth-30, 35);
        [self.view addSubview:loginBT];

        
    }else {
        
        [self creatUserPassWordViews];
        
    }
        
    
    
    
    
}

- (void)creatUserPassWordViews{
    _logView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 150)];
    _logView.backgroundColor = [UIColor clearColor];
    _logView.layer.cornerRadius = 10;
    [self.view addSubview:_logView];
    
    //用户名
    _userNumber = [[CustemTextField alloc]initWithFrame:CGRectMake(15, 11, _logView.bounds.size.width-30, 35)];
    //[_userNumber becomeFirstResponder];
    _userNumber.placeholder = @"请输入账号";
    _userNumber.delegate = self;
    _userNumber.keyboardType = UIKeyboardTypeNumberPad;
    _userNumber.borderStyle = UITextBorderStyleRoundedRect;
    _userNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *imgv=[[UIImageView alloc]  initWithFrame:CGRectMake(80, 2.5, 15, 15)];
    imgv.image = [UIImage imageNamed:@"mmxgImage@2x_.png"];//mmxgImage@2x_.png
    _userNumber.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
    _userNumber.layer.borderWidth = 2.0;
    _userNumber.leftView.contentMode = UIViewContentModeBottomLeft;
    _userNumber.leftView = imgv;
    _userNumber.leftViewMode = UITextFieldViewModeAlways;
    [_logView addSubview:_userNumber];
    _userNumber.backgroundColor = [UIColor clearColor];
    
    
    //密码
    _password = [[CustemTextField alloc]initWithFrame:CGRectMake(15, 57, _logView.bounds.size.width-30, 35)];
    _password.placeholder = @"请输入密码";
    
    _password.secureTextEntry = YES;//隐藏输入密码
    _password.delegate = self;
    _password.keyboardType = UIKeyboardTypeASCIICapable;
    _password.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _password .borderStyle = UITextBorderStyleRoundedRect;
    _password.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    UIImageView *imgv1=[[UIImageView alloc]initWithFrame:CGRectMake(8, 2.5, 20, 20)];
    imgv1.image = [UIImage imageNamed:@"glyphicons_204_unlock.png"];
    _password.leftView = imgv1;
    _password.leftViewMode = UITextFieldViewModeAlways;
    _password.backgroundColor = [UIColor clearColor];
    [_logView addSubview:_password];
    
    
    //登录
    UIButton *loginBT = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBT.backgroundColor = kGreenColor;
    loginBT.layer.cornerRadius = 8;
    [loginBT addTarget:self action:@selector(userLog) forControlEvents:UIControlEventTouchUpInside];
    [loginBT setImage:[UIImage imageNamed:@"bottom_bg.png"] forState:UIControlStateHighlighted];
    [loginBT setTintColor:[UIColor whiteColor]];
    [loginBT setTitle:@"登录" forState:UIControlStateNormal];
    loginBT.frame = CGRectMake(15, 103, _logView.bounds.size.width-30, 35);
    [_logView addSubview:loginBT];
    
    UIImageView *keyView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [keyView setImage:[UIImage imageNamed:@"glyphicons_044_keys.png"]];
    self.navigationItem.titleView = keyView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
