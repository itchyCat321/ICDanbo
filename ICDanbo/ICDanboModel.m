//
//  ICDanboModel.m
//  ICDanbo
//
//  Created by itchyCat on 16/3/21.
//  Copyright © 2016年 itchyCat321. All rights reserved.
//

#import "ICDanboModel.h"


@implementation ICDanboModel
+ (NSArray *)unque_Unit
{
    return @[IC_UNIT_HEAD,IC_UNIT_L_HAND,IC_UNIT_R_HAND,IC_UNIT_L_LEG,IC_UNIT_R_LEG,IC_UNIT_BODY];
}
+(BOOL)isFaceAtUnit:(NSString *)unque inIndex:(NSInteger)index
{
    //    head 的 第一张符号要求
    return ([unque isEqualToString:IC_UNIT_HEAD]) ? ((index == 0) ? true : false) :false;

}

+ (NSDictionary *)cubeRect_Danbo
{
    
    return @{
             IC_UNIT_HEAD:NSVALUE_ICDB(IC_SCREEN_WIDHT / 2.0,195,200,125,125),
             IC_UNIT_L_HAND:NSVALUE_ICDB(114,293,36,100,36),
             IC_UNIT_R_HAND:NSVALUE_ICDB(261,293,36,100,36),
             IC_UNIT_L_LEG:NSVALUE_ICDB(160, 437,40,116,40),
             IC_UNIT_R_LEG:NSVALUE_ICDB(215, 437,40,116,40),
             IC_UNIT_BODY:NSVALUE_ICDB(IC_SCREEN_WIDHT / 2.0,340,95,146,80)
            };

}




//value转换成danboCube
+(ICDanboCube)DanboCube_value:(NSString *)unque
{
    ICDanboCube cube;
    
    NSValue *value = [[self cubeRect_Danbo]objectForKey:unque];
    [value getValue:&cube];
   
    return cube;

}

//danboCube 转换成 value

+(ICDanboCube *)value_DanboCube:(ICDanboCube )cube
{
    ICDanboCube *cubePointer = &cube;
    
    return cubePointer;
}
//make方法
ICDanboCube ICDBMake(CGPoint cubeCenter , CubeSize cubeSize)
{
    ICDanboCube cube_Danbo;
    
    cube_Danbo.cubeCenter = cubeCenter;
    cube_Danbo.cubeSize = cubeSize;
    
    return cube_Danbo;
}
CubeSize CBSizeMake(CGFloat width,CGFloat height,CGFloat depth)
{
    CubeSize size = {width,height,depth};
  
    return size;
}
@end
