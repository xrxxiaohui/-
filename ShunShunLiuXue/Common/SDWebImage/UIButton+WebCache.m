/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIButton+WebCache.h"
#import "SDWebImageManager.h"

@implementation UIButton (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    [self setBackgroundImage:placeholder forState:UIControlStateNormal];

    if (url)
    {
        [manager downloadWithURL:url delegate:self];
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}
- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
        image = [UIImage imageWithCGImage:image.CGImage scale:0 orientation:UIImageOrientationUp];
       [self setBackgroundImage:image forState:UIControlStateNormal];
}
- (void)webImageManager:(SDWebImageManager *)imageManager didFailWithError:(NSError *)error
{
   // [self setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
}
@end
