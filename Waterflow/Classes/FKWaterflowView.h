//
//  FKWaterflowView.h
//  瀑布流
//
//  Created by FrankChen on 15-3-13.
//  Copyright (c) 2015年 diaozhatian. All rights reserved.
// 使用瀑布流形式展示内容的控件

#import <UIKit/UIKit.h>

typedef enum {
    FKWaterflowViewMarginTypeTop,
    FKWaterflowViewMarginTypeBottom,
    FKWaterflowViewMarginTypeLeft,
    FKWaterflowViewMarginTypeRight,
    FKWaterflowViewMarginTypeColumn,
    FKWaterflowViewMarginTypeRow,
} FKWaterflowViewMarginType;

@class FKWaterflowView, FKWaterflowViewCell;

/**
 *  数据源方法
 */
@protocol FKWaterflowViewDataSource <NSObject>
@required // 默认的
/**
 *  一个有多少个数据
 */
- (NSUInteger)numberOfCellsInWaterflowView:(FKWaterflowView *)waterflowView;
/**
 *  返回index位置对应的cell
 */
- (FKWaterflowViewCell *)waterflowView: (FKWaterflowView *)waterflowView cellAtIndex:(NSUInteger)index;

@optional
/**
 *  一共有多少列
 */
- (NSUInteger)numberOfColumnsInWaterflowView:(FKWaterflowView *)waterflowView;
@end

/**
 *  代理方法
 */
@protocol FKWaterflowViewDelegate <UIScrollViewDelegate>
@optional
/**
 *  第index位置cell对应的高度
 */
- (CGFloat)waterflowView:(FKWaterflowView *)waterflowView heightAtIndex:(NSUInteger)index;
/**
 *  选中第index位置的cell
 */
- (void)waterflowView:(FKWaterflowView *)waterflowView didSelectAtIndex:(NSUInteger)index;
/**
 *  返回间距
 */
- (CGFloat)waterflowView:(FKWaterflowView *)waterflowView marginForType:(FKWaterflowViewMarginType)type;
@end

/**
 *  瀑布流控件
 */
@interface FKWaterflowView : UIScrollView
/**
 *  数据源
 */
@property (nonatomic, weak) id<FKWaterflowViewDataSource> dataSource;
/**
 *  代理
 */
@property (nonatomic, weak) id<FKWaterflowViewDelegate> delegate;
/**
 *  刷新数据（只要调用这个方法，会重新向数据源和代理发送请求，请求数据）
 */
- (void)reloadData;
/**
 *  cell的宽度
 */
- (CGFloat)cellWidth;
/**
 *  根据标识取缓存池查找可循环利用的cell
 */
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
@end
