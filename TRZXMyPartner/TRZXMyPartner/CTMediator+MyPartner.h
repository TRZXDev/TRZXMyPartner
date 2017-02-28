//
//  CTMediator+MyPartner.h
//  TRZXMyPartner
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import <CTMediator/CTMediator.h>
#import <UIKit/UIKit.h>

@interface CTMediator (MyPartner)

- (UIViewController *)MyPartner_TRZXMyPartnerViewController:(NSDictionary *)parms;



/**
 个人主页

 @param parms @{@"title":@"",@"mid":@""}
 @return ..
 */
- (UIViewController *)MyPartner_TRZXUserHomeViewController:(NSDictionary *)parms;


@end
