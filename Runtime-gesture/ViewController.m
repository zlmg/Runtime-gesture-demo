//
//  ViewController.m
//  Runtime-gesture
//
//  Created by zlmg on 18/5/15.
//  Copyright (c) 2015 com.zlmg. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Gesture.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor redColor];
    [view setRotationActionWithState:UIGestureRecognizerStateChanged block:^(UIRotationGestureRecognizer *ges) {
        CGFloat r = arc4random_uniform(255)/255.0f;
        CGFloat g = arc4random_uniform(255)/255.0f;
        CGFloat b = arc4random_uniform(255)/255.0f;
        ges.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        //NSLog(@"r:%f g:%f b:%f",r,g,b);
    }];
    
    [view setPanActionWithBlock:^(UIGestureRecognizer *ges) {
        CGFloat r = arc4random_uniform(255)/255.0f;
        CGFloat g = arc4random_uniform(255)/255.0f;
        CGFloat b = arc4random_uniform(255)/255.0f;
        ges.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        NSLog(@"pan-----r:%f g:%f b:%f",r,g,b);
    }];
    [view setLongPressActionWithBlock:^(UIGestureRecognizer *ges) {
            CGFloat r = arc4random_uniform(255)/255.0f;
            CGFloat g = arc4random_uniform(255)/255.0f;
            CGFloat b = arc4random_uniform(255)/255.0f;
            ges.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
            NSLog(@"longPress-----r:%f g:%f b:%f",r,g,b);
        }];
    [self.view addSubview:view];
    
}


@end
