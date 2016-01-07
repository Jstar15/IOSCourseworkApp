//
//  MasterViewController.m
//  CW3
//  Created by jordan on 26/10/2014.
//

#import "MasterViewController.h"
#import "SimpleTableViewController.h"
#import "WebViewController.h"

@interface MasterViewController () {

}
@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)schedulebtn:(id)sender {
    SimpleTableViewController *simpletableviewcontroller = [[SimpleTableViewController alloc] initWithNibName:@"SimpleTableViewController" bundle:nil];

    [self presentViewController: simpletableviewcontroller
                       animated: YES completion: nil];
}

- (IBAction)vlebtn:(id)sender {
    WebViewController *simpletableviewcontroller = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    simpletableviewcontroller.webpage = @"http://vlebb.leeds.ac.uk";
    [self presentViewController: simpletableviewcontroller
                       animated: YES completion: nil];
}

- (IBAction)portalbtn:(id)sender {
    WebViewController *simpletableviewcontroller = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    simpletableviewcontroller.webpage = @"http://portal.leeds.ac.uk";
    [self presentViewController: simpletableviewcontroller
                       animated: YES completion: nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return NO;
}






@end
