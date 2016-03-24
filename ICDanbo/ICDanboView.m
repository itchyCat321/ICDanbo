//
//  ICDanboView.m
//  ICDanbo
//
//  Created by itchyCat on 16/3/21.
//  Copyright © 2016年 itchyCat321. All rights reserved.
//

#import "ICDanboView.h"
#import "ICDanboModel.h"
#import "ICDanboUnitView.h"
#import "ICDanboUnitSkinView.h"
#import <GLKit/GLKit.h>


@interface ICDanboView ()

@property (nonatomic,strong)UIPanGestureRecognizer * pan_3DModel;
@property (nonatomic,strong)NSMutableArray * all_Units;
@property (nonatomic,assign)NSUInteger selectIndex_Unit;
//选中的unit
@property (nonatomic,strong)ICDanboUnitView * select_Unit;

@property (nonatomic,strong)NSString * name;
@property(nonatomic)BOOL isSinging;

@end
@implementation ICDanboView
{
    NSInteger index_head;
}

+(ICDanboView *)createDanboWithName:(NSString *)name
{
    CGRect danboRect = CGRectMake(0, 0, IC_SCREEN_WIDHT, IC_SCREEN_HEIGHT);
    
    ICDanboView * danbo = [[ICDanboView alloc]initWithFrame:danboRect];
    danbo.name = name;
    //   拼装unit
    [danbo assemble_DanboUnit];
    
    return danbo;
}

-(NSMutableArray *)all_Units
{
    if (!_all_Units)
    {
        _all_Units = [NSMutableArray arrayWithCapacity:IC_UNIT_COUNT];
        for (int index = 0; index < IC_UNIT_COUNT; index++)
        {
            NSString * unque_Unit = [[ICDanboModel unque_Unit]objectAtIndex:index];

            ICDanboCube danboCube = [ICDanboModel DanboCube_value:unque_Unit];
            //  创建unitview
            ICDanboUnitView * unit_View = [[ICDanboUnitView alloc]initWithDanboCube:danboCube withUnque:unque_Unit];
          
           [self addSubview:unit_View];
           [_all_Units addObject:unit_View];
          
            
        }
        
    }
    return _all_Units;
}
-(UIPanGestureRecognizer *)pan_3DModel
{
    if (!_pan_3DModel)
    {
        _pan_3DModel = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(rotation_3DModel:)];
    }
    return _pan_3DModel;


}

-(void)assemble_DanboUnit

{
    CATransform3D  transform_subLayer = CATransform3DIdentity;
    transform_subLayer.m34 = -1.0 / 1000.0;
    
    self.layer.sublayerTransform = transform_subLayer;
    
    CATransform3D transform = CATransform3DIdentity;

    for (ICDanboUnitView * unit in self.all_Units)
    {
        
        [unit assemble_DanboSkinWithTransform:transform];
        
    }
    
    //添加手势
    
    [self addGestureRecognizer:self.pan_3DModel];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sing_danbo:)];
    
    [self addGestureRecognizer:tap];
    



}
-(void)sing_danbo:(UIPanGestureRecognizer *)recognizer
{
    if ([self isSubLayer_transformView:self.all_Units[0] hitText:[recognizer locationInView:self]])
    {
        if (index_head == 0)
        {
            NSArray * all_skin = [(ICDanboUnitView *)self.all_Units[0] all_Skins];
            ICDanboUnitSkinView * faceView = (ICDanboUnitSkinView *)[all_skin objectAtIndex:index_head];
            
            [faceView sing_danbo];
            
        }
    
    };
    

}
-(BOOL)isSubLayer_transformView:(ICDanboUnitView *)unitView hitText:(CGPoint)point
{
    BOOL isSubLayer = false;
    
    for (int index = 0; index < 6; index++)
    {
        if ([unitView.all_Skins[index]layer] == [self.layer hitTest:point])
        {
            index_head = index;
            isSubLayer = true;
        }
    }
    
    return isSubLayer;
}
-(NSUInteger)unit_HitText:(CGPoint)point Index:(int)index
{
    NSUInteger index_unit;
    //    body和在danbo外一样  处理整体的旋转
    if (index == 5)
    {
        return index_unit = IC_UNIT_NOTFOUND;
    
    }
    if ([self isSubLayer_transformView:self.all_Units[index] hitText:point])
    {
       
        return index_unit = index;
    
    }
    else
    {
        int nextIndex = index + 1;
        
        return  index_unit =  [self unit_HitText:point Index:nextIndex];
    }
   
}

