//
//  Sell.m
//  NabiT
//
//  Created by Merritt Tidwell on 10/13/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import "Sell.h"
#import <Parse/Parse.h>
#import "FinalSell.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FinalSell.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface Sell () <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate,CLLocationManagerDelegate>

@property (strong,nonatomic) NSString * selectedTicket;
@property(strong,nonatomic) NSString * selectedEvent;
@property(strong, nonatomic) NSString * selectedPrice;
@property(strong, nonatomic) NSString * sectionText;


@end

@implementation Sell


{

    NSArray * _numberOfTickets;
    NSArray * _eventNames;
    NSArray * _rangeOfPrices;
    CLLocationManager * locationManager;
    CLLocation *currentLocation;
    PFObject * TicketsForSale;
    UIButton * listTicketsButton;
    
  
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.navigationController.navigationBar setTranslucent:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    UIColor *color = [UIColor colorWithRed:0.153f green:0.812f blue:0.459f alpha:1.0f];

    
    self.view.backgroundColor = [UIColor colorWithRed:0.153f green:0.812f blue:0.459f alpha:1.0f];
 
    
    // Sell Title Attributes
    
    self.sellTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    self.sellTitleLabel.textColor = [UIColor whiteColor];
   
    
    // List Tickets Button Attributes
   
    self.listTicketButton.backgroundColor = [UIColor colorWithRed:0.153f green:0.812f blue:0.459f alpha:1.0f];
    self.listTicketButton.layer.cornerRadius = 8;
    [self.view addSubview:listTicketsButton];
    [self.listTicketButton setTitle:@"list tickets" forState:UIControlStateNormal];
    self.listTicketButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];

   
    //TextField Attributes and Delegate
    
    self.eventTextField.backgroundColor = [UIColor whiteColor];
    self.eventTextField.layer.cornerRadius = 8;
    self.eventTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  event" attributes:@{NSForegroundColorAttributeName: color}];
    self.eventTextField.placeholder = @"  event";
    self.eventTextField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:22];
    self.eventTextField.delegate = self;

    
    self.sectionTextField.backgroundColor = [UIColor whiteColor];
    self.sectionTextField.layer.cornerRadius = 8;
    self.sectionTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"  section" attributes:@{NSForegroundColorAttributeName: color}];
    self.sectionTextField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:22];
    self.sectionTextField.delegate = self;


    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];

    //[self currentLocation];
    //NSLog(@"%@", [self currentLocation]);

    
 // Number of Ticket Picker
    

    self.ticketCountPicker.delegate = self;
    self.ticketCountPicker.dataSource = self;
    self.ticketCountPicker.tag = 0;
    
    _numberOfTickets = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    
    self.ticketCountTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    self.ticketCountTitleLabel.text = @"ticket count";

    
// Price Picker and Title Label
    
    self.pricePicker.delegate = self;
    self.pricePicker.dataSource = self;
    self.pricePicker.tag = 1;
   
    _rangeOfPrices = @[@"0-25", @"25-50", @"50-75", @"75-100", @"100-125", @"125 plus"];
 
    self.priceRangeTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:30];
    self.priceRangeTitleLabel.text = @"price range";
    
   
    
   
}
- (NSString *)currentLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    

}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    switch (pickerView.tag) {
        case 0:
            
            return  _numberOfTickets.count;
            break;

        case 1:
            return _rangeOfPrices.count;
            break;
        
        default:
            break;
            
   }

    
    return 1;

}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* lbl = (UILabel*)view;
    // Customise Font
    if (lbl == nil) {
        //label size
        CGRect frame = CGRectMake(0.0, 0.0, 20, 30);
        
        lbl = [[UILabel alloc] initWithFrame:frame];
        
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:22]];
        
    }
    //picker view array is the datasource
    [lbl setText:[_numberOfTickets objectAtIndex:row]];
    
    
    return lbl;
}





-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 0:
            
            return  _numberOfTickets[row];
            break;
            
        case 1:
            return _rangeOfPrices[row];
            break;
            
        default:
            break;
    }
    return @"";
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSLog(@"%d", (int)pickerView.tag);
    switch (pickerView.tag) {
        case 0:
            
            self.selectedTicket =  _numberOfTickets[row];
            break;

            
        case 1:
            self.selectedPrice = _rangeOfPrices[row];
            break;
            default:
            break;
    }
}

-(void)saveToParseSell
{

    long row = [self.ticketCountPicker selectedRowInComponent:0];
    long row2 = [self.pricePicker selectedRowInComponent:0];
    NSLog(@"Selected Ticket %@",[_numberOfTickets objectAtIndex:row]);
 
    
     TicketsForSale = [PFObject objectWithClassName:@"TicketsForSale"];
    [TicketsForSale setObject: [_numberOfTickets objectAtIndex:row] forKey: @"NumberOfTicketsSelling"];
    [TicketsForSale setObject:[_rangeOfPrices objectAtIndex:row2] forKey:@"PriceForTicket"];
    [TicketsForSale setObject:[PFUser currentUser] forKey:@"SellerID"];
    [TicketsForSale setObject:[PFUser currentUser] forKey:@"Username"];
    [TicketsForSale setObject:self.eventTextField.text forKey:@"Event"];
    [TicketsForSale setObject:self.sectionTextField.text forKey:@"Section"];
    
    NSLog(@"%@",TicketsForSale);
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            //        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
            
            [TicketsForSale setObject:geoPoint forKey:@"Location"];
            
            [TicketsForSale saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    NSLog(@"Successfully saved tickets!");
                } else {
                    NSLog(@"Couldn't save sellers tickets!");
                }
                
                if (error != nil) {
                    NSLog(@"An error occurred %@", error.userInfo);
                }
            }];
            
            
        }
    }];

    
 
}

-(void)listTicketButtonWasPressed
{
    [self saveToParseSell];
    
    FinalSell * finalsellVC = [[FinalSell alloc]init];

    finalsellVC.finalSeller = TicketsForSale;
    [self presentViewController:finalsellVC animated:NO completion:nil];
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.eventTextField resignFirstResponder];
    [self.sectionTextField resignFirstResponder];
    return YES;
}
- (IBAction)backButton:(id)sender {
 
    [self dismissViewControllerAnimated:YES completion:nil];

}


@end
