//
//  YoloProcess.m
//  rectTarget
//
//  Created by wzq on 1/19/22.
//
#import <AppKit/AppKit.h>
#import "rectTarget.h"
#import "YOLOv3TinyFP16.h"

@import CoreImage;
@import CoreML;
@import Vision;

@interface YoloProcess ()

//@property (nonatomic, strong) ML_MODEL_CLASS *fcrn;
@property (nonatomic, strong) VNCoreMLModel *model;
@property (nonatomic, strong) VNCoreMLRequest *request;
@property (nonatomic, strong) VNImageRequestHandler *handler;
@end

@implementation YoloProcess

- (void)loadModel
{
    NSError *error = nil;
    YOLOv3TinyFP16 *fcrn = [[YOLOv3TinyFP16 alloc] init];
    VNCoreMLModel *model = [VNCoreMLModel modelForMLModel:fcrn.model error:&error];
    
    self.model = model;
}

-(NSString *)predictImage:(NSImage *)image outPose:(CGRect *)outPose
{

    NSError *error1 = nil;
    self.request = [[VNCoreMLRequest alloc] initWithModel:self.model];// completionHandler:completionHandler];
    
    //NSRect proposedRect = NSMakeRect(0.0f, 0.0f, 416.0f, 416.0f);
    NSSize newSize = NSMakeSize(416, 416);
    NSImage *smallImage = [[NSImage alloc] initWithSize: newSize];
    [smallImage lockFocus];
    
    [image setSize: newSize];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [image drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, newSize.width, newSize.height) operation:NSCompositingOperationCopy fraction:1.0];
    [smallImage unlockFocus];
    
    CGImageRef imgRef = [smallImage CGImageForProposedRect:nil context:nil hints:nil];

    self.handler = [[VNImageRequestHandler alloc] initWithCGImage: imgRef options:@{}];
    [self.handler performRequests:@[self.request] error:&error1];
    
    NSArray *results = self.request.results;
    NSLog(@"results = \"%@\"", results);
    for (VNObservation *observation in results)
    {
        if ([observation isKindOfClass:  [VNRecognizedObjectObservation class]])
        {
            VNRecognizedObjectObservation *recognizedObservation = (VNRecognizedObjectObservation*)observation;
            
            VNClassificationObservation *topLabelObservation = recognizedObservation.labels[0];
            
            *outPose = recognizedObservation.boundingBox;
            return topLabelObservation.identifier;
        }
    }
    
    return @"";
}

/*VNRequestCompletionHandler completionHandler =
^(VNRequest *request, NSError * _Nullable error)
{
     dispatch_async(dispatch_get_main_queue(),
                    ^{
                        NSString *stringValue = NSLocalizedString(@"depthPrediction.completionHandler", @"Processing results...");
                    });
    NSArray *results = request.results;
    NSLog(@"results = \"%@\"", results);
    for (VNObservation *observation in results)
    {
        if ([observation isKindOfClass: //VNRecognizedObjectObservation
             [VNRecognizedObjectObservation class]])
        {
            VNRecognizedObjectObservation *recognizedObservation = (VNRecognizedObjectObservation*)observation;
            
            VNClassificationObservation *topLabelObservation = recognizedObservation.labels[0];

        }
    }
};
*/

@end
