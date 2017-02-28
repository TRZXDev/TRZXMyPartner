//
//  Target_MyPartner.h
//  TRZXMyPartner
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_MyPartner : NSObject


/**
 我的客户

 @param params ..
 @return ..
 */
- (UIViewController *)Action_MyPartner_TRZXMyPartnerViewController:(NSDictionary *)params;


/**
 个人详情

 @param params ..
 @return ..
 */
- (UIViewController *)Action_MyPartner_TRZXUserHomeViewController:(NSDictionary *)params;

@end
