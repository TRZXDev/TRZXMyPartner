//
//  TRMyWorkViewModel.m
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRZXMyPartnerViewModel.h"
#import <TRZXNetwork/TRZXNetwork.h>

@implementation TRZXMyPartnerViewModel

//================================================================================================


/**
 我的团队

 @param level   level : 1:业务代表 2：运营商
 @param page    页码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)myTeamLevel:(NSString *)level pageNo:(NSString *)page success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
//
    NSDictionary *param = @{
                            @"apiType":@"myTeam",
                            @"requestType":@"Member_Api",
                            @"level":level?level:@"",
                            @"pageNo":page?page:@"1"
                            };
    
    
    [TRZXNetwork configHttpHeaders:@{@"equipment":@"ios",
                                     @"token":@"9bfc515a2fc0ea364a4340f38f7f47ff",
                                     @"userId":@"60a121b25cb34088987041b3b7632098"}];
    
    [TRZXNetwork requestWithUrl:nil params:param method:POST cachePolicy:NetworkingReloadIgnoringLocalCacheData callbackBlock:^(id response, NSError *error) {
        if (response) {
            success(response);
        }else{
            failure(error);
        }
    }];
    
    
//    [KipoNetworking get:[KipoServerConfig serverURL] params:param cachePolicy:KipoNetworkingReloadIgnoringLocalCacheData success:^(id json) {
//        
//        
//        success(json);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
}


@end
