//
//  LoginViewController.m
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "BindRegisterViewController.h"
#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "BindViewController.h"
#import "InputItemModel.h"
#import "QL_HexColor.h"
#import "UITempletViewController.h"

#import "LoginViewController.h"

@interface BindRegisterViewController ()<inputModelDelegate>

@end

@implementation BindRegisterViewController
@synthesize infoDictionary;
@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize surepassWordTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super initNavBarItems:@"快速注册"];
    [super addButtonReturn:@"backButton" hoverImage:@"backButton" selector:@selector(toReturn)];
    self.view.backgroundColor = COLOR1(245,245,245);

//
//  
// // 设置标题
// 
//    
////    self.navigationController.navigationBarHidden = YES;
//    
////    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
////    bgImageView.image = IPHONE5?LOGIN_BG_568h:LOGIN_BG;
////    [self.view addSubview:bgImageView];
////    [bgImageView release];
//    /********隐藏导航栏，自己定做标题及按钮，下面加一条白线，以达到效果图所示效果***********/
////    UILabel *aTitleLabel = nil;
////    
////    if (kSystemIsIOS7) {
////        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 20.0f, 200.0f, 43.0f)];
////    }
////    else{
////        aTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 0.0f, 200.0f, 43.0f)];
////    }
////    aTitleLabel.text = @"世纪生活";
////    aTitleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
////    aTitleLabel.textAlignment = NSTextAlignmentCenter;
////    aTitleLabel.backgroundColor = [UIColor clearColor];
////    aTitleLabel.adjustsFontSizeToFitWidth = YES;
////    aTitleLabel.textColor = COLOR(255, 255, 255);
////    [self.view addSubview:aTitleLabel];
////    [aTitleLabel release];
////    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"世纪生活_white"]];
////    if (IOS7_OR_LATER) {
////        titleView.frame = CGRectMake(60.0f, 20.0f, 200.0f, 43.0f);
////    }
////    else {
////        titleView.frame = CGRectMake(60.0f, 0.0f, 200.0f, 43.0f);
////    }
////    titleView.backgroundColor = [UIColor clearColor];
////    titleView.contentMode = UIViewContentModeCenter;
////    [self.view addSubview:titleView];
////    [titleView release];
////    
////    UIView *lineView = nil;
////    if (IOS7_OR_LATER) {
////        lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 63.0f, 320.0f, 0.5f)];
////    }
////    else {
////       lineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 43.0f, 320.0f, 0.5f)];
////    }
////    
////    lineView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.2];
////    [self.view addSubview:lineView];
////    [lineView release];
////    
////    UIButton *closeButton = [UIButton  buttonWithType:UIButtonTypeCustom];
////    [closeButton setTintColor:[UIColor whiteColor]];
////    closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
////    [closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
////    [closeButton setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateHighlighted];
////    [closeButton addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
////    if (kSystemIsIOS7) {
////        closeButton.frame = CGRectMake(255.0f, 20.0f, 60,44);
////    }
////    else{
////        closeButton.frame = CGRectMake(255.0f, 0.0f, 60,44);
////    }
////    [self.view addSubview:closeButton];
////    [closeButton release];
//    /******************/
//    int startY = 17;
//    // 用户名 登录密码
//    for (int i = 0; i < 3; i++) {
////        UIImageView *inputImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35,i *59 + 41, 250, 44)];
////        inputImageView.image = INPUT_BG;
////        [self.view addSubview:inputImageView];
////        
////        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(35, i *59 + 41, 44, 44)];
////        icon.image = i==0?ACCOUNT_BG:PASSWORD_BG;
////        [self.view addSubview:icon];
////        
////        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(35 + 44,  i *59 + 41, 211, 44)];
////        textField.font = [UIFont systemFontOfSize:14];
////        textField.textColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5];
//        // TODO 设置placeholder 颜色
//        
//        CGRect rect = CGRectMake(35,startY+60*i, 250, 44);
//        switch (i) {
//            case 0:
//            {
//                InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"yanzhengma" text:@"" placeHolderText: @"输入昵称"];
//                //  输入框
//                input.delegate = self;
//                [self.view addSubview:input];
//                self.userNameTextField = input.textField;
//                self.userNameTextField.layer.borderColor = [QL_HexColor hexStringToColor:@"#BDC7D8"].CGColor;
//                
//
//            }
//                break;
//            case 1:
//            {
//                InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"password" text:@"" placeHolderText: @"输入密码"];
//                //  输入框
//                input.delegate = self;
//                [self.view addSubview:input];
//                self.passwordTextField = input.textField;
//                self.passwordTextField.secureTextEntry = YES;
//                self.passwordTextField.keyboardType = UIKeyboardTypeEmailAddress;
//
//                
//            }
//                break;
//            case 2:
//            {
//                InputItemModel *input = [[InputItemModel alloc] initWithFrame:rect iconImage:@"password" text:@"" placeHolderText: @"再次输入密码"];
//                //  输入框
//                input.delegate = self;
//                [self.view addSubview:input];
//                self.repeatPasswordTextField = input.textField;
//                self.repeatPasswordTextField.secureTextEntry = YES;
//                self.repeatPasswordTextField.keyboardType = UIKeyboardTypeEmailAddress;
//
//            }
//                break;
//            default:
//                break;
//        }
//        
//    }
 
    
     
