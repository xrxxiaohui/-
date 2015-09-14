//
//  LoginViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "BindRegisterViewController.h"
//#import "ThirdPartChoicePageViewController.h"
//#import "ForgetPWViewController.h"
#import "AppDelegate.h"
#import "InputItemModel.h"
#import "Define.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    
}
@property (nonatomic, retain) NSDictionary *tempThirdDic;
@end

@implementation LoginViewController
@synthesize infoDictionary;
@synthesize userNameTextField;
@synthesize passwordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
//        [[ConstObject instance] setVc:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self showHeaderView];
    // Do any additional setup after loading the view.
//    self.title = @"世纪生活";
//    [super initNavBarItems:@"登录"];
//    [super addButtonReturn:@"returnPic" lightedImage:@"returnLighted" selector:@selector(toReturn)];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];

    //设置标题
    
    self.view.backgroundColor = COLOR(0xff, 0xff, 0xff);
    [ASIHTTPRequest setSessionCookies:nil];
    
    // 用户名 登录密码
    for (int i = 0; i < 2; i++) {
        
        InputItemModel *input = [[InputItemModel alloc] initWithFrame:CGRectMake(20,20+50 + (i+1) *44 , kScreenWidth-40, 45) iconImage:i==0?@"账号":@"密码" text:@"" placeHolderText:i==0?@"手机号":@"请输入密码"];
        
        [self.view addSubview:input];
        if (i == 0) {
            self.userNameTextField = input.textField;
            self.userNameTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        else
        {
            self.passwordTextField = input.textField;
            self.passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        UIImageView *bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20,20+70+(i+1)*42+12 , kScreenWidth-40, 0.5)];
        bottomLineImageView.backgroundColor = COLOR1(227, 227, 227);
//        bottomLineImageView.image = [UIImage imageNamed:@"dixian"];
        [self.view addSubview:bottomLineImageView];
//        [bottomLineImageView release];
    }

    passwordTextField.secureTextEntry = YES;
    
    NSMutableArray *textFieldsArray = [NSMutableArray arrayWithCapacity:1];
    [textFieldsArray addObject:self.userNameTextField];
    [textFieldsArray addObject:self.passwordTextField];
    
    self.userNameTextField.text = @"18519101347";
    self.passwordTextField.text = @"123456";

    // 登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(20, 0 + 210-64+44+20 , kScreenWidth-40, 45);
    [loginBtn setBackgroundColor:COLOR1(255, 62, 48)];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5.0f;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    loginBtn.tag = 1;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:loginBtn];
    
 /*
    // TODO 效果图没有标注 3.5的忘记密码和注册账号的 位置  现在暂时 自己定的
    NSInteger forget_B = kScreenHeight>480?188+top_H:128+top_H; // 按钮中心距离底部的距离
    //    忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(75, self.view.frame.size.height - forget_B - 20 , 60, 20);
    [forgetBtn setTitleColor:COLOR(0x6d, 0x6d, 0x6d) forState:UIControlStateNormal];
    [forgetBtn setTitleColor:COLOR(0x6d, 0x6d, 0x6d) forState:UIControlStateHighlighted];
    [forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    forgetBtn.tag = 2;
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    */
    //注册账号
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(20, loginBtn.bottom+15 , kScreenWidth-40, loginBtn.height);
    [registBtn setTitleColor:COLOR(0x7b, 0x83, 0x8e) forState:UIControlStateNormal];
    [registBtn setTitleColor:COLOR(0x7b, 0x83, 0x8e) forState:UIControlStateHighlighted];
    [registBtn.titleLabel setFont:[UIFont systemFontOfSize:17]];
    registBtn.tag = 3;
    registBtn.layer.masksToBounds = YES;
    registBtn.layer.cornerRadius = 5.0f;
    registBtn.layer.borderColor = COLOR(219, 219, 219).CGColor;
    registBtn.layer.borderWidth = 0.5;
    
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    registBtn.showsTouchWhenHighlighted = YES;

    [self.view addSubview:registBtn];
    
