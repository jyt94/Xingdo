 
#import "explanation.h"

@implementation explanation

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"hi");
    
    //CGRect sc = [UIScreen mainScreen].applicationFrame;
    //_myscrollview.frame = CGRectMake(0,0,sc.size.width-20, _myscrollview.frame.size.height);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage* image = [UIImage imageNamed:NSLocalizedString(@"howtoplay", nil)];
    CGFloat scrollwidth = _myscrollview.frame.size.width;
    CGFloat imgW = image.size.width;
    CGFloat imgH = image.size.height;
    imgH = imgH * scrollwidth / imgW/1.1;
    imgW = scrollwidth/1.1;
    [image drawInRect: CGRectMake(0,0,imgW,imgH)];
    
    imageView.frame = CGRectMake(0,0,imgW,imgH);
    imageView.image = image;
    [_myscrollview addSubview:imageView];
    [imageView setCenter:CGPointMake(_myscrollview.center.x,imageView.center.y)];
    _myscrollview.frame = CGRectMake(0, 0, imgW, _myscrollview.frame.size.height);
    _myscrollview.contentSize = imageView.frame.size;
    _myscrollview.bounces = NO;
}

- (IBAction)release:(id)sender {
    [self.view removeFromSuperview];
}
@end