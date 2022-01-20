//
//  YoloProcess.h
//  rectTarget
//
//  Created by apple on 1/19/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YoloProcess : NSObject

- (void)loadModel;
-(NSString *)predictImage:(NSImage *)image outPose:(CGRect *)outPose;

@end

NS_ASSUME_NONNULL_END
