//
//  mapVC.h
//  NabiT
//
//  Created by Merritt Tidwell on 10/13/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface mapVC : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *salesTableView;
@property (strong, nonatomic) IBOutlet MKMapView *salesMapView;

@end



