//
//  CXImagesAnimationManage.m
//  UIImageView
//
//  Created by Zheng on 2017/3/27.
//  Copyright © 2017年 Zheng. All rights reserved.
//

#import "CXImagesAnimationManage.h"

static NSString *kKeyPath = @"contents";
static NSTimeInterval defaultTime = 1; //默认时间
static NSTimeInterval defaultCount = 1; //默认执行次数
typedef void(^AnimationBlock)();

@interface CXImagesAnimationManage() <CAAnimationDelegate>

@property (nonatomic, copy) AnimationBlock startBlock;
@property (nonatomic, copy) AnimationBlock stopBlock;
@property (nonatomic, copy) CAKeyframeAnimation *anim;

@end

@implementation CXImagesAnimationManage

+ (instancetype)manager {
    static CXImagesAnimationManage *instance = nil;
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        instance = [[CXImagesAnimationManage alloc] init];
    });
    return instance;
}

- (void)startAnimationWithDuration:(NSTimeInterval)t
                   withRepeatCount:(NSInteger)count
                        withImages:(NSArray<UIImage *> *)images
                 withAnimationView:(UIView *)view
                    withStartBlock:(void (^)(void))start
                     withStopBlock:(void (^)(void))stop {
    
    NSMutableArray *imagesArr = [NSMutableArray array];
    
    for (UIImage *img in images) {
        [imagesArr addObject:(__bridge UIImage *)img.CGImage];
    }    
    
    _startBlock = start;
    _stopBlock = stop;
    
    //设置动画属性
    self.anim.duration = t;
    self.anim.values = imagesArr;
    self.anim.repeatCount = count;
    
    [view.layer addAnimation:self.anim forKey:kKeyPath];
}

- (CAKeyframeAnimation *)anim {
    if (!_anim) {
        _anim = [CAKeyframeAnimation animation];
        _anim.keyPath = kKeyPath;
        _anim.duration = defaultTime;
        _anim.delegate = self;
        _anim.repeatCount = defaultCount;
    }
    return _anim;
}

#pragma mark CAAnimtion Delegate Mothod
- (void)animationDidStart:(CAAnimation *)anim {
    if (_startBlock != nil && _startBlock != NULL) {
        _startBlock();
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //动画结束重置属性
    _anim.duration = defaultTime;
    _anim.repeatCount = defaultCount;
    _anim.values = nil;
    
    if (_stopBlock != nil && _stopBlock != NULL) {
        _stopBlock();
    }
}


@end

