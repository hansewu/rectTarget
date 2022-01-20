//
//  main.m
//  rectTargetTest
//
//  Created by apple on 1/20/22.
//

#import <Foundation/Foundation.h>
#import <rectTarget/rectTarget.h>
#import <AppKit/AppKit.h>

@import CoreImage;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        YoloProcess *yoloProcess;
        
        yoloProcess = [[YoloProcess alloc] init];
        [yoloProcess loadModel];
        
        NSImage *image = [[NSImage alloc]  initWithContentsOfFile:@"/Users/apple/Pictures/p/city-crowd-bazaar-market-public-space-metropolis-retail-urban-area-human-settlement-63952.jpg"];
        CGRect rectPos;
        NSString *strKind = [yoloProcess predictImage:image outPose:&rectPos];
        
        NSLog(@"Kind = \"%@\"", strKind);
        NSLog(@"rect = %.5f,  %.5f,  %.5f,  %.5f", rectPos.origin.x, rectPos.origin.y, rectPos.size.width, rectPos.size.height);
    }
    return 0;
}