//    // 登录按钮
//    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    loginBtn.frame = CGRectMake(35,  startY+60*3+20 , 250, 44);
//    [loginBtn setBackgroundImage:LOGIN_BTN_BG forState:UIControlStateNormal];
//    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [loginBtn.titleLabel setFont:[UIFont systemFontOfSize:20]];
//    loginBtn.tag = 1;
//    [loginBtn setTitle:@"立即注册" forState:UIControlStateNormal];
//    [loginBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginBtn];
//    

    [self layoutView];
    
    // 添加手势  键盘消失
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];

}
-(void)layoutView{
    userNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(42*kScreenBounds.size.width/320, 30*kScreenBounds.size.width/320, self.view.bounds.size.width - 94*kScreenBounds.size.width/320, 37*kScreenBounds.size.width/320)];
    userNameTextField.placeholder = @" 请输入昵称";
    userNameTextField.layer.borderWidth = 0.0f;
    //userNameTextField.layer.borderColor = [QL_HexColor hexStringToColor:@"#BDC7D8"].CGColor;
    userNameTextField.backgroundColor = [UIColor whiteColor];
    
    userNameTextField.font = [UIFont systemFontOfSize:15];
    userNameTextField.textAlignment= NSTextAlignmentLeft;
    userNameTextField.layer.masksToBounds = YES;
    userNameTextField.layer.cornerRadius = 5.0f;
    [self.view addSubview:userNameTextField];
    
    
    passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(42*kScreenBounds.size.width/320, 67.5*kScreenBounds.size.width/320, self.view.bounds.size.width - 94*kScreenBounds.size.width/320, 37*kScreenBounds.size.width/320)];
    passwordTextField.placeholder = @" 请输入密码";
    passwordTextField.secureTextEntry = YES;
    
    passwordTextField.layer.borderWidth = 0.0f;
   // passwordTextField.layer.borderColor = [QL_HexColor hexStringToColor:@"#BDC7D8"].CGColor;
    passwordTextField.backgroundColor = [UIColor whiteColor];
    passwordTextField.font = [UIFont systemFontOfSize:15];
    passwordTextField.textAlignment= NSTextAlignmentLeft;
    passwordTextField.layer.masksToBounds = YES;
    passwordTextField.layer.cornerRadius = 5.0f;
    [self.view addSubview:passwordTextField];
    
    surepassWordTextField = [[UITextField alloc]initWithFrame:CGRectMake(42*kScreenBounds.size.width/320, 105*kScreenBounds.size.width/320, self.view.bounds.size.width - 94*kScreenBounds.size.width/320, 37*kScreenBounds.size.width/320)];
    surepassWordTextField.placeholder = @" 请再次输入密码";
    surepassWordTextField.layer.borderWidth = 0.0f;
    surepassWordTextField.secureTextEntry = YES;
    
    //surepassWordTextField.layer.borderColor = [QL_HexColor hexStringToColor:@"#BDC7D8"].CGColor;
    surepassWordTextField.backgroundColor = [UIColor whiteColor];
    surepassWordTextField.font = [UIFont systemFontOfSize:15];
    surepassWordTextField.textAlignment= NSTextAlignmentLeft;
    surepassWordTextField.layer.masksToBounds = YES;
    surepassWordTextField.layer.cornerRadius = 5.0f;
    [self.view addSubview:surepassWordTextField];
    
    UIButton *nextButton = [[UIButton alloc]init];
    nextButton.frame = CGRectMake(42*kScreenBounds.size.width/320, 152*kScreenBounds.size.width/320, self.view.bounds.size.width - 94*kScreenBounds.size.width/320, 37*kScreenBounds.size.width/320);
    [nextButton setBackgroundColor:[QL_HexColor hexStringToColor:@"#e5e5e5"]];
    [nextButton setTitle:@"注册" forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextButton.layer.borderWidth = 0.0f;
    nextButton.layer.borderColor = [QL_HexColor hexStringToColor:@"#BDC7D8"].CGColor;
    nextButton.layer.masksToBounds = YES;
    nextButton.layer.cornerRadius = 5.0f;
    nextButton.titleLabel.font = [UIFont systemFontOfSize:24];
    [nextButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    

}




//-(void)oneBtnAction{
//
//    self.userNameTextField.text = @"15810524230";//@"xrxxiaohui";
//    self.passwordTextField.text = @"123456";//@"lixiaohui";
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮方法们

- (void)buttonAction:(UIButton *)sender
{
    NSLog(@"----%@",[[ConstObject instance] telephoneNumber]);

    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [surepassWordTextField resignFirstResponder];
 
    NSString *userNameString = self.userNameTextField.text;
     userNameString=[userNameString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *passwordString = self.passwordTextField.text;
    NSString *surePasswordString = self.surepassWordTextField.text;

        if([self.userNameTextField.text isEqualToString:@""]||[userNameString isEqualToString:@""]){
  
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名不能为空" message:@"请输入正确的用户名！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }else{
            //密码为空
            if([passwordString isEqualToString:@""]||[surePasswordString isEqualToString:@""]){
                //mi密码为空

                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码不能为空" message:@"请输入正确的密码！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return;
            }
            else if([passwordString isEqualToString:surePasswordString] == NO){
  
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码不一致" message:@"请重新输入密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alert show];
                return;

            }
        }
    NSString *tempCode = [[ConstObject instance] codeString];
    NSString *tempTel =[[ConstObject instance] telephoneNumber];
//    NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:userNameString,@"nickname",passwordString,@"password",tempCode,@"code", nil];
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    [tempArray addObject:tempTel];
    [tempArray addObject:userNameString];
    [tempArray addObject:passwordString];
    [tempArray addObject:tempCode];
    
    [commonModel requestCompleteRegister:tempArray httpRequestSucceed:@selector(requestRegisterCompleteSuccess:) httpRequestFailed:@selector(requestRegisterFailed:) ];
    

}
//验证手机验证码  成功
-(void)requestRegisterCompleteSuccess:(ASIHTTPRequest *)request{
    NSDictionary *dic = [super parseJsonRequest:request];
    int intString = [[dic objectForKey:@"uid"] intValue];
    //    if (intString > 0) {
    //        NSLog(@"注册成功");
    //
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注册成功"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    //        [alert show];
    //
    //            //2maio后返回登陆界面
    //        [self performSelector:@selector(popLoginVC) withObject:nil afterDelay:2.0];
    //
    //
    //    }
    if ([[dic objectForKey:@"uid"] integerValue]==-1) {
        NSLog(@"用户名格式不正确或已存在");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"用户名格式不正确或已存在"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else if ([[dic objectForKey:@"uid"] integerValue]==-2){
        NSLog(@"昵称格式不正确");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"昵称格式不正确"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }else if ([[dic objectForKey:@"uid"] integerValue]==-3){
        NSLog(@"密码格式不正确");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"密码格式不正确"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if ([[dic objectForKey:@"uid"] integerValue]==-4){
        NSLog(@"验证码失效");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"验证码失效或不正确"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if ([[dic objectForKey:@"uid"] integerValue]==0){
        NSLog(@"未知错误");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"未知错误"  message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else if (intString > 0) {
        NSLog(@"注册成功");
        
        //         UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        //        [alert dismissWithClickedButtonIndex:0 animated:YES];
        //        [alert show];
        //
        //        //2maio后返回登陆界面
        //        [self performSelector:@selector(popLoginVC) withObject:nil afterDelay:2.0];
        UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert1 show];
        [alert1 dismissWithClickedButtonIndex:0 animated:YES];
        [self performSelector:@selector(popLoginVC) withObject:nil afterDelay:2.0];
        
    }
    
    
    
}
//失败
-(void)requestRegisterFailed:(ASIHTTPRequest *)request{
       // NSDictionary *dic = [super parseJsonRequest:request];
}




-(void)performDismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

-(void)popLoginVC{
     LoginViewController *loginVC = [[LoginViewController alloc]init];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]
                                          animated:YES];
}

- (void)handleTap:(UITapGestureRecognizer*)aTapGesture
{
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.surepassWordTextField resignFirstResponder];
}


-(void)toReturn{

    [self.navigationController popViewControllerAnimated:YES];
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
