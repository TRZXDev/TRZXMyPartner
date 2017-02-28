
//
//  TRMyCustomerModel.m
//  TRZX
//
//  Created by Rhino on 16/9/19.
//  Copyright © 2016年 Tiancaila. All rights reserved.
//

#import "TRZXMyPartnerModel.h"

@implementation TRZXMyPartnerModel

/* 设置模型属性名和字典key之间的映射关系 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
             @"ID" : @"id"
             };
}

@end
