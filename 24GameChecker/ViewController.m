//
//  ViewController.m
//  24GameChecker
//
//  Created by IceApinan on 9/6/13.
//  Copyright (c) 2013 IceApinan. All rights reserved.
//
#include <stdio.h>
#include <stdlib.h>
#import "ViewController.h"
@interface ViewController () {
   NSMutableString *result;
}

@end

@implementation ViewController
#define n_cards 4
#define solve_goal 24
#define max_digit 9
typedef struct { int num, denom; } frac_t, *frac;
typedef enum { C_NUM = 0, C_ADD, C_SUB, C_MUL, C_DIV } op_type;

typedef struct expr_t *expr;
typedef struct expr_t {
    op_type op;
    expr left, right;
    int value;
} expr_t;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    FirstNumber.delegate = self;
    SecondNumber.delegate = self;
    ThirdNumber.delegate = self;
    FourthNumber.delegate = self;
    
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
- (NSMutableString *) theResult: (const char*)abcd :(int)efgh {
    if (efgh == 0) {
        [result appendString:[NSString stringWithFormat:@"%s",abcd]];
    } else {
        [result appendString:[NSString stringWithFormat:@"%d",efgh]];
    }
    if ([result length]) {
        NSLog(@"%@",result);
        ResultLabel.text = result;
    }
    return result;
}

void show_expr(expr e, op_type prec, int is_right, id self)
{
    const char * op;
    switch(e->op) {
        case C_NUM:
            [self theResult:nil : e->value]; ;
            return;
        case C_ADD:     op = " + "; break;
        case C_SUB:     op = " - "; break;
        case C_MUL:     op = " x "; break;
        case C_DIV:     op = " / "; break;
            
    }
    
    if ((e->op == prec && is_right) || e->op < prec)  [self theResult:"(" : 0];
    show_expr(e->left, e->op, 0, self);
    [self theResult:op : 0];
    show_expr(e->right, e->op, 1, self);
    if ((e->op == prec && is_right) || e->op < prec) [self theResult:")" : 0];
}

void eval_expr(expr e, frac f)
{
    frac_t left, right;
    if (e->op == C_NUM) {
        f->num = e->value;
        f->denom = 1;
        return;
    }
    eval_expr(e->left, &left);
    eval_expr(e->right, &right);
    switch (e->op) {
        case C_ADD:
            f->num = left.num * right.denom + left.denom * right.num;
            f->denom = left.denom * right.denom;
            return;
        case C_SUB:
            f->num = left.num * right.denom - left.denom * right.num;
            f->denom = left.denom * right.denom;
            return;
        case C_MUL:
            f->num = left.num * right.num;
            f->denom = left.denom * right.denom;
            return;
        case C_DIV:
            f->num = left.num * right.denom;
            f->denom = left.denom * right.num;
            return;
        default:
            fprintf(stderr, "Unknown op: %d\n", e->op);
            return;
    }
}
int solve(expr ex_in[], int len, id self)
{
    int i, j;
    expr_t node;
    expr ex[n_cards];
    frac_t final;
    
    if (len == 1) {
        eval_expr(ex_in[0], &final);
        if (final.num == final.denom * solve_goal && final.denom) {
            show_expr(ex_in[0], 0, 0, self);
            return 1;
        }
        return 0;
    }
    
    for (i = 0; i < len - 1; i++) {
        for (j = i + 1; j < len; j++)
            ex[j - 1] = ex_in[j];
        ex[i] = &node;
        for (j = i + 1; j < len; j++) {
            node.left = ex_in[i];
            node.right = ex_in[j];
            for (node.op = C_ADD; node.op <= C_DIV; node.op++)
                if (solve(ex, len - 1,self))
                    return 1;
            
            node.left = ex_in[j];
            node.right = ex_in[i];
            node.op = C_SUB;
            if (solve(ex, len - 1,self)) return 1;
            node.op = C_DIV;
            if (solve(ex, len - 1,self)) return 1;
            
            ex[j] = ex_in[j];
        }
        ex[i] = ex_in[i];
    }
    
    return 0;
}

int solve24(int n[],id self)
{
    int i;
    expr_t ex[n_cards];
    expr   e[n_cards];
    for (i = 0; i < n_cards; i++) {
        e[i] = ex + i;
        ex[i].op = C_NUM;
        ex[i].left = ex[i].right = 0;
        ex[i].value = n[i];
    }
    return solve(e, n_cards,self);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

BOOL isNumeric(NSString *code){
    
    NSScanner *ns = [NSScanner scannerWithString:code];
    float the_value;
    if ( [ns scanFloat:&the_value] )
    {
        NSLog(@"INSIDE IF");
        // do something with `the_value` if you like
    }
    else {
        NSLog(@"OUTSIDE IF");
    }
    return NO;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [string isEqualToString:@""] ||
    ([string stringByTrimmingCharactersInSet:
      [[NSCharacterSet decimalDigitCharacterSet] invertedSet]].length > 0);
}



-(IBAction)GoButtonClicked:(id)sender
{
    if (![FirstNumber.text  isEqual:@""] && ![SecondNumber.text isEqual:@""] && ![ThirdNumber.text isEqual:@""] && ![FourthNumber.text isEqual:@""]) {
        [self checkerprog];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error !" message:@"Blank is not allowed." preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            [alert.view.superview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertControllerBackgroundTapped)]];
        }];
    }
}


-(void)checkerprog {
    result = [NSMutableString stringWithFormat:@""];
    int numberone = [FirstNumber.text intValue];
    int numbertwo = [SecondNumber.text intValue];
    int numberthree = [ThirdNumber.text intValue];
    int numberfour = [FourthNumber.text intValue];
    
    int i, n[] = { numberone, numbertwo, numberthree, numberfour, 9 };
    
    for (i = 0; i < n_cards; i++) {
        printf(" %d", n[i]);
    }
    printf(":  ");
    if (solve24(n,self)) {
        printf("\n");
    } else {
        printf("No solution\n");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Sorry !" message:@"No solution for these values." preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:^{
            [alert.view.superview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alertControllerBackgroundTapped)]];
        }];
    }
        
  }
- (void)alertControllerBackgroundTapped
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (IBAction)ClearClicked:(id)sender {
    FirstNumber.text = nil;
    SecondNumber.text = nil;
    ThirdNumber.text = nil;
    FourthNumber.text = nil;
    ResultLabel.text = nil;
}




    @end
