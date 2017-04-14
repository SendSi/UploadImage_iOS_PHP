//
//  LEDPersonAPI.m
//  LED_Lampe
//
//  Created by u% on 16/12/5.
//  Copyright © 2016年 SunSi. All rights reserved.
//

#import "LEDPersonAPI.h"

@implementation LEDPersonAPI
/**  修改个人信息  key,value*/
+(instancetype)initPersonModify:(NSString *)keyString valueString:(NSString *)valueString{
    LEDPersonAPI *api    =[LEDPersonAPI new];
    //key有nickname,avatar,sex,生日
    [api.parameters setObject:keyString forKey:@"key"];
    [api.parameters setObject:valueString forKey:@"value"];
    //api.subUrl=APP_MODIFYUSERINFO;
    return api;
}



-(void)HttpPostAsync:(NSString *)url parameter:( NSString *)parameter cb:(HttpGetDataCb )cb
{
    NSString* encodedString =@"接口";
    
    NSURL *theURL = [NSURL URLWithString:encodedString];
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc]initWithURL:theURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:120];
    NSString *post = nil;
    post = [[NSString alloc] initWithFormat:@"%@",parameter];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [theRequest setHTTPMethod:@"POST"];
    
    [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPBody:postData];
    
    NSLogs(@"请求长度为===%@\n,encodedString==%@\n,post===%@\n,theRequest==%@",postLength,encodedString,post,theRequest);

    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:theRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        cb(dict);
    }];
    
    [dataTask resume];
}


@end
