//
//  ConstObject.m
//  ChuanDaZhi
//
//  Created by Lee xiaohui on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConstObject.h"

@implementation ConstObject
@synthesize homeViewController;
@synthesize sinaLoginFrom,qqLoginFrom;
@synthesize isLogin,isFromQQFriendsInvite,isFromWXFriendsInvite,isHavePic,isWXFromExchangeGoodsPage,isWXFromZaShiWuPage,isWXFromFreeUseGoodsPage,isAddCoins_ExchangeGoodsSinaShare,isAddCoins_ExchangeGoodsTencentShare,isAddCoins_ExchangeGoodsWXShare,isAddCoins_ZaShiWuSinaShare,isAddCoins_ZaShiWuTencentShare,isAddCoins_ZaShiWuWXShare,isAddCoins_FreeUseGoodsWXShare,isAddCoins_FreeUseGoodsSinaShare,isAddCoins_FreeUseGoodsTencentShare,isReloadProductDetailData,isFromZaShiWuView,isFromFreeUseDetailPage,isFromExchangeGoodsPage,questionDetailWXShare,isQuestionDeatailQQShare,isQuestionDeatailWXFriOrWXCircleShare,isSystemMess_TQRichTextView,isSystemMessTitle_TQRichTextView,isBeforeWXFromFreeUseGoods,noShareWX_FreeUseApply;
@synthesize clickFrom;
@synthesize questionCount;
@synthesize messageCount;
@synthesize isHomePage;
@synthesize coinNumber,eggCoinCount;
@synthesize messageNavigationController;
@synthesize jinDanPic,userLocationInfo;
@synthesize jinDanTitle;
@synthesize reLoadHomeData,reLoadMessageData,reLoadWealthData,reLoadFreeUseData,reLoadMallData,reLoadSetData,reLoadProfileData,isReloadDiaryList,removeTQTextDelegate;
@synthesize isReloadCoins;
@synthesize DanImageString;
@synthesize afterImageString;
@synthesize tipString;
@synthesize upgradeGifString;
@synthesize isReloadData_MyFreeUsePage,photoRectFromZero,isNewUser;
//@synthesize imagePickerBar,urlArray,totalSelectedCount,returnToWhichPage,rectFromZero,rootScrollView,photoTipButton,hasAlertLogin,networkIsAvailable,presentLoginController;

+ (id)instance {
	static id obj = nil;
	if( nil == obj ) {
		obj = [[self alloc] init];
	}
	return obj;
}

- (id)init {
	if ((self = [super init])) {
	}
    
    return self;
}

- (void)setIsLogin:(BOOL)isThirdLogin{
    [[NSUserDefaults standardUserDefaults] setBool:isThirdLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLogin{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] boolValue];
}

- (NSString*)fileTextPath:(NSString*)fileName{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

-(void)dealloc
{
    
    [super dealloc];
}

@end
