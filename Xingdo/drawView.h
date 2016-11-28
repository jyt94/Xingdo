

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "AppDelegate.h"

@interface drawView : UIView<UIAlertViewDelegate>{
    int qarray[30],parray[30];
}
@property (assign, nonatomic) CGPoint firstTouchLocation;
@property (assign, nonatomic) CGPoint lastTouchcLocation;
@property (assign,nonatomic) BOOL vertical;
@property (assign,nonatomic) CGFloat width,height,step;
@property (assign,nonatomic) CGFloat pointsize,linewidth;
@property (assign,nonatomic) int qsize,psize,gameid,score;
@property (assign,nonatomic) ViewController* mycontroller;
@property (assign,nonatomic) AppDelegate* mydelegate;

-(void)rollback;
-(void)switchdir;
-(bool)finishjudge;
@end
