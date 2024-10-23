//
//  ViewController.m
//  font
//
//  Created by maojj on 2024/10/23.
//

#import "ViewController.h"
#import "CustomTextView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSString *fontfamilyname in [UIFont familyNames]) {
        NSLog(@"familyName:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"  fontName:'%@'",fontName);
        }
        NSLog(@"***********");
    }
    
    
    CGRect viewFrame = CGRectMake(10, 10, 500, 500);
    CustomTextView *customTextView = [[CustomTextView alloc] initWithFrame:viewFrame];
    [self.view addSubview:customTextView];
}


@end
