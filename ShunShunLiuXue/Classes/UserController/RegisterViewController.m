//
//  RegisterViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "RegisterViewController.h"
#import "PublicClassMethod.h"
#import "ConstObject.h"
#import "InputItemModel.h"
#import "UITempletViewController.h"
#import "BindRegisterViewController.h"
#import "QL_HexColor.h"
#import "LoginViewController.h"
#import "Define.h"

@interface RegisterViewController ()<inputModelDelegate,UITextFieldDelegate>
{
    BOOL _btnState;//验证码按钮状态  yes可以点击  no不可以点
//    BOOL _butclick;//确认button是否点击过  yes点击过了,no没点击过
    NSTimer *_countdown;//计时器
    NSInteger _timeCount;//时间
    
    UIButton *readButton;
    BOOL hasReadAgreement;
    UIButton *readTitleButton;
}
@property(nonatomic,assign) NSTimer *timer;
@property (nonatomic,strong) UIButton *yanzhengButton;

@end

@implementation RegisterViewController
@synthesize phoneTextField;
@synthesize yanZhengTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _btnState = YES;
    _timeCount = 59;
//    [super initNavBarItems:@"注册"];
//    [super addButtonReturn:@"returnPic" lightedImage:@"returnLighted" selector:@selector(doReturn)];
     self.view.backgroundColor = COLOR1(255,255,255);
    [self showHeaderView];
    [self createMainUI];
//    if (self.type == getVerificationCode){
////    [self layoutView];
//    }
}

-(void)showHeaderView{
    
    [self createNavWithTitle:@"注册" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 1)
         {
         }else  if (nIndex == 2)
         {
             //左侧提问按钮
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             [btn setFrame:CGRectMake(10, self.navView.height - 35, 25, 25)];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnPic"] forState:UIControlStateNormal];
             [btn setBackgroundImage:[UIImage imageNamed:@"returnLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(doReturn) forControlEvents:UIControlEventTouchUpInside];
             btn.showsTouchWhenHighlighted = YES;
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }
         return nil;
     }];
    
}

