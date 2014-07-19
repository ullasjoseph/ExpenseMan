//
//  EMExpenseListViewController.m
//  ExpenseManager
//
//  Created by Ullas Joseph on 14/07/14.
//  Copyright (c) 2014 ullasjoseph. All rights reserved.
//

#import "EMExpenseListViewController.h"
#import "EMCoredataManager.h"

@interface EMExpenseListViewController ()
@property(nonatomic, strong) NSArray *list;
@end

@implementation EMExpenseListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    _list = [EMCoredataManager getAllExpenses:_predicate];
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = nil;
    if(indexPath.row%2 == 0)
        cellId = @"ExpenseListLeftCell";
    else
        cellId = @"ExpenseListRightCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    // Configure the cell...
//    cell.textLabel.text = [_list objectAtIndex:indexPath.row];
    UIView *view = [cell viewWithTag:100];
    view.layer.cornerRadius = 5;
    
    NSManagedObject *data = [_list objectAtIndex:indexPath.row];
    ((UILabel *)[cell viewWithTag:1]).text = [data valueForKey:EXPENSE_CATEGORY];
    ((UILabel *)[cell viewWithTag:2]).text = [dateFormatter stringFromDate:[data valueForKey:EXPENSE_DATE]];
    ((UILabel *)[cell viewWithTag:3]).text = [NSString stringWithFormat:@"%.2f $",[[data valueForKey:EXPENSE_AMOUNT] doubleValue]];
    ((UILabel *)[cell viewWithTag:4]).text = [data valueForKey:EXPENSE_PAYEE];
    ((UILabel *)[cell viewWithTag:5]).text = [data valueForKey:EXPENSE_NOTE];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
//        [_list removeObjectAtIndex:indexPath.row];
//        _optionDeleteBlock([_list objectAtIndex:indexPath.row]);
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view

    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - IBActions

- (IBAction)btnCancelClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSDate *) lastMondayBeforeDate:(NSDate*)timeStamp {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps =
    [gregorian components:NSWeekdayCalendarUnit fromDate:timeStamp];
    NSInteger weekday = [comps weekday];
    weekday = weekday==1 ? 6 : weekday-2; // start with 0 on Monday rather than 1 on Sunday
    NSTimeInterval secondsSinceMondayMidnight =
    (NSUInteger) [timeStamp timeIntervalSince1970] % 60*60*24 +
    weekday * 60*60*24;
    return [timeStamp dateByAddingTimeInterval:-secondsSinceMondayMidnight];
}

-(NSDate *) nextMondayAfterDate:(NSDate*)timeStamp {
    return [[self lastMondayBeforeDate:timeStamp]
            dateByAddingTimeInterval:60*60*24*7];
}
@end
