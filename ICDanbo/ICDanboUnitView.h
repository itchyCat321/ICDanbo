//
//  ICDanboUnitView.h
//  ICDanbo
//
//  Created by itchyCat on 16/3/22.
//  Copyright © 2016年 itchyCat321. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICDanboModel.h"

@interface ICDanboUnitView : UIView

@property(nonatomic,strong)NSMutableArray * all_Skins;


-(instancetype)initWithDanboCube:(ICDanboCube )cube withUnque:(NSString *)unque;

-(void)assemble_DanboSkinWithTransform:(CATransform3D )transform;

@end
