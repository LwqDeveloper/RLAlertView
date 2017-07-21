//
//  ViewController.m
//  RLAlertViewDemo
//
//  Created by mbp on 2017/7/21.
//  Copyright © 2017年 mbp. All rights reserved.
//

#import "ViewController.h"
#import "RLAlertView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *datas;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"RLAlertViewDemo";
    
    self.datas = @[@{@"title":@"这是一个标题",@"content":@""},
                   @{@"title":@"",@"content":@"今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热"},
                   @{@"title":@"这是一个标题",@"content":@"今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热今天好热"}];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.datas[indexPath.row];
    [RLAlertView showAlertWithTitle:dict[@"title"] message:dict[@"content"] completion:^(NSInteger buttonIndex) {
        
    }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ide = @"ide";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ide];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ide];
    }
    NSDictionary *dict = self.datas[indexPath.row];
    cell.textLabel.text = dict[@"title"];
    cell.detailTextLabel.text = dict[@"content"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
