//
//  ViewController.m
//  MySafari
//
//  Created by Adam Johnson on 5/13/15.
//  Copyright (c) 2015 Adam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *goBackButton;

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.goBackButton.enabled = NO;
    [self goTo:@"http://google.com"];

}

- (void) goTo:(NSString *) text{
    NSURL *url = [NSURL URLWithString:text];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self goTo:textField.text];
    [textField resignFirstResponder];
    self.goBackButton.enabled = YES;
    NSLog(@"Return was hit");

    return YES;
}
- (IBAction)onBackButtonPressed:(id)sender {
    [self.webView goBack];
    if (self.webView.canGoBack == NO) {
        self.goBackButton.enabled = NO;
    }
}
- (IBAction)onReloadButtonPressed:(id)sender {
    [self.webView reload];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}
- (IBAction)onStopButtonLoadngPressed:(id)sender {
    [self.webView stopLoading];
}

- (IBAction)onForwardButtonPressed:(id)sender {
    if (self.webView.canGoForward == YES) {
        [self.webView goForward];
    } else {
        self.goBackButton.enabled = NO;
    }
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
}






@end
