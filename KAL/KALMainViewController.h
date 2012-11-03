//
//  KALMainViewController.h
//  KAL
//
//  Created by Jinyoung Kim on 10/28/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import <UIKit/UIKit.h>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;

@end
