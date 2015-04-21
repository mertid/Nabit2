//
//  Sell.h
//  NabiT
//
//  Created by Merritt Tidwell on 10/13/14.
//  Copyright (c) 2014 Merritt Tidwell. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Sell : UIViewController


@property (strong, nonatomic) IBOutlet UILabel *sellTitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *eventTextField;


@property (strong, nonatomic) IBOutlet UITextField *sectionTextField;

@property (strong, nonatomic) IBOutlet UILabel *ticketCountTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *priceRangeTitleLabel;

@property (strong, nonatomic) IBOutlet UIPickerView *ticketCountPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *pricePicker;
@property (strong, nonatomic) IBOutlet UIButton *listTicketButton;



@end
