//
//  MainViewController.m
//  RAC+MVVM
//
//  Created by 曹鹏飞 on 2019/4/28.
//  Copyright © 2019 jjs. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITextFieldDelegate>
//
@property (nonatomic,strong) UIButton * testBtn;
//
@property (nonatomic,strong) UILabel * testLabel;
//
@property (nonatomic,strong) UITextField * testTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.testLabel = [[UILabel alloc]init];
    [self.view addSubview:self.testLabel];
    self.testLabel.text = @"测试RAC";
    [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(120);
    }];
    self.testBtn = [[UIButton alloc]init];
    [self.testBtn setTitle:@"RAC测试按钮" forState:UIControlStateNormal];
    self.testBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.testBtn];
    [self.testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.testLabel.mas_bottom).offset(30);
    }];
    self.testTextField = [[UITextField alloc]init];
    self.testTextField.placeholder = @"测试一下";
    self.testTextField.text = @"24214";
    [self.view addSubview:self.testTextField];
    [self.testTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.testBtn.mas_bottom).offset(30);
    }];
    //按钮点击事件响应
//    [self clickTestBtn];
//    [self RACBtnClick];
    //kvo 监听属性
//    [self kvo_method];
    [self RACKvo_method];
    
    
    
    
}
-(void)RACKvo_method{
    [RACObserve(self.testTextField, text)subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.testTextField resignFirstResponder];
}
-(void)kvo_method{
    [self.testTextField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"] && object ==self.testTextField) {
        NSLog(@"%@",change);
    }
}
-(void)RACBtnClick{
    [[self.testBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"RAC点击了按钮");
        NSLog(@"%@",x);
    }];
}
-(void)clickTestBtn{
    [self.testBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnClick{
    NSLog(@"b普通按钮点击");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
