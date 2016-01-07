//
//  SimpleTableCell.m
//  CW3
//  Created by jordan on 18/10/2014.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell
@synthesize modulenameLabel = _modulenameLabel;
@synthesize dueDateLabel = _dueDateLabel;
@synthesize courseworkLabel = _courseworkLabel;
@synthesize daysleftLabel = _daysleftLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

@end
