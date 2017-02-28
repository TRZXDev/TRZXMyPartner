//
//  TRMyWorkViewModel.h
//  TRZX
//
//  Created by Rhino on 16/9/13.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRZXMyPartnerViewModel: NSObject




/**
 我的团队
 
 @param level   level : 1:业务代表 2：运营商
 @param page    页码
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)myTeamLevel:(NSString *)level pageNo:(NSString *)page success:(void (^)(id))success failure:(void (^)(NSError *))failure;


@end
