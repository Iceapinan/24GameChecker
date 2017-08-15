//
//  MainViewController.h
//  24GameChecker
//
//  Created by IceApinan on 9/6/13.
//  Copyright (c) 2013 IceApinan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *firstNumber;
    IBOutlet UITextField *secondNumber;
    IBOutlet UITextField *thirdNumber;
    IBOutlet UITextField *fourthNumber;
    IBOutlet UILabel *resultLabel;
}
-(IBAction)goButtonTapped:(id)sender;
- (IBAction)clearButtonTapped:(id)sender;

@end
