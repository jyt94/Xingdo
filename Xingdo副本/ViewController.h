

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)backbtn:(UIButton *)sender;
- (IBAction)resetbtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *backbutton;
@property (weak, nonatomic) IBOutlet UIButton *resetbutton;
@property (weak, nonatomic) IBOutlet UILabel *bestscore;
@property (weak, nonatomic) IBOutlet UILabel *currentscore;
@property (weak, nonatomic) IBOutlet UILabel *gametitle;

- (IBAction)goback:(id)sender;

@end

