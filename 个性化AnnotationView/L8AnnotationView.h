//
//  L8AnnotationView.h
//  个性化AnnotationView
//
//  Created by 李亮 on 15/10/30.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import <MapKit/MapKit.h>

@class L8CalloutViewController;
@interface L8AnnotationView : MKAnnotationView
@property (strong, nonatomic) L8CalloutViewController *vc;

@end
