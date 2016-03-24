//
//  ICDanboUnitSkinView.m
//  ICDanbo
//
//  Created by itchyCat on 16/3/22.
//  Copyright © 2016年 itchyCat321. All rights reserved.
//

#import "ICDanboUnitSkinView.h"
@interface ICDanboUnitSkinView()

@property(nonatomic,strong)CAShapeLayer * mouth_Layer;
@property(nonatomic,strong)CADisplayLink * displayLink;
@property(nonatomic)CGPoint move_Point;
@property(nonatomic)BOOL isSinging;

@end
static float ic_speed = 0.8;
@implementation ICDanboUnitSkinView
{
    int postive;

}
-(void)setIsFace:(BOOL)isFace
{

    if (isFace)
    {
        [self draw_SomeThing];
    }
    
    _isFace = isFace ;


}

-(void)draw_SomeThing
{
    
        // 画脸
    
    
        CGRect square = CGRectMake(55, 40, 20, 20);
        UIBezierPath * cirle_path =[UIBezierPath bezierPathWithOvalInRect:square];
        
        CAShapeLayer  * l_eyeLayer = [CAShapeLayer layer];
        l_eyeLayer.path = cirle_path.CGPath;
        l_eyeLayer.fillColor = [UIColor blackColor].CGColor;
        
        [self.layer addSublayer:l_eyeLayer];
    
        square = CGRectMake(125, 40, 20, 20);
        cirle_path =[UIBezierPath bezierPathWithOvalInRect:square];

        CAShapeLayer  * r_eyeLayer = [CAShapeLayer layer];
        r_eyeLayer.path = cirle_path.CGPath;
        r_eyeLayer.fillColor = [UIColor blackColor].CGColor;
    
        [self.layer addSublayer:r_eyeLayer];
    
       //    初始的path
       UIBezierPath * m_path = [[UIBezierPath alloc]init];
    
       self.move_Point=CGPointMake(self.bounds.size.width/2.0, 80);

    
       [m_path moveToPoint:CGPointMake(self.bounds.size.width/2.0-10, 10*sqrt(3)+80)];
       [m_path addLineToPoint:CGPointMake(self.bounds.size.width/2.0, self.move_Point.y)];
       [m_path addLineToPoint:CGPointMake(self.bounds.size.width/2.0+10, 10*sqrt(3)+80)];
       [m_path addLineToPoint:CGPointMake( self.bounds.size.width/2.0-10, 10*sqrt(3)+80)];

       self.mouth_Layer = [CAShapeLayer layer];
       self.mouth_Layer.path = m_path.CGPath;
       self.mouth_Layer.fillColor = [UIColor blackColor].CGColor;
    
       [self.layer addSublayer:self.mouth_Layer];
    
    
          
    

}
-(void)open_displaylink
{
    self.isSinging = true;
    
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(change_path:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}
-(void)close_displaylink
{
    self.isSinging = false;
    
    [self.displayLink invalidate];
}
-(void)change_path:(CADisplayLink *)displayLink
{   //  改变move_Point的位置
    if (self.move_Point.y >= 97.3)
    {
        postive = -1;
    }
    else if (self.move_Point.y <= 80)
    {
        postive = 1;
    }
    
    self.move_Point = CGPointMake(self.move_Point.x,  self.move_Point.y+postive * ic_speed);
    
    UIBezierPath * m_path = [[UIBezierPath alloc]init];
    
    [m_path moveToPoint:CGPointMake(self.bounds.size.width/2.0-10, 10*sqrt(3)+80)];
    [m_path addLineToPoint:CGPointMake(self.bounds.size.width/2.0, self.move_Point.y)];
    [m_path addLineToPoint:CGPointMake(self.bounds.size.width/2.0+10, 10*sqrt(3)+80)];
    [m_path addLineToPoint:CGPointMake( self.bounds.size.width/2.0-10, 10*sqrt(3)+80)];

    
    [self.mouth_Layer setPath:m_path.CGPath];

}
-(void)sing_danbo
{
    (!self.isSinging) ? [self open_displaylink]:[self close_displaylink];

}



@end
