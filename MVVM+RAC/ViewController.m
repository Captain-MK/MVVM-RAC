//
//  ViewController.m
//  MVVM+RAC
//
//  Created by MK on 2018/6/22.
//  Copyright © 2018年 MK. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "CustomCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *mainTable;
@property(nonatomic, strong) ViewModel *VM;
@property (nonatomic, strong, nullable) NSMutableArray *dataList;
@end

@implementation ViewController
-(void)dealloc{
    NSLog(@"dealloc-ViewController");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainTable];
    // Do any additional setup after loading the view, typically from a nib.
    [[self.VM.command execute:nil] subscribeNext:^(NSArray*  _Nullable x) {
        self.dataList = x.copy;
        [self.mainTable reloadData];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - ========lazy========
-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
-(ViewModel *)VM{
    if (!_VM) {
        _VM = [[ViewModel alloc]init];
    }
    return _VM;
}
-(UITableView *)mainTable{
    if (!_mainTable) {
        _mainTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.tableFooterView = [UIView new];
        [_mainTable registerNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] forCellReuseIdentifier:@"CustomCell"];
    }
    return _mainTable;
}
@end
