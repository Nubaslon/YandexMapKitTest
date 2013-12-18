/*
 * TrafficViewController.m
 *
 * This file is a part of the Yandex Map Kit.
 *
 * Version for iOS © 2011-2013 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at http://legal.yandex.ru/mapkit/
 */

#import "TrafficViewController.h"

@implementation TrafficViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureMapView];
    [self updateTrafficInformer];
    [self subscribeForTrafficNotifications];
}

- (void)viewDidUnload {
    [self unsubscribeFromTrafficNotifications];

    [super viewDidUnload];
}

#pragma mark - Helpers

- (void)configureMapView {
    self.mapView.showsUserLocation = NO;
    self.mapView.showTraffic = YES;
    [self.mapView setCenterCoordinate:YMKMapCoordinateMake(55.753699, 37.619001)
                          atZoomLevel:11
                             animated:NO];
}

#pragma mark - Traffic Notifications

- (void)updateTrafficInformer {
    YMKTrafficInformer * informer = [self.mapView.trafficInformers lastObject];
    self.title = [NSString stringWithFormat:@"Пробки: %d", informer.value];
}

- (void)subscribeForTrafficNotifications {
    [self.mapView addObserver:self forKeyPath:@"trafficInformers" options:0 context:NULL];
}

- (void)unsubscribeFromTrafficNotifications {
    [self.mapView removeObserver:self forKeyPath:@"trafficInformers"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"trafficInformers"] && object == self.mapView) {
        // Traffic informers are always processed in background
        __weak typeof(self) blockSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [blockSelf updateTrafficInformer];
        });
    }
    else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

- (void)dealloc {
    [self unsubscribeFromTrafficNotifications];
}

@end
