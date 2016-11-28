

#import "ViewController.h"
#import "drawView.h"
#import "AppDelegate.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    drawView* myDrawView = (drawView*) self.view;
    myDrawView.mycontroller = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backbtn:(UIButton *)sender {
    drawView* myDrawView = (drawView*) self.view;
    if(![myDrawView finishjudge])
        [myDrawView rollback];
}

- (IBAction)resetbtn:(UIButton *)sender {
    drawView* myDrawView = (drawView*) self.view;
    if(![myDrawView finishjudge])
        [myDrawView switchdir];
}
- (IBAction)goback:(id)sender {
    [self.view removeFromSuperview];
}
@end
