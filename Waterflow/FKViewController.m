//
//  FKViewController.m
//  瀑布流
//
//  Created by FrankChen on 15-3-13.
//  Copyright (c) 2015年 diaozhatian. All rights reserved.
//

#import "FKViewController.h"
#import "FKWaterflowView.h"
#import "FKWaterflowViewCell.h"

@interface FKViewController () <FKWaterflowViewDataSource, FKWaterflowViewDelegate>

@end

@implementation FKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	FKWaterflowView *waterflowView = [[FKWaterflowView alloc] init];
    waterflowView.frame = self.view.bounds;
    waterflowView.dataSource = self;
    waterflowView.delegate = self;
    [self.view addSubview:waterflowView];
    
    // 刷新数据
    [waterflowView reloadData];
}

#pragma mark - 数据源方法
- (NSUInteger)numberOfCellsInWaterflowView:(FKWaterflowView *)waterflowView{
    return 50;
}
- (FKWaterflowViewCell *)waterflowView:(FKWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index{
    static NSString *ID = @"cell";
    FKWaterflowViewCell *cell = [waterflowView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[FKWaterflowViewCell alloc] init];
        cell.identifier = ID;
        cell.backgroundColor = FKRandomColor;
        
        UILabel *label = [[UILabel alloc] init];
        label.tag = 10;
        label.frame = CGRectMake(0, 0, 50, 20);
        [cell addSubview:label];
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:10];
    label.text = [NSString stringWithFormat:@"%d", index];
    
    // 打印一下，测试缓存是否有效
    NSLog(@"%d %p", index, cell);
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)waterflowView:(FKWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index{
    switch (index % 3) {
        case 0: return 70;
        case 1: return 100;
        case 2: return 90;
        default: return  110;
    }
}

- (CGFloat)waterflowView:(FKWaterflowView *)waterflowView marginForType:(FKWaterflowViewMarginType)type{
    switch (type) {
        case FKWaterflowViewMarginTypeTop:            return 30;
        case FKWaterflowViewMarginTypeBottom:            return 50;
        case FKWaterflowViewMarginTypeLeft:            return 10;
        case FKWaterflowViewMarginTypeRight:            return 10;
        case FKWaterflowViewMarginTypeColumn:            return 10;
        default: return 5;
    }
}

- (void)waterflowView:(FKWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index{
    NSLog(@"点击了第%d个cell",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
