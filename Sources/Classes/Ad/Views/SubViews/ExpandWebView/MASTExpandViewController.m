//
//  ExpandViewController.m
//  AdMobileSDK
//
//  Created by Constantine Mureev on 12/16/11.
//

#import "MASTExpandViewController.h"
#import "MASTUtils.h"
#import "MASTExpandView.h"

@implementation MASTExpandViewController

@synthesize adView, expandView, lockOrientation, closeButton;


#pragma mark - View lifecycle

- (id)init {
    self = [super init];
    if (self) {
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        lockOrientation = NO;
    }
    return self;
}

- (void)dealloc {
    self.closeButton = nil;
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return lockOrientation;
}

- (void)buttonsAction:(id)sender {
    if ([self.expandView isKindOfClass:[MASTExpandView class]]) {
        [(MASTExpandView*)self.expandView close];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kCloseExpandNotification" object:self.expandView];
        self.closeButton.hidden = YES;
        [self.closeButton removeFromSuperview];
        self.closeButton = nil;
    }
}

- (void)useCustomClose:(BOOL)use {
    if (!self.closeButton) {
        
        UIImage* closeImage = [MASTUtils closeImage];
        if (closeImage) {            
            self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.closeButton.frame = CGRectMake(0, 0, closeImage.size.width, closeImage.size.height);
            [self.closeButton setImage:closeImage forState:UIControlStateNormal];
            [self.closeButton addTarget:self action:@selector(buttonsAction:) forControlEvents:UIControlEventTouchUpInside];
            self.closeButton.frame = CGRectMake(self.view.frame.size.width - self.closeButton.frame.size.width - 11, 11, self.closeButton.frame.size.width, self.closeButton.frame.size.height);
            self.closeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
            [self.view addSubview:self.closeButton];
        }
    }
    
    self.closeButton.hidden = use;
}

@end
