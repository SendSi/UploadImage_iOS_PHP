//
//  LEDPersonAPI.h
//  LED_Lampe
//
//  Created by u% on 16/12/5.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import "HJBaseAPI.h"

typedef void (^HttpGetDataCb)(NSDictionary* dict);
/**  修改个人信息  */
@interface LEDPersonAPI : HJBaseAPI
/**  修改个人信息  key,value*/
+(instancetype)initPersonModify:(NSString *)keyString valueString:(NSString *)valueString;




-(void)HttpPostAsync:(NSString *)url parameter:( NSString *)parameter cb:(HttpGetDataCb )cb;

@end
