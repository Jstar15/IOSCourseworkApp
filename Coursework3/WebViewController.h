//
//  WebViewController.h
//  CW3
//  Created by jordan on 26/10/2014.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController <UIWebViewDelegate>{
}
@property(nonatomic) NSString *webpage;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)homebtn:(id)sender;
- (IBAction)navbackbtn:(id)sender;
- (IBAction)navforbutton:(id)sender;

@end
