//
//  ViewModel.h
//  MVVM+RAC
//
//  Created by MK on 2018/6/22.
//  Copyright © 2018年 MK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"
@interface ViewModel : NSObject
@property(nonatomic, strong) Model *model;
@property(nonatomic, strong) RACCommand *command;
@end
