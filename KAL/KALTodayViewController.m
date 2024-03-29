//
//  KALTodayViewController.m
//  KAL
//
//  Created by Jinyoung Kim on 10/20/12.
//  Copyright (c) 2012 Matthew Smith. All rights reserved.
//

#import "KALTodayViewController.h"
#import "EventKit/EKEventStore.h"
#import "EventKit/EKEvent.h"
#import "NSDate+TodayTomorrow.h"
#import "KALTodayCell.h"

@interface KALTodayViewController ()

@property (strong, nonatomic) EKEventStore *store;
@property (strong, nonatomic) NSArray *events;
@property (strong, nonatomic) NSDate *lastUpdateOfEvents;

@end

@implementation KALTodayViewController

#pragma mark - Init, view lifecycle, & memory warning

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if (self) {
        // Custom initialization
        _store = [[EKEventStore alloc] init];
        [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            if (granted) {
                _lastUpdateOfEvents = [NSDate date];
                NSArray *calendarArray = [_store calendars];
                NSPredicate *predicate = [_store predicateForEventsWithStartDate:_lastUpdateOfEvents
                                                                         endDate:[_lastUpdateOfEvents endOfToday]
                                                                       calendars:calendarArray];
                _events = [_store eventsMatchingPredicate:predicate];
            }
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    [self.delegate pageChanged];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - events

- (NSArray *)events {
    if ((nil != _events) && ([self.lastUpdateOfEvents compare:[[NSDate date] dateByAddingTimeInterval:-60.0]] == NSOrderedAscending)) {
        return _events;
    }
    
    self.lastUpdateOfEvents = [NSDate date];
    NSArray *calendarArray = [self.store calendars];
    NSPredicate *predicate = [self.store predicateForEventsWithStartDate:self.lastUpdateOfEvents
                                                             endDate:[self.lastUpdateOfEvents endOfToday]
                                                           calendars:calendarArray];
    _events = [self.store eventsMatchingPredicate:predicate];
    
    return _events;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"EventCell";
    KALTodayCell *cell = (KALTodayCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    EKEvent *event = (EKEvent *)self.events[indexPath.row];

    if (indexPath.row == 0) {
        cell.nextUpcomingLabel.text = @"Next Meeting";
    } else {
        cell.nextUpcomingLabel.text = @"Upcoming Meeting";
    }
    cell.titleLabel.text = event.title;
    cell.locationLabel.text = event.location;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"hh:mm a"];
    cell.timeLabel.text = [dateFormat stringFromDate:event.startDate];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit|NSMinuteCalendarUnit
                                               fromDate:now
                                                 toDate:event.startDate
                                                options:0];
    if (components.hour == 0) {
        cell.timeUntilLabel.text = [NSString stringWithFormat:@"%d", components.minute];
        cell.timeUntilUnitLabel.text = @"minutes until meeting";
    } else {
        float hoursUntil = components.hour + (components.minute / 60.0);
        cell.timeUntilLabel.text = [NSString stringWithFormat:@"%3.1f", hoursUntil];
        cell.timeUntilUnitLabel.text = @"hours until meeting";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
