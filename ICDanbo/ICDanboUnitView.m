//
//  ICDanboUnitView.m
//  ICDanbo
//
//  Created by itchyCat on 16/3/22.
//  Copyright © 2016年 itchyCat321. All rights reserved.
//

#import "ICDanboUnitView.h"
#import "ICDanboUnitSkinView.h"
#import "ICDanboModel.h"


@interface ICDanboUnitView()


@property(nonatomic,strong)NSString * unque_Unit;
@property(nonatomic,assign)ICDanboCube cube_danbo;


@end
@implementation ICDanboUnitView
+(Class)layerClass
{
    return [CATransformLayer class];
}
-(CATransformLayer *)transformLayer
{
    return (CATransformLayer *)self.layer;
}

-(NSMutableArray *)all_Skins
{
    if (!_all_Skins)
    {
        _all_Skins = [NSMutableArray arrayWithCapacity:IC_SKIN_COUNT];
        for ( int index = 0 ; index < IC_SKIN_COUNT ; index++)
        {
             NSInteger index_unit = [[ICDanboModel unque_Unit]indexOfObject:self.unque_Unit];
             ICDanboUnitSkinView * skin = [[ICDanboUnitSkinView alloc]initWithFrame:self.bounds];
             skin.backgroundColor = RGB((243-5*index_unit), 184, (107-10*index_unit), 1);
             skin.isFace = [ICDanboModel isFaceAtUnit:self.unque_Unit inIndex:index];
            
            [self addSubview:skin];
            [_all_Skins addObject:skin];
        }
    }

    return _all_Skins;
}
-(instancetype)initWithDanboCube:(ICDanboCube )cube withUnque:(NSString *)unque
{
    if (self = [super init])
    {
        self.unque_Unit = unque;
        self.cube_danbo = cube;
        
    }
    return self;
}
-(void)setCube_danbo:(ICDanboCube)cube_danbo
{
    //   对transformlayer设定在父视图的位置
    self.bounds = CGRectMake(0, 0, cube_danbo.cubeSize.width, cube_danbo.cubeSize.height);
    self.center = cube_danbo.cubeCenter;
    
    _cube_danbo = cube_danbo;

}
-(void)assemble_DanboSkinWithTransform:(CATransform3D )transform
{
    
//    回来写数据
    CATransformLayer * cube = [self transformLayer];
    
    CGFloat width_unit = self.cube_danbo.cubeSize.width;
    CGFloat height_unit = self.cube_danbo.cubeSize.height;
    CGFloat depth_unit = self.cube_danbo.cubeSize.depth;

    CATransform3D ct = CATransform3DMakeTranslation(0, 0, depth_unit / 2.0);
    [self skin_atIndex:0 withTransform:ct bounds:CGRectMake(0, 0, width_unit, height_unit)];
    
    ct = CATransform3DMakeTranslation(width_unit / 2.0, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [self skin_atIndex:1 withTransform:ct bounds:CGRectMake(0, 0, depth_unit, height_unit)];

    ct = CATransform3DMakeTranslation(0, -height_unit / 2.0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [self skin_atIndex:2 withTransform:ct bounds:CGRectMake(0, 0, width_unit, depth_unit)];

    ct = CATransform3DMakeTranslation(0, height_unit / 2.0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [self skin_atIndex:3 withTransform:ct bounds:CGRectMake(0, 0, width_unit, depth_unit)];

    ct = CATransform3DMakeTranslation(-width_unit / 2.0, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [self skin_atIndex:4 withTransform:ct bounds:CGRectMake(0, 0, depth_unit, height_unit)];

    ct = CATransform3DMakeTranslation(0, 0, -depth_unit / 2.0);
    ct=CATransform3DRotate(ct, M_PI, 0, 1, 0);
    [self skin_atIndex:5 withTransform:ct bounds:CGRectMake(0, 0, width_unit, height_unit)];

    self.bounds = CGRectMake(0, 0, width_unit, height_unit);
    cube.position = self.cube_danbo.cubeCenter;
    
    if (!([self.unque_Unit isEqualToString:IC_UNIT_HEAD] || [self.unque_Unit isEqualToString:IC_UNIT_BODY])){
        cube.anchorPoint = CGPointMake(0.5, 0.5 * 1/4.0);
        }
    
    cube.transform = transform;

    
}

-(void)skin_atIndex:(NSInteger)index withTransform:(CATransform3D )transform bounds:(CGRect)rect
{
    //    每个skinview设定bounds和transform变换
    UIView * skinView = self.all_Skins[index];
    skinView.layer.bounds = rect;
    skinView.layer.transform = transform;



}
@end
//-----------------------------------------CATransformLayer扩展----------------------------------------------
//重写 防止报错
@implementation CATransformLayer (extension)
-(void)setOpaque:(BOOL)opaque{
    return;
}
-(void)setContents:(id)contents{
    return;
}
-(void)setBackgroundColor:(CGColorRef)backgroundColor{
    return;
}
@end
