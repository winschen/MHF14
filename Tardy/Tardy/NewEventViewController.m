//
//  NewEventViewController.m
//  Tardy
//
//  Created by apple on 9/6/14.
//  Copyright (c) 2014 Apple Test. All rights reserved.
//

#import "NewEventViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Event.h"

@interface NewEventViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"View Did Load");
    
    //[self fetchUpcomingEvents];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchUpcomingEvents];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSLog(@"Number of rows in section: %lu", [self.allEvents count]);
    return [self.facebookEvents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSLog(@"cellForRowAtIndexPath");
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    Event *currentEvent = [self parseEvent:[self.facebookEvents objectAtIndex:indexPath.row]];
    cell.textLabel.text = currentEvent.name;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    //Optionally for time zone converstions
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
    
    NSString *stringFromDate = [formatter stringFromDate:currentEvent.date];
    
    cell.detailTextLabel.text = stringFromDate;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Events

- (void) fetchUpcomingEvents {
    // Server call to facebook
    // Set self.allEvents
    
    //NSMutableArray *facebookEvents = [[NSMutableArray alloc] init];
    
    /* make the API call */
    //Event *nextEvent = [[Event alloc] init];
    [FBRequestConnection startWithGraphPath:@"/me/events"
                                 parameters:nil
                                 HTTPMethod:@"GET"
                          completionHandler:^(
                                              FBRequestConnection *connection,
                                              id result,
                                              NSError *error
                                              ) {
                              /* handle the result */
                              if (!error) {
                                  //NSLog(@"user events: %@", result);
                                  self.facebookEvents = result[@"data"];
                              }
                              else {
                                  //Do something for errors
                              }
                              NSLog(@"self.facebookEvents size: %lu", [self.facebookEvents count]);
                              for (id element in self.facebookEvents) {
                                  //NSLog(@"%@", element[@"name"]);
//                                  Event *nextEvent = [[Event alloc] init];
                                  Event *nextEvent = [self parseEvent:element];
                                  [self.allEvents addObject:nextEvent];
                                  //NSLog(@"name: %@", nextEvent.name);
                                  //NSLog(@"date: %@", nextEvent.date);
                              }
                              //[self viewDidLoad];
                              NSLog(@"self.allEvents size: %lu", [self.allEvents count]);
                              [self.myTable reloadData];
                          }];
    
//    NSLog(@"self.allEvents size: %lu", [self.allEvents count]);
//    for (id element in self.allEvents) {
//        NSLog(@"%@", element[@"name"]);
//    }
    
    
//    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
//        if (!error) {
//            // Success! Include your code to handle the results here
//            NSLog(@"user info: %@", result);
//        } else {
//            // An error occurred, we need to handle the error
//            // See: https://developers.facebook.com/docs/ios/errors
//        }
//    }];
    
}

- (Event *)parseEvent:(id)serverEvent {
    Event *current = [[Event alloc] init];
    current.name = serverEvent[@"name"];
    current.date = serverEvent[@"start_time"];
    //NSLog(@"date: %@", current.date);
    return current;
}

@end
