//
//  startup.h
//  Xingdo
//
//  Created by Erik－Xu on 15/9/22.
//  Copyright (c) 2015年 Yuntao Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "selectgame.h"
#import "explanation.h"

@interface startup : UIViewController
@property (strong,nonatomic) selectgame *gameselector;
@property (strong,nonatomic) explanation* explanation;
- (IBAction)jumptoselect:(UIButton *)sender;
- (IBAction)scoreshow:(id)sender;
- (IBAction)rulestate:(id)sender;
- (IBAction)aboutinfo:(id)sender;


@end
