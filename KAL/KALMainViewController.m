//
//  KALMainViewController.m
//  KAL
//
//  Created by Jinyoung Kim on 10/28/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import "KALMainViewController.h"

@interface KALMainViewController ()

@end

@implementation KALMainViewController

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TodayPage"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TomorrowPage"]];
}

@end
