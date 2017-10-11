//
//  GAPGuideViewController.h
//  BangTravel
//
//  Created by YaoKaige on 16/1/15.
//  Copyright © 2016年 Beijing Gan Servant Software Co., Ltd. All rights reserved.
//

typedef enum{
    TransuformTypeCard,
    TransuformTypeZhuan
} TransuformType;

#import <UIKit/UIKit.h>

@interface GAPGuideViewController : UIViewController

@property (nonatomic,assign) TransuformType type;

@end
