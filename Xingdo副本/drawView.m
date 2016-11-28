

#import "drawView.h"

@implementation drawView

-(void)drawGame{
    [self drawfence];
    [self drawLine];
    [self drawPoint];
    [self drawText];
    NSLog(@"whew!");
    [self finishjudge];

}

-(void)drawText{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    if(delegate.score[_gameid]<0)
        [_mycontroller.bestscore setText:[NSString stringWithFormat:@"%@:-",NSLocalizedString(@"beststeps",nil)]];
    else
        [_mycontroller.bestscore setText:[NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"beststeps",nil),delegate.score[_gameid]]];
    [_mycontroller.currentscore setText:[NSString stringWithFormat:@"%@:%d",NSLocalizedString(@"currentsteps",nil),_score]];
    
    NSString* dir;
    switch(_gameid/6){
        case 0:
            dir = NSLocalizedString(@"north",nil);break;
        case 1:
            dir = NSLocalizedString(@"south",nil);break;
        case 2:
            dir = NSLocalizedString(@"west",nil);break;
        case 3:
            dir = NSLocalizedString(@"east",nil);break;
    }
    [_mycontroller.gametitle setText:[NSString stringWithFormat:@"%@ %@%d",dir,NSLocalizedString(@"level",nil),_gameid%6+1]];
    NSLog(@"set title!");
}

-(bool)finishjudge{
    if(_vertical && _qsize==_psize && parray[(_psize-1)*2]==qarray[(_qsize-1)*2] && parray[(_psize-1)*2+1]==qarray[(_qsize-1)*2+1])
    {
        /*UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                      initWithTitle:@"Are you sure?"
                                      delegate:self
                                      cancelButtonTitle:@"No Way!"
                                      destructiveButtonTitle:@"Yes, I’m Sure!"
                                      otherButtonTitles:nil];
        [actionSheet showInView:self];*/
        NSString* msg = NSLocalizedString(@"congratulation",nil);
        
        AppDelegate* delegate = [UIApplication sharedApplication].delegate;
        //check score
        if(_score < delegate.score[delegate.gameindex] ||
            delegate.score[delegate.gameindex]<0){//update
            delegate.score[delegate.gameindex]=_score;
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            NSData *scoredata =   [[NSData alloc]initWithBytes:delegate.score length:25*sizeof(int)];
            [defaults setObject:scoredata forKey:@"myscore"];
            [defaults synchronize];
            msg=NSLocalizedString(@"newrecord",nil);
        }
        UIAlertView *alert = nil;
        if(_gameid%6!=5)
            alert = [[UIAlertView alloc]
                     initWithTitle:NSLocalizedString(@"levelfinish",nil)
                     message:msg
                     delegate:self
                     cancelButtonTitle:NSLocalizedString(@"review",nil)
                     otherButtonTitles:NSLocalizedString(@"continue",nil),nil];
        else
            alert = [[UIAlertView alloc]
                     initWithTitle:NSLocalizedString(@"levelfinish",nil)
                     message:msg
                     delegate:self
                     cancelButtonTitle:NSLocalizedString(@"review",nil)
                     otherButtonTitles:NSLocalizedString(@"return",nil),nil];
        [alert show];
        NSLog(@"whewwww!");
        NSLog(@"AAAAAAAH! %d",_gameid);
        return true;
    }
    return false;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex != [alertView cancelButtonIndex]){
        if(_gameid%6==5)
            [_mycontroller goback:0];
        else{
            _gameid++;
            [self setgame:_gameid];
        }
    }
}

-(void)qdrawat:(int)index{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat realx,realy;
    realx = _width/2+(qarray[index*2]-5)*_step;
    realy = _height/2-(qarray[index*2+1]-5)*_step;
    CGContextMoveToPoint(context, realx, realy);
    
    index++;
    realx = _width/2+(qarray[index*2]-5)*_step;
    realy = _height/2-(qarray[index*2+1]-5)*_step;
    CGContextAddLineToPoint(context, realx, realy);
    
    CGContextStrokePath(context);
}

