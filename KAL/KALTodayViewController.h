//
//  KALTodayViewController.h
//  KAL
//
//  Created by Jinyoung Kim on 10/20/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KALChangeHeaderDelegate.h"

@interface KALTodayViewController : UITableViewController

@property (nonatomic, weak) id <KALChangeHeaderDelegate> delegate;

@end
