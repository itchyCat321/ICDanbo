//
//  ICDanboModel.h
//  ICDanbo
//
//  Created by itchyCat on 16/3/21.
//  Copyright © 2016年 itchyCat321. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define IC_UNIT_HEAD    @"Head"
#define IC_UNIT_L_HAND  @"L_Hand"
#define IC_UNIT_R_HAND  @"R_Hand"
#define IC_UNIT_L_LEG   @"L_Leg"
#define IC_UNIT_R_LEG   @"R_Leg"
#define IC_UNIT_BODY    @"Body"
#define IC_UNIT_COUNT 6
#define IC_UNIT_NOTFOUND 10
#define IC_SKIN_COUNT 6
#define IC_SCREEN_WIDHT     [UIScreen mainScreen].bounds.size.width
#define IC_SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define RGB(r,g,b,a)  [ UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a];

#define NSVALUE_ICDB(C_X,C_Y,W,H,D)  [NSValue valueWithBytes:[self value_DanboCube:ICDBMake(CGPointMake(C_X, C_Y), CBSizeMake(W, H, D))] objCType:@encode(ICDanboCube)]
typedef struct _cubeSize
{
    CGFloat width;
    CGFloat height;
    CGFloat depth;
    
}CubeSize;

typedef struct _cubeRect
{
    CGPoint cubeCenter;
    CubeSize cubeSize;
    
}ICDanboCube;


@interface ICDanboModel : NSObject



ICDanboCube ICDBMake(CGPoint cubeCenter , CubeSize cubeSize);
CubeSize CBSizeMake(CGFloat width,CGFloat height,CGFloat depth);
+(ICDanboCube)DanboCube_value:(NSString *)unque;


+(NSArray *)unque_Unit;
+ (NSDictionary *)cubeRect_Danbo;
+(BOOL)isFaceAtUnit:(NSString *)unque inIndex:(NSInteger)index;


@end
