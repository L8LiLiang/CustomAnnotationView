//
//  ViewController.m
//  个性化AnnotationView
//
//  Created by 李亮 on 15/10/30.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "L8AnnotationView.h"
#import "L8Annotation.h"

@interface ViewController () <CLLocationManagerDelegate,MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *myLocation;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.mapView.delegate = self;
}



- (IBAction)locateMe:(id)sender {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    self.myLocation = locations.firstObject;
    [self.locationManager stopUpdatingLocation];
    
    L8Annotation *annotation = [L8Annotation new];
    annotation.coordinate = self.myLocation.coordinate;
    annotation.title = @"leon";
    [self.mapView setCenterCoordinate:self.myLocation.coordinate animated:YES];
    [self.mapView addAnnotation:annotation];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
//    if ([annotation isKindOfClass:[L8Annotation class]]) {
//        static NSString *reuseIdentifier = @"reuse";
//        
//        L8AnnotationView *view = (L8AnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
//        if (!view) {
//            
//            view = [[L8AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
//            view.canShowCallout = YES;
//            
//            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            [rightBtn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
//            rightBtn.tag = 111;
//            view.rightCalloutAccessoryView = rightBtn;
//        }
//        
//        return view;
//    }
    
    if ([annotation isKindOfClass:[L8Annotation class]]) {
        static NSString *reuseIdentifier = @"reuse";
        
        L8AnnotationView *view = (L8AnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        if (!view) {
            
            view = [[L8AnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
            view.canShowCallout = NO;
            view.draggable = YES;
        }
        
        return view;
    }

    
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if (control.tag == 111) {
        NSLog(@"calloutAccessory");
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    NSLog(@"%zd,%zd",newState,oldState);
}

- (void)btn:(UIButton *)sender
{
    NSLog(@"clicked");
}

-(CLLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

@end