//    BOOL wxInstall = [WXApi isWXAppInstalled];
//    BOOL qqInstall = [TencentOAuth iphoneQQInstalled];
//    if(wxInstall && qqInstall){
//        // 微信 qq
//        UIButton *weinxinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        weinxinBtn.frame = CGRectMake(90, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
//        weinxinBtn.tag = 4;
//        [weinxinBtn setBackgroundImage:WINXIN_LOGIN_BG forState:UIControlStateNormal];
//        [weinxinBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:weinxinBtn];
//        
//        UIButton *QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        QQBtn.frame = CGRectMake(MRScreenWidth - 48 - 90, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
//        QQBtn.tag = 5;
//        [QQBtn setBackgroundImage:QQ_LOGIN_BG forState:UIControlStateNormal];
//        [QQBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:QQBtn];
//    }
//    else if (wxInstall && !qqInstall){
//        UIButton *weinxinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        weinxinBtn.frame = CGRectMake((MRScreenWidth-48)/2, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
//        weinxinBtn.tag = 4;
//        [weinxinBtn setBackgroundImage:WINXIN_LOGIN_BG forState:UIControlStateNormal];
//        [weinxinBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:weinxinBtn];
//    }
//    else if (!wxInstall && qqInstall){
//        UIButton *QQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        QQBtn.frame = CGRectMake((MRScreenWidth-48)/2, self.view.bounds.size.height-top_H - 40 - 48 , 48, 48);
//        QQBtn.tag = 5;
//        [QQBtn setBackgroundImage:QQ_LOGIN_BG forState:UIControlStateNormal];
//        [QQBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:QQBtn];
//    }
    
   
    
    // 添加手势  键盘消失
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];

}

-(void)showHeaderView{
    
    [self createNavWithTitle:@"登录" createMenuItem:^UIView *(int nIndex)
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
             [btn addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
             btn.showsTouchWhenHighlighted = YES;
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }
         return nil;
     }];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)oneBtnAction{

    self.userNameTextField.text = @"15810524230";//@"xrxxiaohui";
    self.passwordTextField.text = @"123456";//@"lixiaohui";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 按钮方法们

- (void)buttonAction:(UIButton *)sender
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    if (sender.tag == 1) {
        // 登录
        NSString *userNameString = self.userNameTextField.text;
        NSString *passwordString = self.passwordTextField.text;
        
        NSString *tempUserName = [userNameString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if([tempUserName isEqualToString:@""]||[userNameString isEqualToString:@""]){
            //用户名为空
            [super showMessageBox:self title:@"手机号不能为空" message:@"请输入正确的手机号！" cancel:nil confirm:@"确定"];
            return;
        }else{
            //密码为空
            NSString *tempPassword = [passwordString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if([tempPassword isEqualToString:@""]||[passwordString isEqualToString:@""]){
                //用户名为空
                [super showMessageBox:self title:@"密码不能为空" message:@"密码不能为空！" cancel:nil confirm:@"确定"];
                return;
            }else{
                //验证手机号是否正确
                BOOL isTelephone = [self validatePhoneNumber:tempUserName];
                
                if(!isTelephone){
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"手机号不合法"  message:@"请重新输入手机号" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alert show];
                    return;
                }

            }
        }
        self.infoDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
        [infoDictionary setValue:userNameString forKey:@"user_phone"];
        [infoDictionary setValue:passwordString forKey:@"password"];
        
        [super showMBProgressHUD:@"登录中..."];
        [commonModel requestLogin:infoDictionary httpRequestSucceed:@selector(requestLoginSuccess:) httpRequestFailed:@selector(requestFailed:)];
    }
//    else if (sender.tag == 2)
//    {
//        // forgetPawwword
//        ForgetPWViewController *forgetVC = [[[ForgetPWViewController alloc] init] autorelease];
//        forgetVC.page = forgetPage1;
//        [self.navigationController pushViewController:forgetVC animated:YES];
//    }
    else if (sender.tag == 3)
    {
        //regiest
        RegisterViewController *registViewController = [[RegisterViewController alloc] init];
//        registViewController.type = getVerificationCode;
        NSLog(@"%@",[SliderViewController sharedSliderController].navigationController);
//        [self.navigationController pushViewController:registViewController animated:YES];
        [self presentViewController:registViewController animated:YES completion:nil];
    }
//    else if (sender.tag == 4)
//    {
////        ThirdPartChoicePageViewController *registViewController = [[ThirdPartChoicePageViewController alloc] init];
////        registViewController.transforDic = self.tempThirdDic;
////        [self.navigationController pushViewController:registViewController animated:YES];
////        return;
//        //weixin login
//        [[AppDelegate shareDelegate] weixinLogin:self];
//    }
//    else if (sender.tag == 5)
//    {
//        //qq login
//        [[AppDelegate shareDelegate] tencentLogin:self];
//    }
    
}

- (void)pushToBindRegisterVc:(NSDictionary *)info
{
    self.tempThirdDic = info;
    if ([[info objectForKey:@"type"] isEqualToString:@"QQ"]) {
        NSDictionary *dic = @{@"qq_token":[info objectForKey:@"accessToken"],@"qq_openid_id":[info objectForKey:@"openId"],@"qq_user_username":[info objectForKey:@"nickName"]};
//        [self showGif];
        [commonModel requestCheckQQ_registrt:dic httpRequestSucceed:@selector(requestCheckSussess:) httpRequestFailed:@selector(requestCheckFail:)];
    }
    else {
        NSDictionary *dic = @{@"unionid":[info objectForKey:@"accessToken"],@"openid":[info objectForKey:@"openId"],@"nickname":[info objectForKey:@"nickName"]};
//        [self showGif];
        [commonModel requestCheckWX_registrt:dic httpRequestSucceed:@selector(requestCheckSussess:) httpRequestFailed:@selector(requestCheckFail:)];
    }
    
}

- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}