-(void)pdrawat:(int)index{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat realx,realy;
    realx = _width/2+(parray[index*2]-5)*_step;
    realy = _height/2-(parray[index*2+1]-5)*_step;
    CGContextMoveToPoint(context, realx, realy);
    
    index++;
    realx = _width/2+(parray[index*2]-5)*_step;
    realy = _height/2-(parray[index*2+1]-5)*_step;
    CGContextAddLineToPoint(context, realx, realy);
    CGContextStrokePath(context);
}

-(void)dropatx:(int)x aty:(int)y atsize:(int)sz{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat realx,realy;
    realx = _width/2+(x-5)*_step;
    realy = _height/2-(y-5)*_step;
    CGContextFillRect(context,CGRectMake(realx-sz,realy-sz,sz*2,sz*2));
    //CGContextStrokePath(context);
}



-(void)drawLine{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,_linewidth);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);

    //quiz line
    for(int i=0; i<_qsize-1; i++)
        [self qdrawat:i];
    
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    //play line
    for(int i=_psize-1; i>0; i-- )
        [self pdrawat:i-1];
    
    //High light
    if(_vertical && _psize<_qsize){
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0].CGColor);
        [self qdrawat:_psize-1];
    }
    else if(!_vertical){
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0].CGColor);
        [self qdrawat:_psize-2];
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        [self pdrawat:_psize-2];
    }
}

-(void)drawPoint{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
    for(int i=0; i<_qsize; i++){
        [self dropatx:qarray[i*2] aty:qarray[i*2+1] atsize:_pointsize];
    }
    
    for(int i=0; i<_psize; i++){
        [self dropatx:parray[i*2] aty:parray[i*2+1] atsize:_pointsize];
    }
    //High light
    if(_vertical && _psize<_qsize){
        [self dropatx:qarray[(_psize-1)*2] aty:qarray[(_psize-1)*2+1] atsize:_pointsize*1.66];
        [self dropatx:qarray[(_psize)*2] aty:qarray[(_psize)*2+1] atsize:_pointsize*1.66];
    }
    else if(!_vertical){
        [self dropatx:qarray[(_psize-1)*2] aty:qarray[(_psize-1)*2+1] atsize:_pointsize*1.66];
        [self dropatx:qarray[(_psize-2)*2] aty:qarray[(_psize-2)*2+1] atsize:_pointsize*1.66];
    }
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0].CGColor);
    [self dropatx:parray[(_psize-1)*2] aty:parray[(_psize-1)*2+1] atsize:_pointsize*1.66];
    
}

-(void)rollback{
    if(_psize==1)
        return;
    _psize--;
    _vertical=true;
    [self setNeedsDisplay];
}

-(void)switchdir{
    int temp;
    for(int i=0; i<_qsize/2;i++){
        temp = qarray[i*2];
        qarray[i*2]=qarray[(_qsize-1-i)*2];
        qarray[(_qsize-1-i)*2]=temp;
        
        temp = qarray[i*2+1];
        qarray[i*2+1]=qarray[(_qsize-1-i)*2+1];
        qarray[(_qsize-1-i)*2+1] = temp;
    }
    _psize = 1;
    parray[0]=qarray[0];
    parray[1]=qarray[1];
    _vertical = true;
    [self setNeedsDisplay];
}

-(void)addpointwithlocation:(CGPoint) location{
    CGFloat offset=0;
    CGFloat x = location.x, y = location.y;
    
    int xindex = (x-_width*0.05)/_step;
    offset = x - xindex*_step-_width*0.05;
    if(offset>0.5*_step)
        xindex++;
    
    int yindex = (y- (_height/2-_width*0.45) )/_step;
    offset = y - yindex*_step- (_height/2-_width*0.45);
    if(offset>0.5*_step)
        yindex++;
    yindex = 10 - yindex;
    
    if( (parray[(_psize-1)*2]==xindex && parray[(_psize-1)*2+1]==yindex) || xindex<0 || xindex>10 || yindex<0 || yindex>10)
        return;
    
    parray[_psize*2]=xindex;
    parray[_psize*2+1]=yindex;
    _psize++;
    
    int qdx = qarray[(_psize-2)*2]  -qarray[(_psize-1)*2];
    int qdy = qarray[(_psize-2)*2+1]-qarray[(_psize-1)*2+1];
    
    int pdx = parray[(_psize-2)*2]  -parray[(_psize-1)*2];
    int pdy = parray[(_psize-2)*2+1]-parray[(_psize-1)*2+1];
    
    if(qdx*pdx + qdy*pdy == 0)
        _vertical = true;
    else
        _vertical = false;
    _score++;
}

