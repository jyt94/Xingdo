

#import "selectgame.h"

@implementation selectgame

-(void)viewDidLoad{
    [super viewDidLoad];
    _flag = 0;
}

- (IBAction)release:(id)sender {
    if(_flag == 1){
        UIButton* buttons[6]={
            _first,_second,_third,_fourth,_fifth,_sixth
        };
        for(int i=0; i<6; i++)
            [buttons[i] setHidden:true];
        _flag = 0;
    }
    else
        [self.view removeFromSuperview];
}

- (IBAction)dirselected:(id)sender {
    UIButton* btn = (UIButton*) sender;
    _dir = (int)btn.tag;
    NSLog(@"%d",_dir);
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    UIButton* buttons[6]={
        _first,_second,_third,_fourth,_fifth,_sixth
    };
    UIImage* images[6]={
        [UIImage imageNamed:@"first.png"],
        [UIImage imageNamed:@"second.png"],
        [UIImage imageNamed:@"third.png"],
        [UIImage imageNamed:@"four.png"],
        [UIImage imageNamed:@"fifthh.png"],
        [UIImage imageNamed:@"sixth.png"],
    };
    for(int i=0; i<6; i++){
        if(delegate.score[(_dir-1)*6+i-1] < 0 && i>0){
            [buttons[i] setAlpha:1.0f];
            [buttons[i] setImage:[UIImage imageNamed:@"lock.png"] forState:UIControlStateNormal];
        }
        else{
            [buttons[i] setImage:images[i] forState:UIControlStateNormal];
            if(delegate.score[(_dir-1)*6+i] > 0)
                [buttons[i] setAlpha:0.6f];
            else
                [buttons[i] setAlpha:1.0f];
        }
    }
    for(int i=0;i<6;i++)
        [buttons[i] setHidden:false];
    _flag = 1;
}

- (IBAction)levelselected:(id)sender {
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    UIButton* btn = (UIButton*) sender;
    _level = (int)btn.tag-5;
    NSLog(@"%d",_level);
    UIButton* buttons[6]={
        _first,_second,_third,_fourth,_fifth,_sixth
    };
    
    if(delegate.score[(_dir-1)*6+_level-1] < 0 && _level>0)
        return;
    for(int i=0; i<6; i++)
        [buttons[i] setHidden:true];
    _flag = 0;
    
    delegate.gameindex = (_dir-1)*6+_level;
    self.viewcontroller = [self.storyboard
                         instantiateViewControllerWithIdentifier:@"viewcontrol"];
    [self.view insertSubview:self.viewcontroller.view aboveSubview:self.view];
}
@end
