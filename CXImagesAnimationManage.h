//
//  CXImagesAnimationManage.h
//  UIImageView
//
//  Created by Zheng on 2017/3/27.
//  Copyright © 2017年 Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CXImagesAnimationManage : NSObject

//初始化
+ (nullable instancetype)manager;

/**
 播放一组图片,并获得播放状态

 @param t 执行时间 默认2s
 @param count 重复次数 默认1s
 @param images 图片组
 @param view 播放图片的视图
 @param start 开始
 @param stop 停止
 */
- (void)startAnimationWithDuration:(NSTimeInterval)t
                   withRepeatCount:(NSInteger)count
                        withImages:(nonnull NSArray<UIImage*> *)images
                 withAnimationView:(nonnull UIView *)view
                    withStartBlock:(nullable void(^)(void))start
                     withStopBlock:(nullable void(^)(void))stop;


@end
