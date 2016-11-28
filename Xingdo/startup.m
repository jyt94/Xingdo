

#import "startup.h"

@implementation startup

-(void)viewDidLoad{
    [super viewDidLoad];
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    delegate.score = malloc(25* sizeof(int));
    for(int i=0; i<25; i++)
        delegate.score[i] = -1;
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSData *testdata = [defaults dataForKey:@"myscore"];
    
    if(testdata == NULL){
        NSData *scoredata =   [[NSData alloc]initWithBytes:delegate.score length:25*sizeof(int)];
        [defaults setObject:scoredata forKey:@"myscore"];
    }
    else{
        int* scoreloaded = (int*)[testdata bytes];
        for(int i=0;i<25;i++)
            delegate.score[i]=scoreloaded[i];
        NSLog(@"score loaded %d %d",delegate.score[0],delegate.score[9]);
    }
}

- (IBAction)jumptoselect:(UIButton *)sender {
    self.gameselector = [self.storyboard
                         instantiateViewControllerWithIdentifier:@"gameselect"];
    [self.view insertSubview:self.gameselector.view aboveSubview:self.view];
}

- (IBAction)scoreshow:(id)sender {
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    int* score = delegate.score;
    NSString * dir[4]={[NSString stringWithFormat:@"%@\n",NSLocalizedString(@"north",nil)],
        [NSString stringWithFormat:@"%@\n",NSLocalizedString(@"south",nil)],
        [NSString stringWithFormat:@"%@\n",NSLocalizedString(@"west",nil)],
        [NSString stringWithFormat:@"%@\n",NSLocalizedString(@"east",nil)]};
    NSString* msg = @"";

    for(int i=0; i<4; i++){
        msg = [msg stringByAppendingString:dir[i]] ;
        for(int j=0; j<6;j++){
            if(score[i*6+j]<0)
                msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%@%d: -\n",NSLocalizedString(@"level",nil),j+1]];
            else
               msg = [msg stringByAppendingString:[NSString stringWithFormat:@"%@%d: %d\n",NSLocalizedString(@"level",nil),j+1,score[i*6+j]]];
        }
    }
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"beststeps",nil)
                          message:msg
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"feelok",nil)
                          otherButtonTitles:NSLocalizedString(@"clearscore",nil),
                          nil];
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString: NSLocalizedString(@"clearscore",nil)]){
        UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"warning",nil)
                          message:NSLocalizedString(@"confirmclear",nil)
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"nonono",nil)
                          otherButtonTitles:NSLocalizedString(@"yes",nil),
                          nil];
        [alert show];
    }
    
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString: NSLocalizedString(@"yes",nil)]){
        NSLog(@"clean score!");
        AppDelegate* delegate = [UIApplication sharedApplication].delegate;
        int* score = delegate.score;
        for(int i=0;i<24;i++)
            score[i]=-1;
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSData *scoredata =   [[NSData alloc]initWithBytes:delegate.score length:25*sizeof(int)];
        [defaults setObject:scoredata forKey:@"myscore"];
        [defaults synchronize];
    }
}


- (IBAction)rulestate:(id)sender {
    /*
    NSString* msg = @"对于给定的折现段\n 从起点出发\n 依顺序做出与各线段的垂线段\n 最终的垂线段与折现段的终点重合\n 即获得胜利";
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"游戏说明"
                          message:msg
                          delegate:self
                          cancelButtonTitle:@"好"
                          otherButtonTitles:nil, nil];
    [alert show];*/
    self.explanation = [self.storyboard
                         instantiateViewControllerWithIdentifier:@"hi"];
    [self.view insertSubview:self.explanation.view aboveSubview:self.view];
}

- (IBAction)aboutinfo:(id)sender {
    NSString* msg = NSLocalizedString(@"infocontent",nil);
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"aboutinfo",nil)
                          message:msg
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"feelok",nil)
                          otherButtonTitles:nil, nil];
    [alert show];

}
@end
