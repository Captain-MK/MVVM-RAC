//
//  CustomCell.m
//  MVVM+RAC
//
//  Created by MK on 2018/6/22.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "CustomCell.h"
@interface CustomCell ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end
@implementation CustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(Model *)model{
    _model = model;
    self.lable.text = model.name;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.icon]];
}
@end
