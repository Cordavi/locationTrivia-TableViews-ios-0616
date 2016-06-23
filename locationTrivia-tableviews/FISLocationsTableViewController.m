//
//  FISLocationsTableTableViewController.m
//  locationTrivia-tableviews
//
//  Created by Michael Amundsen on 6/23/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import "FISLocationsTableViewController.h"
#import "FISTriviaTableViewController.h"
#import "FISLocation.h"

@interface FISLocationsTableViewController ()
@end

@implementation FISLocationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.accessibilityLabel = @"Locations Table";
    self.tableView.accessibilityIdentifier = @"Locations Table";
    
    
    
    FISLocation *location1 = [[FISLocation alloc] initWithName:@"The Empire State Building"
                                                      latitude:40.7484
                                                     longitude:-73.9857];
    
    FISTrivium *trivia1A = [[FISTrivium alloc] initWithContent:@"1,454 Feet Tall" likes:4];
    FISTrivium *trivia1B = [[FISTrivium alloc] initWithContent:@"Cost $24,718,000 to build" likes:2];
    
    [location1.trivia addObjectsFromArray:@[trivia1A, trivia1B]];
    
    FISLocation *location2 = [[FISLocation alloc] initWithName:@"Bowling Green"
                                                      latitude:41.3739
                                                     longitude:-83.6508];
    
    FISTrivium *trivia2A = [[FISTrivium alloc] initWithContent:@"NYC's oldest park" likes:8];
    FISTrivium *trivia2B = [[FISTrivium alloc] initWithContent:@"Made a park in 1733" likes:2];
    FISTrivium *trivia2C = [[FISTrivium alloc] initWithContent:@"Charging Bull was created in 1989" likes:0];
    
    
    [location2.trivia addObjectsFromArray:@[trivia2A, trivia2B, trivia2C]];
    
    FISLocation *location3 = [[FISLocation alloc] initWithName:@"Statue Of Liberty"
                                                      latitude:40.6892
                                                     longitude:74.0444];
    FISTrivium *trivia3A = [[FISTrivium alloc] initWithContent:@"Gift from the french" likes:6];
    
    [location3.trivia addObjectsFromArray:@[trivia3A]];
    
    self.locationsDict = @{location1.name: @[trivia1A, trivia1B],
                           location2.name: @[trivia2A, trivia2B, trivia2C],
                           location3.name: @[trivia3A]
                           };
    
    self.locations = [[self.locationsDict allKeys] mutableCopy];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.locations count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.locations objectAtIndex:section];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionTitle = [self.locations objectAtIndex:section];
    NSArray *sectionTrivia = [self.locationsDict objectForKey:sectionTitle];
    return [sectionTrivia count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TriviaLocation" forIndexPath:indexPath];
    
    //FISLocation *currentRowLocation = self.locations[indexPath.row];
    NSString *sectionTitle = [self.locations objectAtIndex:indexPath.section];
    NSArray *sectionTrivia = [self.locationsDict objectForKey:sectionTitle];
    FISTrivium *currentRowTrivia = [sectionTrivia objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentRowTrivia.content;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", [currentRowLocation.trivia count]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FISTriviaTableViewController *triviaInLocation = (FISTriviaTableViewController *)segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    triviaInLocation.triviaFromLocation = (FISLocation *)self.locations[indexPath.row];
}

- (IBAction)editTapped:(id)sender {
    [self setEditing:YES animated:YES];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *stringToMove = [self.locations objectAtIndex:sourceIndexPath.row];
    [self.locations removeObjectAtIndex:sourceIndexPath.row];
    [self.locations insertObject:stringToMove atIndex:destinationIndexPath.row];
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

@end
