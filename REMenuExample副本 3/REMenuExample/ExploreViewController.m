//
//  ExploreViewController.m
//  REMenuExample
//
//  Created by Roman Efimov on 4/18/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "ExploreViewController.h"
#import "SecondCell.h"

@interface ExploreViewController (){
//    CGFloat origin_y;
//    CGFloat ios7Height;
    NSArray *tableAr;
}


@end

@implementation ExploreViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
    if(ios7){
        origin_y= NAVBAR_HEIGHT+STATUS_HEIGHT;
        ios7Height = 0;
    }else{
        origin_y=0;
        ios7Height = 65;
    }*/
    
    self.title = @"Explore";

    self.view.backgroundColor = kBlueColor;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
    
    
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:[kDocumentPath stringByAppendingPathComponent:kDiaryName] isDirectory:nil]) {
        tableAr = [NSArray arrayWithContentsOfFile:[kDocumentPath stringByAppendingPathComponent:kDiaryName]];
        if (tableAr.count>1) {
            UITableView *diayTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-65)];
            
            UIImageView * mainLine = [[UIImageView alloc]initWithFrame:CGRectMake(44.5+78,0,5,kScreenHeight-65)];
            [mainLine setImage:[UIImage imageNamed:@"mainRwLine@2x.png"]];
            [self.view addSubview:mainLine];
            diayTable.backgroundColor = [UIColor clearColor];
            
            [self.view addSubview:diayTable];
            diayTable.separatorStyle = UITableViewCellSeparatorStyleNone;
            diayTable.delegate = self;
            diayTable.dataSource = self;
        }
        
    }
    
    
}

#pragma mark - UITableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return tableAr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    
    if (!cell) {
        cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        int a = indexPath.row%2;
        NSLog(@"%d",a);
        if (a == 1) {
            cell.doubleCell = YES;
        }else{
            cell.doubleCell = NO;
        }
    }
    
    cell.timeLabel.text = [[tableAr objectAtIndex:indexPath.row]objectForKey:@"time"];
    cell.contentLabel.text = [[tableAr objectAtIndex:indexPath.row]objectForKey:@"content"];

    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"indexPath.row == %d",indexPath.row);
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
