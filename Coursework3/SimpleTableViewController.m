//
//  AppDelegate.h
//  CW2
//  Created by jordan on 18/10/2014.
//

#import "SimpleTableViewController.h"
#import "SimpleTableCell.h"
#import "Database.h"
#import "AppDelegate.h"

@interface SimpleTableViewController ()
@property (nonatomic, strong) Database *dbManager;
@end

@implementation SimpleTableViewController{
    int count;
    int isdelete;
    int retry;
    NSMutableArray *itemsfordatabase;
    
    NSMutableArray *module;
    NSMutableArray *dueDate;
    NSMutableArray *Coursework;
    NSMutableArray *Description;
    NSMutableArray *daysleft;
    NSMutableArray *itemid;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.dbManager = [[Database alloc] initWithDatabaseFilename:@"database.sqlite"];
    [self updateTableView];
    self.tableview.allowsMultipleSelectionDuringEditing = NO;
    
}
//update arrays with data from database
- (void)updateTableView{
    [self.dbManager readDataFromDatabase];    // Load the file content and read the data into arrays
    itemid =  [self.dbManager itemid];
    module =  [self.dbManager module];
    dueDate =  [self.dbManager duedate];
    Coursework =  [self.dbManager coursework];
    Description =  [self.dbManager description];
    //calculate and build days left array
    daysleft = [[NSMutableArray alloc]init];
    
    for (id i in dueDate){
        NSInteger tmp = [[self CountDaysTillDate:i] integerValue];
        if(tmp>0){
            [daysleft addObject:([NSString stringWithFormat:@"%i Days Left", (int)tmp])];
        }else{
            [daysleft addObject:([NSString stringWithFormat:@"%i Days Ago", abs((int)tmp)])];
        };
    }
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

//build each individual cell using SimpleTableCell.xib
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    SimpleTableCell *cell = (SimpleTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SimpleTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.modulenameLabel.text = [module objectAtIndex:indexPath.row];
    cell.dueDateLabel.text = [dueDate objectAtIndex:indexPath.row];
    cell.courseworkLabel.text = [Coursework objectAtIndex:indexPath.row];
    cell.daysleftLabel.text = [daysleft objectAtIndex:indexPath.row];
    return cell;
}

//display description if selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self outputAlert:[Description objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

// Delete item at index from database if delete is selected, then reload
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *query = [NSString stringWithFormat:
                           @"DELETE FROM schedule WHERE  id=\"%@\"",
                           [itemid objectAtIndex:indexPath.row]];
        
        [self.dbManager QueryDatabase:query];
        [self outputAlert:@"Your selected item has been deleted"];
        [self updateTableView];
        [self.tableview reloadData];
    }
}

//call uialertview for input
- (void)inputAlert : (NSString*)  desc : (NSString*) defaultm{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Add" message:desc delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Continue", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alert textFieldAtIndex:0];
    alertTextField.placeholder = defaultm;
    [alert show];
}
//call uialertview displaying output
- (void)outputAlert : (NSString*) output{
    UIAlertView *alert = [[UIAlertView alloc]
                                 initWithTitle:@"Task" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

//call uialertview displaying output
- (void)ErrorAlert : (NSString*) output{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:output
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Retry", nil];
    [alert show];
}



//given a date counts the difference between todays date and the given date
-(NSString*)CountDaysTillDate: (NSString*) targetdate{
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *startDate = [f dateFromString:[DateFormatter stringFromDate:[NSDate date]]];
    NSDate *endDate = [f dateFromString:targetdate];
    
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    
    return [NSString stringWithFormat:@"%ld",(long)[components day]];
    
}

//if the add button is selected start building array of user input
- (IBAction)addButton:(id)sender {
    count = 0;
    itemsfordatabase = [[NSMutableArray alloc]init];
    [self inputAlert:@"Please enter your module:" : @"e.g. Comp3223 = Information Vizualization"];
}

- (IBAction)homebutton:(id)sender {
    MasterViewController *masterviewcontroller = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    [self presentViewController: masterviewcontroller
                       animated: YES completion: nil];
}

//called everytime user enters input and clicks ok
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *input;
    if(buttonIndex == 1){
        if(retry!=1){
            input =  [[alertView textFieldAtIndex:0] text];
        }
        if(retry==1){
            count=1;
            retry=0;
            [itemsfordatabase removeLastObject];
            [self getUserInput:input];
        }else if([input length] == 0){
            [self getUserInput:input];
        }else{
            count++;
            [itemsfordatabase addObject: input];
            [self getUserInput:input];
       }
    }
}


- (void) getUserInput: (NSString*) input{
    if(count == 0){//seper5ate function here
        [self inputAlert:@"Please enter your module:" : @"e.g. Comp3223 = Information Vizualization"];
        
    }else if(count == 1){
        [self inputAlert:@"Please enter due date:"  : @"e.g.yyyy-mm-dd"];
        
    }else if(count == 2){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-mm-dd"];
        NSDate *date = [dateFormatter dateFromString:input];
        if(date){
            [self inputAlert:@"Please enter coursework number:" : @"e.g. CW1"];
        }else{
            retry =1;
            [self ErrorAlert:@"Must be in valid date format yyyy-mm-dd please try again"];
        }
    }else if(count == 3){
        [self inputAlert:@"e.g. The task is to create a server room" : @"Please enter description:"];
        
    }else if(count == 4){
        NSString *query = [NSString stringWithFormat:
                           @"INSERT INTO schedule (module,duedate,coursework,description) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                           itemsfordatabase[0], itemsfordatabase[1], itemsfordatabase[2], itemsfordatabase[3]];
        
        [self.dbManager QueryDatabase:query];
        [self outputAlert:@"Your item has been added to list"];
        [self updateTableView];
        [self.tableview reloadData];
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [module count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
@end