-(void)createMainUI{

    NSArray *tempArray = @[@"账号",@"验证码",@"设置密码",@"姓名"];
    NSArray *placeHolderTextArray = @[@"手机号",@"请输入验证码",@"不少于六位",@"真实姓名"];

    // 用户名 登录密码
    for (int i = 0; i < 4; i++) {
        
        InputItemModel *input = [[InputItemModel alloc] initWithFrame:CGRectMake(20,20+50 + (i+1) *44 , kScreenWidth-40, 45) iconImage:[tempArray objectAtIndex:i] text:@"" placeHolderText:[placeHolderTextArray objectAtIndex:i]];
        
        [self.view addSubview:input];
        if (i == 0) {
            self.phoneTextField = input.textField;
            self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
        }else if (i==1){
        
            self.yanZhengTextField = input.textField;
            self.yanZhengTextField.keyboardType =UIKeyboardTypeNumberPad;
        }else if (i==2){
            self.passwordTextField = input.textField;
            self.passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
        }else{
            self.nameTextField = input.textField;
            self.nameTextField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        UIImageView *bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,20+68+(i+1)*42+14 , kScreenWidth-40, 0.5)];
        bottomLineImageView.backgroundColor = COLOR1(227, 227, 227);
        //        bottomLineImageView.image = [UIImage imageNamed:@"dixian"];
        [self.view addSubview:bottomLineImageView];
//        [bottomLineImageView release];
    }
    
    
    //注册账号
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(20, 267+44 , kScreenWidth-40, 44);
    [registBtn setBackgroundColor:COLOR1(255, 62, 48)];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    registBtn.tag = 3;
    registBtn.layer.masksToBounds = YES;
    registBtn.layer.cornerRadius = 5.0f;
    registBtn.layer.borderColor = COLOR(219, 219, 219).CGColor;
    registBtn.layer.borderWidth = 0.5;
    
    [registBtn setTitle:@"提交" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    registBtn.showsTouchWhenHighlighted = YES;
    
    [self.view addSubview:registBtn];
    
    _yanzhengButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnState = YES;//可以被点击
//    _yanzhengButton.frame= CGRectMake(208*kScreenBounds.size.width/320, 35*kScreenBounds.size.width/320, 62*kScreenBounds.size.width/320, 33*kScreenBounds.size.width/320);
    _yanzhengButton.frame= CGRectMake(kScreenWidth-30-75, 37+50+44+20, 75, 33);
    [_yanzhengButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_yanzhengButton.titleLabel setFont: [UIFont systemFontOfSize:12]];
    [_yanzhengButton setTitleColor:COLOR(0x38, 0x3d, 0x49) forState:UIControlStateNormal];

    [_yanzhengButton setBackgroundImage:[UIImage imageNamed:@"yanzhengma"] forState:UIControlStateNormal];
    [_yanzhengButton setBackgroundImage:[UIImage imageNamed:@"yanzhengmaLighted"] forState:UIControlStateHighlighted];

    [_yanzhengButton addTarget:self action:@selector(yanzhengBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_yanzhengButton];
    
    readButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [readButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    [readButton addTarget:self action:@selector(changeBackgroundPic) forControlEvents:UIControlEventTouchUpInside];
    [readButton setFrame:CGRectMake(50*kScreenWidth/320, 220+44+20, 15, 15)];
    [self.view addSubview:readButton];
    
    readTitleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [readTitleButton setTitle:@"我已阅读并同意《顺顺留学服务条款》" forState:UIControlStateNormal];
    [readTitleButton addTarget:self action:@selector(readAgreement) forControlEvents:UIControlEventTouchUpInside];
    [readTitleButton.titleLabel setFont: [UIFont boldSystemFontOfSize:12]];
    [readTitleButton setTitleColor:COLOR(0x38, 0x3d, 0x49) forState:UIControlStateNormal];
    readTitleButton.showsTouchWhenHighlighted = YES;
    [readTitleButton setFrame:CGRectMake(readButton.right+5, readButton.frame.origin.y, 210, 12)];
    [self.view addSubview:readTitleButton];

}

//进入阅读条款界面
-(void)readAgreement{

     
}

//红色小图片事件
-(void)changeBackgroundPic{

    hasReadAgreement = !hasReadAgreement;
    if(hasReadAgreement){
    
        [readButton setBackgroundImage:[UIImage imageNamed:@"agreeLighted"] forState:UIControlStateNormal];
    }else
        [readButton setBackgroundImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];

}
/*
-(void)layoutView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(42*kScreenWidth/320, 31*kScreenBounds.size.width/320, kScreenWidth - 84*kScreenWidth/320-3*kScreenWidth/320, 73*kScreenBounds.size.width/320)];
    backView.layer.cornerRadius = 3.0f;
    backView.layer.masksToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
  
    
    self.phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake((42+10)*kScreenWidth/320, 31*kScreenBounds.size.width/320, kScreenWidth - 84*kScreenWidth/320-(3+10)*kScreenWidth/320, 36*kScreenBounds.size.width/320)];
    phoneTextField.placeholder = @"输入手机号";
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    phoneTextField.layer.borderWidth = 0.0f;
   // phoneTextField.layer.borderColor = [QL_HexColor hexStringToColor:@"#BDC7D8"].CGColor;
    phoneTextField.backgroundColor = [UIColor whiteColor];
    phoneTextField.font = [UIFont systemFontOfSize:13*kScreenWidth/320];
    phoneTextField.textAlignment= NSTextAlignmentLeft;
    phoneTextField.layer.masksToBounds = YES;
    phoneTextField.layer.cornerRadius = 3.0f;
    phoneTextField.delegate = self;
    [self.view addSubview:phoneTextField];
   
    
    self.yanZhengTextField = [[UITextField alloc]initWithFrame:CGRectMake((42+10)*kScreenWidth/320, 66*kScreenBounds.size.width/320, kScreenWidth - 84*kScreenWidth/320-(3+10)*kScreenWidth/320, 36*kScreenBounds.size.width/320)];
    yanZhengTextField.placeholder = @"输入验证码";
    yanZhengTextField.layer.borderWidth = 0.0f;
    yanZhengTextField.layer.borderColor = COLOR1(122, 122, 122).CGColor;
    yanZhengTextField.backgroundColor = [UIColor whiteColor];
    yanZhengTextField.font = [UIFont systemFontOfSize:13*kScreenWidth/320];
    yanZhengTextField.textAlignment= NSTextAlignmentLeft;
    yanZhengTextField.layer.masksToBounds = YES;
    yanZhengTextField.layer.cornerRadius = 3.0f;
    yanZhengTextField.delegate = self;
    [self.view addSubview:yanZhengTextField];
    

    
    UIButton *nextButton = [[UIButton alloc]init];
    nextButton.frame = CGRectMake(42*kScreenWidth/320, (66+36+11)*kScreenWidth/320, kScreenWidth - 84*kScreenWidth/320-3*kScreenWidth/320, 36*kScreenBounds.size.width/320);
    [nextButton setBackgroundColor:COLOR1(219, 219, 219)];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.layer.borderWidth = 0.0f;
    nextButton.layer.borderColor = COLOR1(220, 220, 220).CGColor;
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 3.0f;
    nextButton.titleLabel.font = [UIFont boldSystemFontOfSize:22*kScreenWidth/320];
    [nextButton addTarget:self action:@selector(clicknext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(42, 67*kScreenBounds.size.width/320, kScreenWidth - 87*kScreenWidth/320, 1)];
    [_lineImageView setBackgroundColor:COLOR1(251, 250, 251)];
    [self.view addSubview:_lineImageView];
    _time = 59;
 */



//}
-(void)yanzhengBtnClick:(UIButton*)button{
    if (_btnState) {
         [self getVerificationCode];
       //
    }
//    _butclick = YES;//点击过了...

}
-(void)changeBtnState:(UIButton*)btton{
    
    if (0 == _timeCount) {
        [_yanzhengButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        _yanzhengButton.userInteractionEnabled = YES;
        _btnState = YES;
        _timeCount=59;
        [_countdown invalidate];//结束计时器
        _countdown = nil;//滞空
        
    }else{
        [_yanzhengButton setTitle:[NSString stringWithFormat:@"%d秒后重取",_timeCount--] forState:UIControlStateNormal];
        _yanzhengButton.userInteractionEnabled = NO;
    }
}

//提交按钮
-(void)registBtnAction{
    
    if(!([self.passwordTextField.text length]>6)){
       //密码长度小于6
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码长度至少6位"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }else if (!([self.yanZhengTextField.text length]==4)){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的验证码"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    NSString *telephone = self.phoneTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *codeString = self.yanZhengTextField.text;
    NSString *nameString = self.nameTextField.text;
    
    NSDictionary *tempDic = [[NSDictionary alloc] initWithObjectsAndKeys:telephone,@"user_phone",password,@"password", nil];
    
    [commonModel requestRegister:tempDic httpRequestSucceed:@selector(requestRegisterSuccess:) httpRequestFailed:@selector(requestRegisterFailed:)];
    
}

-(void)requestRegisterSuccess:(ASIHTTPRequest *)request{

    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
//    NSString *result = [nsDic objectForKey: @"resultList"];
}

-(void)requestRegisterFailed:(ASIHTTPRequest *)request{
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
}

//-(void)clicknext{
//    if (!_butclick ){
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请先获取验证码"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//    
//}else if([self.yanZhengTextField.text length]>5 && [self.phoneTextField.text length] == 11){
//   
//        [[ConstObject instance] setCodeString:self.yanZhengTextField.text];
//        BindRegisterViewController *BindRegisterVC = [[BindRegisterViewController alloc]init];
//        [self.navigationController pushViewController:BindRegisterVC animated:YES];
//}else{
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请输入正确的验证码"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//        return;
//    }
//    
//}


// 获取验证码
- (void)getVerificationCode
{
    // TODO 判断 填写的手机号 是否为空 是否符合规则
    NSString *tempString = [self.phoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL isTelephone = [self validatePhoneNumber:tempString];
    if (isTelephone) {
        // 手机号合法
        if (!_countdown) {
            _countdown=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeBtnState:) userInfo:_yanzhengButton repeats:YES];
            
        }
        _btnState = NO;
//        _butclick = NO;
        NSDictionary *tempDic = [NSDictionary dictionaryWithObject:tempString forKey:@"user_phone"];
        [commonModel requestYanZhengMa:tempDic httpRequestSucceed:@selector(requestYanZhengMaSucceed:) httpRequestFailed:@selector(requestYanZhengMaFaild:)];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号不合法"  message:@"请重新输入手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
}

//alert消失
-(void)performDismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
//[self endTimer];
}
//-(void)endTimer{
//    
//    [_yanzhengButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [_countdown invalidate];//结束计时器
//    _countdown = nil;//滞空
//    
//}

//发送手机短信验证码
-(void)requestYanZhengMaSucceed:(ASIHTTPRequest *)request{
    NSDictionary *nsDic = [[NSDictionary alloc]init];
    nsDic  = [super parseJsonRequest:request];
//    NSString *result = [nsDic objectForKey: @"result"];
//    if ([result integerValue]==0) {
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送短信失败"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//        //[alert release];
//    }else if ([result integerValue]==-1){
//      
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号为空或者格式不正确"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//       // [alert release];
//
//    }else if ([result integerValue]==-2){
//
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"该用户已存在，重复注册"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//        //[alert release];
//        _btnState = YES;
////        _butclick = YES;
//        _timeCount = 0 ;
//
//    }
}
-(void)requestYanZhengMaFaild:(ASIHTTPRequest *)request{
    NSLog(@"失败====================");
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.phoneTextField resignFirstResponder];
    [self.yanZhengTextField resignFirstResponder];
}


////手机号
//-(BOOL)validatePhoneNumber:(NSString *)phoneNumber
//{
//    //    if ([[_codeDic objectForKey:@"code"] isEqualToString:CHINA_ZONE_ID]) {
//    NSString *phoneNumberRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,2,5-9]))\\d{8}$";
//    NSPredicate *phoneNumberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneNumberRegex];
//    return [phoneNumberTest evaluateWithObject:phoneNumber];
//    //    }
//    //    return YES;
//}
#pragma 正则验证手机号码
-(BOOL)validatePhoneNumber:(NSString *)phoneNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNumber] == YES)
        || ([regextestcm evaluateWithObject:phoneNumber] == YES)
        || ([regextestct evaluateWithObject:phoneNumber] == YES)
        || ([regextestcu evaluateWithObject:phoneNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(void)doReturn{
    
        //    [self dismissViewControllerAnimated:YES completion:nil];
        //    [self.navigationController popViewControllerAnimated:YES];
        if ([self respondsToSelector:@selector(presentingViewController)])
            [self dismissViewControllerAnimated:YES completion:nil];
        else
            [self.navigationController popViewControllerAnimated:YES];
        

}
@end
