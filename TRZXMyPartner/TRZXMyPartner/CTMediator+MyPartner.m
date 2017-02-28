//
//  CTMediator+MyPartner.m
//  TRZXMyPartner
//
//  Created by Rhino on 2017/2/28.
//  Copyright © 2017年 Rhino. All rights reserved.
//

#import "CTMediator+MyPartner.h"

NSString * const kMyPartnerA = @"MyPartner";

NSString * const kMyPartnerViewController          = @"MyPartner_TRZXMyPartnerViewController";
NSString * const kUserHomerController              = @"MyPartner_TRZXUserHomeViewController";


@implementation CTMediator (MyPartner)

- (UIViewController *)MyPartner_TRZXMyPartnerViewController:(NSDictionary *)parms{
    UIViewController *viewController = [self performTarget:kMyPartnerA
                                                    action:kMyPartnerViewController
                                                    params:parms
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (UIViewController *)MyPartner_TRZXUserHomeViewController:(NSDictionary *)parms{
    
    UIViewController *viewController = [self performTarget:kMyPartnerA
                                                    action:kUserHomerController
                                                    params:parms
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
