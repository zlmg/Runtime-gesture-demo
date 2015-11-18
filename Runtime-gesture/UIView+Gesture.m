//
//  UIView+Gesture.m
//  Runtime-gesture
//
//  Created by zlmg on 18/5/15.
//  Copyright (c) 2015 com.zlmg. All rights reserved.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>

#define kActionHandlerTapGestureKey "ActionHandlerTapGestureKey"
#define kActionHandlerTapBlockKey "kActionHandlerTapBlockKey"
#define kActionHandlerTapStateKey "kActionHandlerTapStateKey"

#define kActionHandlerLongPressGestureKey "ActionHandlerLongPressGestureKey"
#define kActionHandlerLongPressBlockKey "kActionHandlerLongPressBlockKey"
#define kActionHandlerLongPressStateKey "kActionHandlerLongPressStateKey"

#define kActionHandlerSwipeGestureKey "ActionHandlerSwipeGestureKey"
#define kActionHandlerSwipeBlockKey "kActionHandlerSwipeBlockKey"
#define kActionHandlerSwipeStateKey "kActionHandlerSwipeStateKey"

#define kActionHandlerPanGestureKey "ActionHandlerPanGestureKey"
#define kActionHandlerPanBlockKey "kActionHandlerPanBlockKey"
#define kActionHandlerPanStateKey "kActionHandlerPanStateKey"

#define kActionHandlerPinchGestureKey "ActionHandlerPinchGestureKey"
#define kActionHandlerPinchBlockKey "kActionHandlerPinchBlockKey"
#define kActionHandlerPinchStateKey "kActionHandlerPinchStateKey"

#define kActionHandlerRotationGestureKey "ActionHandlerRotationGestureKey"
#define kActionHandlerRotationBlockKey "kActionHandlerRotationBlockKey"
#define kActionHandlerRotationStateKey "kActionHandlerRotationStateKey"


@implementation UIView (Gesture)

//点击手势
-(void)setTapActionWithNumberOfTaps:(NSInteger)number block:(void (^)(UITapGestureRecognizer *))block
{
    self.userInteractionEnabled = YES;//设置用户交互为可用
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self,&kActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        gesture.numberOfTapsRequired = number;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^actionBlock)(UITapGestureRecognizer * ges) = objc_getAssociatedObject(self, kActionHandlerTapBlockKey);
        if (actionBlock)
        {
            actionBlock(gesture);
        }
    }
}

//长按手势
-(void)setLongPressActionWithBlock:(void (^)(UILongPressGestureRecognizer *))block
{
    [self setLongPressActionWithState:-1 block:block];
}

