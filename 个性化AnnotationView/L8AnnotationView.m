//
//  L8AnnotationView.m
//  个性化AnnotationView
//
//  Created by 李亮 on 15/10/30.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import "L8AnnotationView.h"
#import "L8CalloutView.h"

@interface L8AnnotationView ()
@property (strong, nonatomic) L8CalloutView *calloutView;
@end

@implementation L8AnnotationView

-(void)setDragState:(MKAnnotationViewDragState)newDragState animated:(BOOL)animated{
    if (newDragState == MKAnnotationViewDragStateStarting) {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.transform = CGAffineTransformMakeRotation(M_2_PI);
//        } completion:^(BOOL finished) {
//        }];
        self.dragState = MKAnnotationViewDragStateDragging;
    }else if (newDragState == MKAnnotationViewDragStateEnding ||
              newDragState == MKAnnotationViewDragStateCanceling){
//        [UIView animateWithDuration:0.5 animations:^{
//            self.transform = CGAffineTransformMakeRotation(0);
//        } completion:^(BOOL finished) {
//
//        }];
        self.dragState = MKAnnotationViewDragStateNone;
    }else{
        self.dragState = newDragState;
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (!view && self.selected) {
        CGPoint calloutPoint = [self convertPoint:point toView:self.calloutView];
        view = [self.calloutView hitTest:calloutPoint withEvent:event];
    }
    return view;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    L8CalloutView *calloutView = self.calloutView;
    if (selected) {
        CGRect calloutViewFrame = calloutView.frame;
        calloutViewFrame.origin.x = - (calloutViewFrame.size.width - self.frame.size.width) / 2;
        calloutViewFrame.origin.y = -calloutViewFrame.size.height;
        calloutView.frame = calloutViewFrame;
        
        [self addSubview:calloutView];
    }else
    {
        [calloutView removeFromSuperview];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat arcCount = 3;
    CGFloat margin = 10;
    CGFloat innerMargin = 2;
    CGFloat radius = (rect.size.width - margin * 2 - (arcCount - 1) *innerMargin) / arcCount / 2;
    CGPoint center1,center2,center3;
    center1.x = margin + radius;
    center1.y = rect.size.height / 2;
    
    center2.x = center1.x + radius * 2 + innerMargin;
    center2.y = center1.y;
    
    center3.x = center2.x + radius * 2 + innerMargin;
    center3.y = center1.y;
    
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:center1 radius:radius startAngle:0 endAngle:2 * M_PI clockwise:0];
    [[UIColor redColor] setFill];
    [path1 fill];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:center2 radius:radius startAngle:0 endAngle:2 * M_PI clockwise:0];
    [[UIColor greenColor] setFill];
    [path2 fill];
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:center3 radius:radius startAngle:0 endAngle:2 * M_PI clockwise:0];
    [[UIColor blueColor] setFill];
    [path3 fill];
    
    CGRect titleRect = CGRectMake(margin, innerMargin, rect.size.width - margin * 2, rect.size.height / 3);
    [[self.annotation title] drawInRect:titleRect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8]}];
}


-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        CGRect myFrame = self.frame;
        myFrame.size.width = 80;
        myFrame.size.height = 60;
        self.frame = myFrame;
        
        self.opaque = NO;
        
        L8CalloutView *calloutView = [L8CalloutView new];
        calloutView.frame = CGRectMake(0, 0, 100, 50);
        calloutView.title = [annotation title];
        self.calloutView = calloutView;
        
    }
    return self;
}

@end
