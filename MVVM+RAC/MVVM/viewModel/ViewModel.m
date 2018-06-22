//
//  ViewModel.m
//  MVVM+RAC
//
//  Created by MK on 2018/6/22.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel
-(instancetype)init{
    if (self == [super init]) {
        [self bind];
    }
    return self;
}
- (void)bind{
    self.command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [self loadData:subscriber];
            return nil;
        }];
    }];
}
- (void)loadData:(id<RACSubscriber>  _Nonnull)subscriber{
    [SVProgressHUD show];
    //AFN
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlString = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html";
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 新闻字典数组
        NSArray *dictArray = responseObject[@"T1348647853363"];
        NSMutableArray *mArray = [NSMutableArray array];
        [dictArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Model *model = [[Model alloc]init];
            model.name = obj[@"title"];
            model.icon = obj[@"imgsrc"];
            [mArray addObject:model];
        }];
        [subscriber sendNext:mArray];
        [subscriber sendCompleted];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"连接错误"];
        [subscriber sendCompleted];
    }];
}
@end
