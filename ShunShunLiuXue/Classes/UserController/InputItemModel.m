//
//  InputItemModel.m
//  sjsh
//
//  Created by 计生 杜 on 14/12/18.
//  Copyright (c) 2014年 世纪生活. All rights reserved.
//

#import "InputItemModel.h"

@implementation InputItemModel
@synthesize textField;
@synthesize loginLabel;

- (id)initWithFrame:(CGRect)frame iconImage:(NSString *)imageName text:(NSString *)text placeHolderText:(NSString *)placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
//        self.image = INPUT_BG;
//        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(12,10, 24, 24)];
//        icon.image = [UIImage imageNamed:imageName];
//        [self addSubview:icon];
//        self.iconImageView = icon;
//        [icon release];
        self.loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,0, 64, 16)];
        loginLabel.font =[UIFont systemFontOfSize:15];
        loginLabel.textColor = COLOR(0x7b, 0x83, 0x8e);
        loginLabel.text = imageName;
        CGSize labelSize = [imageName sizeWithFont:loginLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, loginLabel.frame.size.height)];
        [loginLabel setFrame:CGRectMake(10, 0, labelSize.width, 20)];

        [self addSubview:loginLabel];
        [loginLabel release];

        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(loginLabel.right+15, 3, 211, 16)];
        textField.font = [UIFont systemFontOfSize:15];
        textField.textColor =  COLOR(144, 138, 130);
        textField.delegate = self;
        textField.placeholder = placeholder;
        textField.text = text;
        [self addSubview:textField];
        [textField release];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.delegate &&[self.delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        [self.delegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.image = [UIImage imageNamed:@"input_bg_text"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length==0) {
//        self.image = INPUT_BG;
    }
}
@end
