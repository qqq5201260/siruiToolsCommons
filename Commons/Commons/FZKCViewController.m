//
//  ViewController.m
//  Commons
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCViewController.h"

#import "FZKCPayViewController.h"

@interface FZKCViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

//功能测试数组
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation FZKCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"功能测试";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController *vc;
    
    switch (indexPath.row) {
        case 0:
            vc = [FZKCPayViewController initVCWithStoryboardName:nil];
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        [_dataArray addObjectsFromArray:@[@"支持测试"]];
    }
    return _dataArray;
}

@end
