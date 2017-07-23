//
//  ViewController.h
//  24GameChecker
//
//  Created by IceApinan on 9/6/13.
//  Copyright (c) 2013 IceApinan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *FirstNumber;
    IBOutlet UITextField *SecondNumber;
    IBOutlet UITextField *ThirdNumber;
    IBOutlet UITextField *FourthNumber;
    IBOutlet UILabel *ResultLabel;
}
-(IBAction)GoButtonClicked:(id)sender;
- (IBAction)ClearClicked:(id)sender;

@end
