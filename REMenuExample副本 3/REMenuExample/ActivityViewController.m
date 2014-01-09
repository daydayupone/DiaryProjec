//
//  ActivityViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ActivityViewController.h"
#import "HomeCell.h"

@interface ActivityViewController ()
@end

@implementation ActivityViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Activity";
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    

    UITableView *diaryTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60)];
    diaryTable.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:diaryTable];
    diaryTable.dataSource = self;
    diaryTable.delegate = self;

    
}

#pragma mark - UITableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[HomeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.img1.image = [UIImage imageNamed:@"num0@2x.png"];
    cell.img2.image = [UIImage imageNamed:@"num3@2x.png"];
    cell.img3.image = [UIImage imageNamed:@"num4@2x.png"];
    cell.img4.image = [UIImage imageNamed:@"num1@2x.png"];
    
    cell.diaryLabel.text = @"你知道吗，中国";
    /*
     cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ckwys-2_66@2x.png"]];
     cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ckwys-2_68@2x.png"]];
     */
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = kGreenColor;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}

@end
