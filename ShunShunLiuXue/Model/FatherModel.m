//
//  FatherModel.m
//  ChuanDaZhi
//
//  Created by hers on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FatherModel.h"
#import "ASINetworkQueue.h"
#import "Define.h"


@implementation FatherModel
@synthesize modelDelegate = _modelDelegate;
@synthesize queue = _queue;
@synthesize request = _request;
@synthesize formDataRequest = _formDataRequest;

- (id)initWithDelegate:(id)_delegate
{
    if ( self = [super init] ) {
        _modelDelegate = _delegate;
        [ASIHTTPRequest setDefaultCache:[ASIDownloadCache sharedCache]];
    }
    return self;
}
- (void)dealloc
{
    if(_modelDelegate){
        _modelDelegate = nil;
    }
    [self cancel];
    
    [super dealloc];
}

- (void)cancel
{
    [[self queue]cancelAllOperations];
    [[self request] clearDelegatesAndCancel];
    [[self formDataRequest] clearDelegatesAndCancel];
    [self setRequest:nil];
    [self setFormDataRequest:nil];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)get:(NSString*)aURL 
httpRequestSuccess:(SEL)httpRequestSucceed 
httpRequestFailed:(SEL)httpRequestFailed
{
    NSLog(@"url=%@",aURL);
    NSURL *url = [NSURL URLWithString:aURL];
    [self setRequest:[ASIHTTPRequest requestWithURL:url]];
    [[self request] setShouldAttemptPersistentConnection:NO];
    [[self request] setUseCookiePersistence:YES];
    [[self request] setDelegate:self.modelDelegate];
    [[self request] setTimeOutSeconds:15];
    [[self request] setDidFinishSelector:httpRequestSucceed];
    [[self request] setDidFailSelector:httpRequestFailed];
    [[self request] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)post:(NSString*)aURL 
 dataString:(NSString*)dataString
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed;
{
    [self post:aURL 
          data:[dataString dataUsingEncoding:NSUTF8StringEncoding] 
   extraParams:nil httpRequestSuccess:httpRequestSucceed httpRequestFailed:httpRequestFailed];
}

-(void)post:(NSString*)aURL 
     params:(NSDictionary *) params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    for (NSString *key in params.allKeys) {
        [[self formDataRequest] setPostValue:[params objectForKey:key] forKey:key];
    }
    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setTimeOutSeconds:3*60];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)post:(NSString*)aURL
   dataArray:(NSArray*)aDataArray
 extraParams:(NSDictionary *) params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    for (NSString *key in params.allKeys) {
        [[self formDataRequest] setPostValue:[params objectForKey:key] forKey:key];
    }
    
    NSString *fileKey;
    for(int i=0; i<[aDataArray count]; i++){
        NSData *imageData = [NSData dataWithData:[aDataArray objectAtIndex:i]];
        if(i == 0)
            fileKey = @"pic";
        else
            fileKey = [NSString stringWithFormat:@"pic%d",i];
        
        [[self formDataRequest] addData:imageData withFileName:@"avatarBg.jpg" andContentType:@"image/jpeg" forKey:fileKey];
    }

    [[self formDataRequest] setTimeOutSeconds:3*60];
    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


//传头像
- (void)postAvatar:(NSString*)aURL
              data:(NSData *)data
httpRequestSuccess:(SEL)httpRequestSucceed
 httpRequestFailed:(SEL)httpRequestFailed{
    
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    [[self formDataRequest] setData:data withFileName:@"avatar.png" andContentType:@"image/jpeg" forKey:@"avatar"];
    
    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

//发帖上传图片同步到腾讯微博
- (void)post:(NSString*)aURL
        data:(NSData *)data
 extraParams:(NSDictionary *) params
httpRequestSuccess:(SEL)httpRequestSucceed
httpRequestFailed:(SEL)httpRequestFailed
{
    NSString *URL = (NSString*)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)aURL, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
    [URL autorelease];
	NSURL *finalURL = [NSURL URLWithString:URL];
    [[self formDataRequest] cancel];
    [self setFormDataRequest:[ASIFormDataRequest requestWithURL:finalURL]];
    for (NSString *key in params.allKeys) {
        [[self formDataRequest] setPostValue:[params objectForKey:key] forKey:key];
    }
    [[self formDataRequest] setData:data withFileName:@"avatar.jpg" andContentType:@"image/jpeg" forKey:@"pic"];
    
    [[self formDataRequest] setDelegate:self.modelDelegate];
    [[self formDataRequest] setDidFinishSelector:httpRequestSucceed];
    [[self formDataRequest] setDidFailSelector:httpRequestFailed];
    
    [[self formDataRequest] startAsynchronous];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

@end