//长按手势
-(void)setLongPressActionWithState:(UIGestureRecognizerState)state block:(void (^)(UILongPressGestureRecognizer *))block
{
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, kActionHandlerLongPressGestureKey);
    if (!gesture)
    {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    NSNumber *stateNum = nil;
    if (state >= 0) {
        stateNum = [NSNumber numberWithInteger:state];
    }
    objc_setAssociatedObject(self, kActionHandlerLongPressStateKey, stateNum, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)handleActionForLongPressGesture:(UILongPressGestureRecognizer *)gesture
{
    NSNumber *numState = objc_getAssociatedObject(self, kActionHandlerLongPressStateKey);
    if (!numState || gesture.state == (UIGestureRecognizerState)[numState integerValue])
    {
        void(^actionBlock)(UILongPressGestureRecognizer * ges) = objc_getAssociatedObject(self, kActionHandlerLongPressBlockKey);
        if (actionBlock)
        {
            actionBlock(gesture);
        }
    }
}

//滑动手势
-(void)setSwipeActionWithBlock:(void (^)(UISwipeGestureRecognizer *))block
{
    [self setSwipeActionWithState:-1 block:block];
}

//滑动手势
-(void)setSwipeActionWithState:(UIGestureRecognizerState)state block:(void (^)(UISwipeGestureRecognizer *))block
{
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *gesture = objc_getAssociatedObject(self, kActionHandlerSwipeGestureKey);
    if (!gesture)
    {
        gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForSwipeGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, kActionHandlerSwipeGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    NSNumber *stateNum = nil;
    if (state >= 0) {
        stateNum = [NSNumber numberWithInteger:state];
    }
    objc_setAssociatedObject(self, kActionHandlerSwipeStateKey, stateNum, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, kActionHandlerSwipeBlockKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)handleActionForSwipeGesture:(UISwipeGestureRecognizer *)gesture
{
    NSNumber *numState = objc_getAssociatedObject(self, kActionHandlerSwipeStateKey);
    if (!numState || gesture.state == (UIGestureRecognizerState)[numState integerValue])
    {
        void(^actionBlock)(UISwipeGestureRecognizer * ges) = objc_getAssociatedObject(self, kActionHandlerSwipeBlockKey);
        if (actionBlock)
        {
            actionBlock(gesture);
        }
    }
}

//拖动手势
-(void)setPanActionWithBlock:(void (^)(UIPanGestureRecognizer *))block
{
    [self setPanActionWithState:-1 block:block];
}

//拖动手势
-(void)setPanActionWithState:(UIGestureRecognizerState)state block:(void (^)(UIPanGestureRecognizer *))block
{
    self.panBlock = block;
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, kActionHandlerPanGestureKey);
    if (!gesture)
    {
        gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForPanGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, kActionHandlerPanGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    NSNumber *stateNum = nil;
    if (state >= 0) {
        stateNum = [NSNumber numberWithInteger:state];
    }
    objc_setAssociatedObject(self, kActionHandlerPanStateKey, stateNum, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, kActionHandlerPanBlockKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)handleActionForPanGesture:(UIPanGestureRecognizer *)gesture
{
    NSNumber *numState = objc_getAssociatedObject(self, kActionHandlerPanStateKey);
    if (!numState || gesture.state == (UIGestureRecognizerState)[numState integerValue])
    {
        if (self.panBlock) {
            self.panBlock(gesture);
        }
    }
}

//捏合手势
-(void)setPinchActionWithBlock:(void (^)(UIPinchGestureRecognizer *))block
{
    [self setPinchActionWithState:-1 block:block];
}

//捏合手势
-(void)setPinchActionWithState:(UIGestureRecognizerState)state block:(void (^)(UIPinchGestureRecognizer *))block
{
    self.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *gesture = objc_getAssociatedObject(self, kActionHandlerPinchGestureKey);
    if (!gesture)
    {
        gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForPinchGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, kActionHandlerPinchGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    NSNumber *stateNum = nil;
    if (state >= 0) {
        stateNum = [NSNumber numberWithInteger:state];
    }
    objc_setAssociatedObject(self, kActionHandlerPinchStateKey, stateNum, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, kActionHandlerPinchBlockKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)handleActionForPinchGesture:(UIPinchGestureRecognizer *)gesture
{
    NSNumber *numState = objc_getAssociatedObject(self, kActionHandlerPinchStateKey);
    if (!numState || gesture.state == (UIGestureRecognizerState)[numState integerValue])
    {
        void(^actionBlock)(UIPinchGestureRecognizer * ges) = objc_getAssociatedObject(self, kActionHandlerPinchBlockKey);
        if (actionBlock)
        {
            actionBlock(gesture);
        }
    }
}

//旋转手势
-(void)setRotationActionWithBlock:(void (^)(UIRotationGestureRecognizer *))block
{
    [self setRotationActionWithState:-1 block:block];
}

//旋转手势
-(void)setRotationActionWithState:(UIGestureRecognizerState)state block:(void (^)(UIRotationGestureRecognizer *))block
{
    self.userInteractionEnabled = YES;
    UIRotationGestureRecognizer *gesture = objc_getAssociatedObject(self, kActionHandlerRotationGestureKey);
    if (!gesture)
    {
        gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForRotationGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, kActionHandlerRotationGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    NSNumber *stateNum = nil;
    if (state >= 0) {
        stateNum = [NSNumber numberWithInteger:state];
    }
    objc_setAssociatedObject(self, kActionHandlerRotationStateKey, stateNum, OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, kActionHandlerRotationBlockKey, block, OBJC_ASSOCIATION_COPY);
}

-(void)handleActionForRotationGesture:(UIRotationGestureRecognizer *)gesture{
    NSNumber *numState = objc_getAssociatedObject(self, kActionHandlerRotationStateKey);
    if (!numState || gesture.state == (UIGestureRecognizerState)[numState integerValue])
    {
        NSLog(@"state:%ld",gesture.state);
        void(^actionBlock)(UIRotationGestureRecognizer * ges) = objc_getAssociatedObject(self, kActionHandlerRotationBlockKey);
        if (actionBlock)
        {
            actionBlock(gesture);
        }
    }
}

#pragma mark - Properties
-(PanBlock)panBlock
{
    return objc_getAssociatedObject(self, kActionHandlerPanBlockKey);
}

-(void)setPanBlock:(PanBlock)block
{
    objc_setAssociatedObject(self, kActionHandlerPanBlockKey, block, OBJC_ASSOCIATION_COPY);
}

@end
