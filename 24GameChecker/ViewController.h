//
//  ViewController.h
//  24GameChecker
//
//  Created by IceApinan on 9/6/13.
//  Copyright (c) 2013 IceApinan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *Num1;
    IBOutlet UITextField *Num2;
    IBOutlet UITextField *Num3;
    IBOutlet UITextField *Num4;
    IBOutlet UILabel *resultlabel;
}

-(IBAction)Gobuttonclick:(id)sender;
- (IBAction)ClearClicked:(id)sender;

@end
