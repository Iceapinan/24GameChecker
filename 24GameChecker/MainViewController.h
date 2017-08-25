//
//  MainViewController.h
//  24GameChecker
//
//  Created by IceApinan on 9/6/13.
//  Copyright (c) 2013 IceApinan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController <UITextFieldDelegate> {
    __weak IBOutlet UITextField *firstNumber;
    __weak IBOutlet UITextField *secondNumber;
    __weak IBOutlet UITextField *thirdNumber;
    __weak IBOutlet UITextField *fourthNumber;
    __weak IBOutlet UILabel *resultLabel;
    __weak IBOutlet UIButton *goButton;
    __weak IBOutlet UIButton *clearButton;
}
-(IBAction)goButtonTapped:(id)sender;
- (IBAction)clearButtonTapped:(id)sender;

@end
