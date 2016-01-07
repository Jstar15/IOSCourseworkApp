//
//  AppDelegate.h
//  CW2
//  Created by jordan on 18/10/2014.
//

#import <UIKit/UIKit.h>

@interface SimpleTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
}

@property (nonatomic, retain) IBOutlet UITableView *tableview;

- (IBAction) addButton:(id)sender;
- (IBAction)homebutton:(id)sender;
- (void) updateTableView;
- (void) inputAlert : (NSString*) desc : (NSString*) defaultm;
- (void) outputAlert : (NSString*) output;
- (NSString*) CountDaysTillDate: (NSString*) targetdate;
- (void) getUserInput: (NSString*) input;


@end
