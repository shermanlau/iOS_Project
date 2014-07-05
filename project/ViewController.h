//
//  ViewController.h
//  project
//
//  Created by abc on 7/3/2014.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PicFrame.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>{
    NSArray *data;
    NSMutableArray *imageviews;
    NSInteger index;
    BOOL pageControlUsed;
    PicFrame *pf;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollImages;
@property (weak, nonatomic) IBOutlet UILabel *intro;
@property (weak, nonatomic) IBOutlet UIPageControl *pagecontrol;
@property (weak, nonatomic) IBOutlet UIView *imagesBack;
- (IBAction)chagepage:(id)sender;

@end
