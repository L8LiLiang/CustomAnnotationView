//
//  L8CalloutView.m
//  个性化AnnotationView
//
//  Created by 李亮 on 15/10/30.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import "L8CalloutView.h"

@implementation L8CalloutView


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
    [[self title] drawInRect:titleRect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8]}];
}

-(instancetype)init
{
    if (self = [super init]) {
        self.opaque = NO;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.title forKey:@"title"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchbegan");
}

@end
