//
//  UIView+Gesture.h
//  Runtime-gesture
//
//  Created by zlmg on 18/5/15.
//  Copyright (c) 2015 com.zlmg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PanBlock)(UIPanGestureRecognizer *ges);

@interface UIView (Gesture)

@property (nonatomic,copy) PanBlock panBlock;

//Tap（点一下）
//LongPress（长按）
//Swipe（滑动，快速移动）
//Pan （拖移，慢速移动）
//Pinch（二指往內或往外拨动，平时经常用到的缩放）
//Rotation（旋转）

/**
* 给视图添加一个点击手势
*
* @param number 点击次数
* @param block 点击后进行的操作
*/
-(void)setTapActionWithNumberOfTaps:(NSInteger)number block:(void(^)(UITapGestureRecognizer * ges))block;

/**
 * 添加长按手势
 *
 * @param block 手势对应的操作
 */
-(void)setLongPressActionWithBlock:(void(^)(UILongPressGestureRecognizer * ges))block;

/**
 * 添加长按手势
 *
 * @param state 手势识别状态
 *
 * @param block 手势对应的操作
 */
-(void)setLongPressActionWithState:(UIGestureRecognizerState)state block:(void(^)(UILongPressGestureRecognizer * ges))block;

/**
 * 添加滑动手势
 *
 * @param block 手势对应的操作
 */
-(void)setSwipeActionWithBlock:(void(^)(UISwipeGestureRecognizer * ges))block;

/**
 * 添加滑动手势
 *
 * @param state 手势识别状态
 *
 * @param block 手势对应的操作
 */
-(void)setSwipeActionWithState:(UIGestureRecognizerState)state block:(void(^)(UISwipeGestureRecognizer * ges))block;

/**
 * 添加拖动手势
 *
 * @param block 手势对应的操作
 */
-(void)setPanActionWithBlock:(void(^)(UIPanGestureRecognizer * ges))block;


/**
 * 添加拖动手势
 *
 * @param state 手势识别状态
 *
 * @param block 手势对应的操作
 */
-(void)setPanActionWithState:(UIGestureRecognizerState)state block:(void(^)(UIPanGestureRecognizer * ges))block;

/**
 * 添加捏合手势
 *
 * @param block 手势对应的操作
 */
-(void)setPinchActionWithBlock:(void(^)(UIPinchGestureRecognizer * ges))block;

/**
 * 添加捏合手势
 *
 * @param state 手势识别状态
 *
 * @param block 手势对应的操作
 */
-(void)setPinchActionWithState:(UIGestureRecognizerState)state block:(void(^)(UIPinchGestureRecognizer * ges))block;

/**
 * 添加旋转手势
 *
 * @param block 手势对应的操作
 */
-(void)setRotationActionWithBlock:(void(^)(UIRotationGestureRecognizer * ges))block;

/**
 * 添加旋转手势
 *
 * @param state 手势识别状态
 *
 * @param block 手势对应的操作
 */
-(void)setRotationActionWithState:(UIGestureRecognizerState)state block:(void(^)(UIRotationGestureRecognizer * ges))block;

@end
