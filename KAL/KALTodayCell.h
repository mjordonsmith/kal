//
//  KALTodayCell.h
//  KAL
//
//  Created by Jinyoung Kim on 11/3/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KALTodayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nextUpcomingLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeUntilLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeUntilUnitLabel;

@end