-(void)drawfence {
    CGRect screenrect = [[UIScreen mainScreen] bounds];
    CGSize screensize = screenrect.size;
    
    _width = screensize.width;
    _height = screensize.height;
    _linewidth = screensize.width/250;
    _pointsize = screensize.width/125;
    _step = _width*0.09;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,_linewidth/4);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    //CGContextMoveToPoint(context, 100, 100);
    //CGContextAddLineToPoint(context, 100, 200);
    
    for(int i=-5;i<=5;i++){
        //vertical
        CGContextMoveToPoint(context, _width/2+i*_step, _height/2-_width*0.45);
        CGContextAddLineToPoint(context, _width/2+i*_step, _height/2+_width*0.45);
        
        //horisontal
        CGContextMoveToPoint(context, _width*0.05, _height/2+i*_step);
        CGContextAddLineToPoint(context, _width*0.95, _height/2+i*_step);
    }
    CGContextStrokePath(context);
}

-(void) setgame:(int) gameid{
    _gameid = gameid;
    _psize = 1;
    _qsize = gamegroup[gameid][0];
    _vertical = true;
    for(int i=0; i<_qsize*2; i++){
        qarray[i]=gamegroup[gameid][i+1];
    }
    parray[0]=qarray[0];
    parray[1]=qarray[1];
    _score=0;
    _mydelegate.gameindex = gameid;
    
    [self setNeedsDisplay];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if(self = [super initWithCoder:aDecoder]){
        _vertical = true;
        _psize = 0;
        _qsize = 0;
        _mydelegate = [UIApplication sharedApplication].delegate;
        [self setgame:_mydelegate.gameindex];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawGame];
}

-(void) update{
    if(!_vertical){
        [self rollback];
        return;
    }
    if(_psize >= _qsize)
        return;
    
    [self addpointwithlocation:_lastTouchcLocation ];
}


#pragma mark - Touch Handling

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.firstTouchLocation = [touch locationInView:self];
    self.lastTouchcLocation = [touch locationInView:self];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.lastTouchcLocation = [touch locationInView:self];
    
    [self update];
    
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.lastTouchcLocation = [touch locationInView:self];
    [self setNeedsDisplay];
}
int gamegroup[25][30]={
    {5,4,9,2,7,1,5,4,4,5,8},
    {6,0,1,3,4,4,0,7,1,6,4,10,5},
    {6,5,6,1,4,2,2,5,3,3,9,8,8},
    {6,6,3,1,4,0,2,4,0,5,5,6,1},
    {6,1,8,4,9,3,7,4,5,5,9,4,6},
    {8,0,1,1,4,2,3,4,4,7,2,8,6,6,3,7,8},
    
    {5,1,4,4,8,5,4,6,9,8,5},
    {5,1,6,2,2,4,1,3,4,6,7},
    {5,2,3,3,8,9,9,10,3,7,10},
    {5,1,5,4,6,6,9,7,4,9,5},
    {5,1,5,2,4,3,7,6,5,10,6},
    {8,2,2,0,0,6,1,7,8,3,9,5,4,4,5,3,2},
    
    
    {5,2,4,5,3,6,9,8,2,4,0},
    {5,2,1,0,2,5,1,9,2,8,3},
    {5,4,4,3,2,5,4,3,5,8,4},
    {5,0,3,5,3,8,2,3,5,5,6},
    {5,4,2,8,1,9,1,4,0,6,2},
    {8,3,6,0,5,2,2,0,0,9,7,10,10,8,9,10,6},
    
    {5,0,3,6,1,0,4,4,6,8,2},
    {5,0,7,1,6,2,4,6,5,5,6},
    {6,1,7,3,2,4,5,8,3,10,4,9,7},
    {8,2,4,1,3,0,0,1,2,2,8,9,3,4,5,6,5},
    {8,3,0,2,3,5,1,3,4,7,2,8,4,1,5,2,6},
    {10,4,0,2,1,0,7,5,10,10,4,6,2,2,7,8,5,3,2,0,8},
    
    {11,0,3,6,6,6,7,0,0,1,0,6,8,7,0,0,1,6,9,7,6,8,7}
};
@end
