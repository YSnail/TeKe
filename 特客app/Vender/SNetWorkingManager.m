//
//  SNetWorkingManager.m
//  特客app
//
//  Created by 姚斯宁 on 2017/8/15.
//  Copyright © 2017年 姚斯宁. All rights reserved.
//

#import "SNetWorkingManager.h"

typedef NS_ENUM(NSInteger,RequestType) {
    RequestTypeGet,
    RequestTypePost,
};
//网络请求状态 -1 位置网络
static NSInteger networkStatus = -1;

@implementation SNetWorkingManager

//网络判断
+ (void)checkNetworkStatus {
    AFNetworkReachabilityManager* reachability = [AFNetworkReachabilityManager sharedManager];
    
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        networkStatus = status;
        switch (networkStatus) {
            case -1:
                NSLog(@"未知网络");
            case 0:
                NSLog(@"没有网络");
            case 1:
                NSLog(@"3G/4G");
            case 2:
                NSLog(@"WIFI");
                break;
            default:
                break;
        }
    }];
    [reachability startMonitoring];
}

#pragma --GET请求--

+ (void)GetRequestUrl:(NSString*)urlString parameters:(id)parameters succeed:(void(^)(id data))succeed fail:(void(^)(NSError *error))fail {
    [self RequestType:RequestTypeGet url:urlString parameters:parameters succeed:succeed fail:fail];
}

#pragma --POST请求--

+ (void)PostRequestUrl:(NSString*)urlString parameters:(id)parameters succeed:(void(^)(id data))succeed fail:(void(^)(NSError *error))fail {
    [self RequestType:RequestTypePost url:urlString parameters:parameters succeed:succeed fail:fail];
}

#pragma --网络请求--

+(void)RequestType:(RequestType)type url:(NSString*)uslString parameters:(id)parameters succeed:(void(^)(id data))succeed fail:(void(^)(NSError *error))fail {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (type == RequestTypeGet) {
        [manager GET:uslString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (succeed) {
                succeed(dict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
    }else{
        [manager POST:uslString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            id dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            if (succeed) {
                succeed(dict);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (fail) {
                fail(error);
            }
        }];
    }
}
@end
