///
//  SimpleTableCell.h
//  CW3
//  Created by jordan on 18/10/2014.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *modulenameLabel;
@property (nonatomic, weak) IBOutlet UILabel *courseworkLabel;
@property (nonatomic, weak) IBOutlet UILabel *dueDateLabel;
@property (nonatomic, weak) IBOutlet UILabel *daysleftLabel;

@end
