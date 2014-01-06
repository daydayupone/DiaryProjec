//
//  SecondCell.h
//  REMenuExample
//
//  Created by lin on 14-1-5.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondCell : UITableViewCell

@property (nonatomic, assign) BOOL doubleCell;
@property (nonatomic, strong) UIImageView *mainLine;
@property (nonatomic, strong) UIButton *mainCircle;
@property (nonatomic, strong) UIImageView *dkwysUp;
@property (nonatomic, strong) UIImageView *dkwysDown;
@property (nonatomic, strong) UITextView *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end
