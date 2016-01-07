//
//  WebViewController.m
//  CW3
//  Created by jordan on 26/10/2014.
//

#import "WebViewController.h"
#import "MasterViewController.h"

@interface WebViewController ()

@end
@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //load webpage base on the url called webpage
    NSString *urlString = _webpage;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    _webView.scalesPageToFit = YES;
    [_webView loadRequest:urlRequest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homebtn:(id)sender {
    MasterViewController *masterviewcontroller = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
    
    [self presentViewController: masterviewcontroller
                       animated: YES completion: nil];

}

//if back button is clicked go back on webview if possible
- (IBAction)navbackbtn:(id)sender {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    
}

//if forward button is clicked go forward on webview if possible
- (IBAction)navforbutton:(id)sender {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}
@end
