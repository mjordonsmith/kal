//
//  KALMainViewController.h
//  KAL
//
//  Created by Jinyoung Kim on 10/28/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KALChangeHeaderDelegate.h"

@interface KALMainViewController : UIViewController <UIScrollViewDelegate, KALChangeHeaderDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *headerScrollView;

- (IBAction)changePage:(id)sender;

@end
