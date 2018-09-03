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
    
    NSString *preContent = @"   尊敬的匀富会员：\n   你们好！\n   为配合国家互联网政策调整，确保平台用户功能的正常使用。匀富平台自7月份以来针对平台功能技术板块执行开发调整。\n   但至今系统仍存在结算不稳定、订单丢失、商家贷款重复结算及用户资产结算错误等问题。解决这些问题的难点在于确保系统的正常使用，最大程度的保护用户权益，导致技术人员不敢对系统做整体架构升级，对系统结构做大的拆分。\n   因此至今无法做到系统完善，造成了市场用户一些功能无法实现及系统出现众多错误，也给众多用户带来更大抱怨，使公司进展很被动。\n   匀富至今坚持不忘初心、全力解决系统及市场问题，特作出以下决策：\n   匀富平台将于9月4日停止平台系统各项功能使用，技术并执行为期2个月的平台整体架构拆分开发， 修复框架订单板块拆分、用户板块拆分、核算体系拆分、商家后台拆分、营销板块独立拆分及各版块功能修复；将实现商城分布构造、解决用户账户合并、匀富链市值流通、消费兑现妙结、人人开店及APP商城独立分布等重大技术革新。\n   匀富不忘初心、始终坚信技术稳定、平台功能庞大才能做大做强；此次预期2个月的系统调整给各市场用户带来不便，为此我们真心的期待大家谅解。为了给大家提供更好地服务，我司将于2018年11月4日完成新系统升级上线，请市场用户互相转告。系统开发修复期间，将出现APP登录闪退及无法登录、如有紧急需要处理的事宜，可通过拨打4001365008客服热线或添加客服微信号13823708468进行咨询。\n   此外，系统开发修复、升级完成后，我们将在第一时间内于公告进行通知。\n   给您带来的不便，敬请谅解！\n";
    NSMutableParagraphStyle *preStyle  = [[NSMutableParagraphStyle alloc] init];
    preStyle.alignment = NSTextAlignmentLeft;

    
    NSString *sufContent = @"匀富尚品\n2018年9月3日";
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",preContent, sufContent]];
    NSMutableParagraphStyle *sufStyle  = [[NSMutableParagraphStyle alloc] init];
    sufStyle.alignment = NSTextAlignmentRight;


    [attString setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor darkGrayColor],NSParagraphStyleAttributeName :preStyle} range:NSMakeRange(0, preContent.length)];
    [attString setAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17], NSForegroundColorAttributeName: [UIColor darkGrayColor],NSParagraphStyleAttributeName :sufStyle} range:NSMakeRange(preContent.length, sufContent.length)];
    
    self.datas = @[@{@"title":@"匀富尚品公号",@"content":attString},
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
//    [RLAlertView showAlertWithTitle:dict[@"title"] message:dict[@"content"] completion:^(NSInteger buttonIndex) {
//        
//    }];
    [RLAlertView showAlertWithTitle:dict[@"title"] subTitle:@"技术开发修复通知" message:nil attMessage:dict[@"content"] buttonTitles:@[@"取消"] completion:^(NSInteger buttonIndex) {
        
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
//    cell.detailTextLabel.text = dict[@"content"];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