-(void)requestLoginSuccess:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
    NSDictionary *tempDic =[dic objectForKey:@"result"];
    NSString *tempStr = [tempDic objectForKey:@"status"];
    if([tempStr isEqualToString:@"01"]){
    
        NSDictionary *headDic =[dic objectForKey:@"header"];

        NSString *tempToken = [NSString stringWithFormat:@"%@",[headDic objectForKey:@"token"]];
        
        NSDictionary *businessDataDic =[tempDic objectForKey:@"businessData"];
        NSDictionary *accountDic =[businessDataDic objectForKey:@"account"];

        NSString *userid =[NSString stringWithFormat:@"%@",[accountDic objectForKey:@"uid"]];
        NSLog(@"登陆成功！");
        [self saveToken:tempToken andUserID:userid andAccountDic:accountDic];
      
        [self toReturn];
    }else{
    
        NSDictionary *tempDic2 =[tempDic objectForKey:@"error"];
        NSString *errorMessage = [tempDic2 objectForKey:@"errorMessage"];
        NSLog(@"%@",errorMessage);
    }
    
//    if ([[dic objectForKey:@"code"] intValue] == 200) {
//        NSLog(@"登陆成功！");
//        //已登陆
//        [[ConstObject instance] setIsLogin:YES];
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setObject:@"1" forKey:@"isLogin"];
//        [userDefaults synchronize];
//        NSInteger index = [[self.navigationController viewControllers] indexOfObject:[[ConstObject instance] vc]];
//        
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index-1] animated:YES];
//
//        return;
//    }else if ([[dic objectForKey:@"code"] intValue] == 1003){
//    
//        [super showMessageBox:self title:nil message:[dic objectForKey:@"msg"] cancel:nil confirm:@"确定"];
//        return;
//    }else if ([[dic objectForKey:@"code"] intValue] == 1004){
//        
//        [super showMessageBox:self title:nil message:[dic objectForKey:@"msg"] cancel:nil confirm:@"确定"];
//        return;
//    }
}
-(void)saveToken:(NSString *)token andUserID:(NSString*)userId andAccountDic:(NSDictionary *)accountDic{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [NSString stringWithFormat:@"%@",[documentsDirectory stringByAppendingPathComponent:@"token.plist"]];
    
    NSMutableArray *listArray = [[NSMutableArray alloc ] initWithContentsOfFile:plistPath];
    listArray = [NSMutableArray arrayWithCapacity:1];
    [listArray addObject:token];
    [listArray addObject:userId];
    
    NSString *userName = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"user_name"]];
    NSString *agree_count = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"agree_count"]];
    NSString *fans_count = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"fans_count"]];
    NSString *views_count = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"views_count"]];
    NSString *answerNum =[NSString stringWithFormat:@"%@",[accountDic objectForKey:@"answer_count"]];
    
    [listArray addObject:userName];
    [listArray addObject:agree_count];
    [listArray addObject:fans_count];
    [listArray addObject:views_count];
    [listArray addObject:answerNum];
    
    [listArray writeToFile:plistPath atomically:YES];
}

-(void)requestFailed:(ASIHTTPRequest *)request{
    [super hideMBProgressHUD];
    NSDictionary *dic = [super parseJsonRequest:request];
    NSLog(@"dic%@",dic);
}

-(void)toReturn{
  
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController popViewControllerAnimated:YES];
      [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshLeftView" object:nil];
    if ([self respondsToSelector:@selector(presentingViewController)])
        [self dismissViewControllerAnimated:YES completion:nil];
    else
        [self.navigationController popViewControllerAnimated:YES];

}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
