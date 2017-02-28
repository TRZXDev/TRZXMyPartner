//
//  Target_MyPartner.m
//  TRZXMyPartner
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "Target_MyPartner.h"
#import "TRZXMyPartnerViewController.h"

@implementation Target_MyPartner


- (UIViewController *)Action_MyPartner_TRZXMyPartnerViewController:(NSDictionary *)params{
    TRZXMyPartnerViewController *myPartner = [[TRZXMyPartnerViewController alloc]init];
    myPartner.titleString = params[@"title"];
    return myPartner;
}

- (UIViewController *)Action_MyPartner_TRZXUserHomeViewController:(NSDictionary *)params{
    TRZXMyPartnerViewController *myPartner = [[TRZXMyPartnerViewController alloc]init];
    myPartner.titleString = params[@"title"];
    return myPartner;
}

@end
