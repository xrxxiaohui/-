//
//  RegisterViewController.h
//  sjsh
//
//  Created by 计生 杜 on 14-7-28.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITempletViewController.h"
#import "ConstObject.h"
#import "QHBasicViewController.h"

enum registType {
    getVerificationCode = 1,//获取验证码
    regist = 2,// 完成注册
    
};
@interface RegisterViewController : QHBasicViewController

@property (nonatomic, assign) enum registType type;
@property (nonatomic, retain) UITextField *phoneTextField;//手机号
@property (nonatomic, retain) UITextField *yanZhengTextField;//验证码
@property (nonatomic,retain) UIImageView *lineImageView;

@property (nonatomic, retain) UITextField *passwordTextField;//密码
@property (nonatomic, retain) UITextField *nameTextField;//姓名




@end