-(void)rotation_3DModel:(UIPanGestureRecognizer *)recognizer
{
    
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            self.selectIndex_Unit = [self unit_HitText:[recognizer locationInView:self] Index:0];
            //     有找到unit
            if (self.selectIndex_Unit != IC_UNIT_NOTFOUND)
            {
                
                self.select_Unit = self.all_Units[self.selectIndex_Unit];
                
            }
            
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            GLKMatrix4 matrix4;
 
            CGPoint diff = [recognizer translationInView:self];

            if (!self.select_Unit)
            {
                matrix4 = [self change_transform:self.layer.sublayerTransform translationPoint:diff];
                self.layer.sublayerTransform = [self transform3DFromMatrix:matrix4];

            }
            else
            {
                matrix4 = [self change_transform: self.select_Unit.layer.transform translationPoint:diff];
                self.select_Unit.layer.transform = [self transform3DFromMatrix:matrix4];

            }
            
            [recognizer setTranslation:CGPointZero inView:self];

            break;

        }
        case UIGestureRecognizerStateEnded:
        {
            self.select_Unit = nil;
            
            break;

        }
        case UIGestureRecognizerStateCancelled:
        {
            self.select_Unit = nil;

            break;

        }
            
        default:
            break;
    }


}
-(GLKMatrix4)change_transform:(CATransform3D)transform translationPoint:(CGPoint)diff
{
    GLKMatrix4 rot_Matrix = [self matrixFromTransform3D:transform];
    
    float x_rot = (!(self.selectIndex_Unit == IC_UNIT_NOTFOUND||self.selectIndex_Unit == 0))?
     1*GLKMathDegreesToRadians(-diff.y/2.0) : 0 ;
    
    float y_rot = ((self.selectIndex_Unit == IC_UNIT_NOTFOUND||self.selectIndex_Unit == 0))?
    (-1*GLKMathDegreesToRadians(-diff.x/2.0)) : 0;
    
    BOOL isInvertible;
    //    世界坐标 和 对象坐标的转换
    GLKVector3 x_Axis = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(rot_Matrix, &isInvertible), GLKVector3Make(1, 0, 0));
    
    rot_Matrix = GLKMatrix4Rotate(rot_Matrix,x_rot, x_Axis.x, x_Axis.y, x_Axis.z);
    
    GLKVector3 y_Axis = GLKMatrix4MultiplyVector3(GLKMatrix4Invert(rot_Matrix, &isInvertible), GLKVector3Make(0, 1, 0));
    
    rot_Matrix = GLKMatrix4Rotate(rot_Matrix,y_rot, y_Axis.x, y_Axis.y, y_Axis.z);

    
                                                 
    
    return rot_Matrix;
    
}
//trasform和glkmatrix的转换
- (GLKMatrix4)matrixFromTransform3D:(CATransform3D)transform
{
    GLKMatrix4 matrix = GLKMatrix4Make(transform.m11, transform.m12, transform.m13, transform.m14,
                                       transform.m21, transform.m22, transform.m23, transform.m24,
                                       transform.m31, transform.m32, transform.m33, transform.m34,
                                       transform.m41, transform.m42, transform.m43, transform.m44);
    
    return matrix;
}
-(CATransform3D )transform3DFromMatrix:(GLKMatrix4 )matrix
{
    CATransform3D transform= {matrix.m00,  matrix.m01,  matrix.m02,  matrix.m03,
                              matrix.m10,  matrix.m11,  matrix.m12, matrix.m13,
                              matrix.m20,  matrix.m21,  matrix.m22, matrix.m23,
                              matrix.m30,  matrix.m31,   matrix.m32,  matrix.m33};
    
    return transform;
}

@end
