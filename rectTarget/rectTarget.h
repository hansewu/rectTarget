//
//  rectTarget.h
//  rectTarget
//
//  Created by wzq on 1/19/22.
//

#import <Foundation/Foundation.h>

//! Project version number for rectTarget.
FOUNDATION_EXPORT double rectTargetVersionNumber;

//! Project version string for rectTarget.
FOUNDATION_EXPORT const unsigned char rectTargetVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <rectTarget/PublicHeader.h>
@interface YoloProcess : NSObject

- (void)loadModel;
-(NSString *)predictImage:(NSImage *)image outPose:(CGRect *)outPose;

@end


