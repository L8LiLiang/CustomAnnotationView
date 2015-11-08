//
//  L8Annotation.h
//  个性化AnnotationView
//
//  Created by 李亮 on 15/10/30.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface L8Annotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;



@end
