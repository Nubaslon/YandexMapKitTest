/*
 * VisibleRectExampleViewController.m
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011-2013 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import "VisibleRectExampleViewController.h"

@interface VisibleRectExampleViewController ()

- (IBAction)locateMeButtonTapped:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton *locateMeButton;
@property (nonatomic, weak) IBOutlet UIView *visibleRectView;

@property (nonatomic, strong) PointAnnotation * annotation;

@end


@implementation VisibleRectExampleViewController

- (void)configureMapView {
    self.mapView.showsUserLocation = NO;
    self.mapView.showTraffic = NO;
    [self.mapView setCenterCoordinate:YMKMapCoordinateMake(55.733945, 37.588102)
                          atZoomLevel:16
                             animated:NO];
}

- (void)configureAndInstallAnnotations {
    self.annotation = [PointAnnotation pointAnnotation];
    self.annotation.coordinate = YMKMapCoordinateMake(55.733945, 37.588102);
    self.annotation.title = @"Yandex";
    
    [self.mapView addAnnotation:self.annotation];
}

#pragma mark - View lifecycle

- (NSString *)nibName {
    return @"VisibleRectExampleViewController";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureMapView];
    [self configureAndInstallAnnotations];
}

#pragma mark - IBActions

- (IBAction)locateMeButtonTapped:(id)sender {
    [self.mapView scrollToAnnotation:self.annotation animated:YES];
}

#pragma mark - YMKMapViewDelegate

- (CGRect)mapViewVisibleRect:(YMKMapView *)mapView {
    return self.visibleRectView.frame;
}

@end
