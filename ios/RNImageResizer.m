
#import <Foundation/Foundation.h>
#import <React/RCTImageLoader.h>
#import "RNImageResizer.h"

bool saveImage(NSString* fullPath, UIImage* image, NSString* format, float quality ){
    NSData* data = nil;
    if ([format isEqualToString:@"JPG"] || [format isEqualToString:@"JPEG"]) {
        data = UIImageJPEGRepresentation(image, quality / 100.0);
    } else if ([format isEqualToString:@"PNG"]) {
        data = UIImagePNGRepresentation(image);
    }
    
    if (data == nil) {
        return NO;
    }
    
    return [ [NSFileManager defaultManager] createFileAtPath:fullPath contents:data attributes:nil];
}

NSString* generateFilePath(NSString* ext)
{
//    NSString* directory;

//    if ([outputPath length] == 0) {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString* directory = [paths firstObject];
//    }
//    else {
//        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        if ([outputPath hasPrefix:documentsDirectory]) {
//            directory = outputPath;
//        } else {
//            directory = [documentsDirectory stringByAppendingPathComponent:outputPath];
//        }
//
//        NSError *error;
//        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:&error];
//        if (error) {
//            NSLog(@"Error creating documents subdirectory: %@", error);
//            @throw [NSException exceptionWithName:@"InvalidPathException" reason:[NSString stringWithFormat:@"Error creating documents subdirectory: %@", error] userInfo:nil];
//        }
//    }

    NSString* name = [[NSUUID UUID] UUIDString];
    NSString* fullName = [NSString stringWithFormat:@"%@.%@", name, ext];
    NSString* fullPath = [directory stringByAppendingPathComponent:fullName];

    return fullPath;
}

@implementation RNImageResizer

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(createResizedImage:(NSString *)path
                  width:(float)width
                  height:(float)height
                  format:(NSString *)format
                  quality:(float)quality
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject) {

  CGSize newSize = CGSizeMake(width, height);

 //Set image extension
  NSString *extension = @"jpg";
  if ([format isEqualToString:@"PNG"]) {
      extension = @"png";
  }


  NSString* fullPath;
  @try {
    fullPath = generateFilePath(extension);
    NSLog(@"GENERATED PATH: %@", fullPath);
  } @catch (NSException *exception) {
    reject(@"", exception.reason, NULL);
    return;
  }

  [_bridge.imageLoader loadImageWithURLRequest:[RCTConvert NSURLRequest:path] callback:^(NSError *error, UIImage *image) {
    if (error || image == nil) {

      if ([path hasPrefix:@"data:"] || [path hasPrefix:@"file:"]) {
        NSURL *imageUrl = [[NSURL alloc] initWithString:path];
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
      } else {
        image = [[UIImage alloc] initWithContentsOfFile:path];
      }

      if (image == nil) {
        reject(@"", @"Can't retrieve the file from the path.", NULL);
        return;
      }
    }

//    UIImage* scaledImage = [image scaleToSize:newSize];

    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (scaledImage == nil) {
      reject(@"",@"Can't resize the image.", NULL);
      return;
    }

    if (!saveImage(fullPath, scaledImage, format, quality)) {
      reject(@"",@"Can't save the image. Check your compression format and your output path.", NULL);
      return;
    }

    resolve(fullPath);
  }];
}

@end
  