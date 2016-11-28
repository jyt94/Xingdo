

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "AppDelegate.h"

@interface selectgame : UIViewController
- (IBAction)release:(id)sender;

@property (strong, nonatomic) ViewController* viewcontroller;

@property (weak, nonatomic) IBOutlet UIButton *nb;
@property (weak, nonatomic) IBOutlet UIButton *wb;
@property (weak, nonatomic) IBOutlet UIButton *sb;
@property (weak, nonatomic) IBOutlet UIButton *eb;

@property (weak, nonatomic) IBOutlet UIButton *first;
@property (weak, nonatomic) IBOutlet UIButton *second;
@property (weak, nonatomic) IBOutlet UIButton *third;
@property (weak, nonatomic) IBOutlet UIButton *fourth;
@property (weak, nonatomic) IBOutlet UIButton *fifth;
@property (weak, nonatomic) IBOutlet UIButton *sixth;



- (IBAction)dirselected:(id)sender;
- (IBAction)levelselected:(id)sender;

@property (assign,nonatomic) int dir,level,flag;

@end
