//
//  TestViewController.h
//  MobileMouse
//
//  Created by Yu Jianjun on 9/16/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, assign) CGSize screenSize;

@property (nonatomic, assign) CGFloat desktopScale;

@end
