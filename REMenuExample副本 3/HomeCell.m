//
//  HomeCell.m
//  REMenuExample
//
//  Created by lin on 14-1-3.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //UIButton: 74,8  37,8 30*30
        //UIImageView: 0,9 18,9 38,9 56,9         28*27
        //UILable: 91,7 30
        
        self.diaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(91, 7, kScreenWidth-78, 30)];
        self.diaryLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.diaryLabel];
        
        self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.editButton setBackgroundImage:[UIImage imageNamed:@"jkjlBtnUp@2x.png"] forState:UIControlStateNormal];
        [self.editButton setBackgroundImage:[UIImage imageNamed:@"jkjlBtnDown@2x.png"] forState:UIControlStateHighlighted];
        self.editButton.frame = CGRectMake(kScreenWidth - 74, 8, 30, 30);
        [self addSubview:self.editButton];
        
        self.exportButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.exportButton setti
        [self.exportButton setBackgroundImage:[UIImage imageNamed:@"jkzxBtnUp@2x.png"] forState:UIControlStateNormal];
        [self.exportButton setBackgroundImage:[UIImage imageNamed:@"jkzxBtnDown@2x.png"] forState:UIControlStateHighlighted];
        self.exportButton.frame = CGRectMake(kScreenWidth - 37, 8, 30, 30);
        [self addSubview:self.exportButton];
        
        self.img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 9, 28, 27)];
        [self.img1 setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.img1];
        self.img2 = [[UIImageView alloc]initWithFrame:CGRectMake(18, 9, 28, 27)];
        [self.img2 setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.img2];
        self.img3 = [[UIImageView alloc]initWithFrame:CGRectMake(38, 9, 28, 27)];
        [self.img3 setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.img3];
        self.img4 = [[UIImageView alloc]initWithFrame:CGRectMake(56, 9, 28, 27)];
        [self.img4 setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:self.img4];
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
