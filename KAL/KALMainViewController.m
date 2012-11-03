//
//  KALMainViewController.m
//  KAL
//
//  Created by Jinyoung Kim on 10/28/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import "KALMainViewController.h"
#import "KALTodayViewController.h"
#import "KALTomorrowViewController.h"

@interface KALMainViewController ()

@property (nonatomic, strong) KALTodayViewController *todayViewController;
@property (nonatomic, strong) KALTomorrowViewController *tomorrowViewController;

@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;

@end

@implementation KALMainViewController

#pragma mark - Init, view lifecycle, & memory warning

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self.scrollView setPagingEnabled:YES];
	[self.scrollView setScrollEnabled:YES];
	[self.scrollView setShowsHorizontalScrollIndicator:NO];
	[self.scrollView setShowsVerticalScrollIndicator:NO];
	[self.scrollView setDelegate:self];

    [self.headerScrollView setPagingEnabled:YES];
	[self.headerScrollView setScrollEnabled:YES];
	[self.headerScrollView setShowsHorizontalScrollIndicator:NO];
	[self.headerScrollView setShowsVerticalScrollIndicator:NO];

    self.todayViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TodayPage"];
    self.tomorrowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TomorrowPage"];
    self.todayViewController.delegate = self;
    self.tomorrowViewController.delegate = self;

    [self addChildViewController:self.todayViewController];
    [self addChildViewController:self.tomorrowViewController];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
    CGRect frame = self.scrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    self.todayViewController.view.frame = frame;
    [self.scrollView addSubview:self.todayViewController.view];

    frame = self.scrollView.frame;
    frame.origin.x = frame.size.width;
    frame.origin.y = 0;
    self.tomorrowViewController.view.frame = frame;
    [self.scrollView addSubview:self.tomorrowViewController.view];

	self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
    
    frame = self.headerScrollView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    UIImageView *todayHeaderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"today"]];
    todayHeaderImageView.frame = frame;
    [self.headerScrollView addSubview:todayHeaderImageView];

    frame = self.headerScrollView.frame;
    frame.origin.x = frame.size.width;
    frame.origin.y = 0;
    UIImageView *tomorrowHeaderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tomorrow"]];
    tomorrowHeaderImageView.frame = frame;
    [self.headerScrollView addSubview:tomorrowHeaderImageView];

    self.headerScrollView.contentSize = CGSizeMake(self.headerScrollView.frame.size.width * 2, self.headerScrollView.frame.size.height);
    
	self.pageControl.currentPage = 0;
	self.page = 0;
	[self.pageControl setNumberOfPages:self.childViewControllers.count];
	
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewWillAppear:animated];
	}
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	if ([self.childViewControllers count]) {
		UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
		if (viewController.view.superview != nil) {
			[viewController viewDidAppear:animated];
		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	if ([self.childViewControllers count]) {
		UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
		if (viewController.view.superview != nil) {
			[viewController viewWillDisappear:animated];
		}
	}
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewDidDisappear:animated];
	}
	[super viewDidDisappear:animated];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.page];
	UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	[oldViewController viewDidDisappear:YES];
	[newViewController viewDidAppear:YES];
	
	self.page = self.pageControl.currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (self.pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    CGFloat pageWidth = self.scrollView.frame.size.width;
    self.page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    // Switch the indicator when more than 50% of the previous/next page is visible
	if (self.pageControl.currentPage != self.page) {
		UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
		UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.page];
		[oldViewController viewWillDisappear:YES];
		[newViewController viewWillAppear:YES];
		self.pageControl.currentPage = self.page;
		[oldViewController viewDidDisappear:YES];
		[newViewController viewDidAppear:YES];
	}
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControlUsed = NO;
}

#pragma mark - KALChangeHeaderDelegate

- (void)pageChanged {
    CGRect frame = self.headerScrollView.frame;
    frame.origin.x = frame.size.width * self.page;
    frame.origin.y = 0;
	[self.headerScrollView scrollRectToVisible:frame animated:NO];
}

#pragma mark - Other

- (IBAction)changePage:(id)sender {
    self.page = ((UIPageControl *)sender).currentPage;
	
	// update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.page;
    frame.origin.y = 0;
    
	UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.page];
	UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	[oldViewController viewWillDisappear:YES];
	[newViewController viewWillAppear:YES];
	
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    self.pageControlUsed = YES;
}

- (void)viewDidUnload {
    [self setHeaderScrollView:nil];
    [super viewDidUnload];
}
@end
