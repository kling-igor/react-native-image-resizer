
package com.reactnativeimageresizer;

import android.graphics.Bitmap;
import android.net.Uri;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.WritableMap;

import java.io.File;
import java.io.IOException;

public class RNImageResizerModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNImageResizerModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNImageResizer";
  }

  @ReactMethod
  public void createResizedImage(String imagePath, String outputPath, int newWidth, int newHeight, String compressFormat,
                                 int quality, final Promise promise) {
    try {
      createResizedImageWithExceptions(imagePath, outputPath, newWidth, newHeight, compressFormat,
              quality,
              promise);
    } catch (IOException e) {
      promise.reject(e);
    }
  }

  private void createResizedImageWithExceptions(String imagePath, String outputPath, int newWidth,
                                                int newHeight,
                                                String compressFormatString, int quality,
                                                 final Promise promise) throws IOException {
    Bitmap.CompressFormat compressFormat;

    if ("JPG".equals(compressFormatString)) {
      compressFormat = Bitmap.CompressFormat.JPEG;
    } else {
      compressFormat = Bitmap.CompressFormat.valueOf(compressFormatString);
    }

    Uri imageUri = Uri.parse(imagePath);

    File resizedImage = ImageResizer.createResizedImage(this.reactContext, imageUri, outputPath,
            newWidth,
            newHeight, compressFormat, quality);

    // If resizedImagePath is empty and this wasn't caught earlier, throw.
    if (resizedImage.isFile()) {
      WritableMap response = Arguments.createMap();
//      response.putString("path", resizedImage.getAbsolutePath());
      response.putString("uri", Uri.fromFile(resizedImage).toString());
//      response.putString("name", resizedImage.getName());
//      response.putDouble("size", resizedImage.length());
      promise.resolve(response);
    } else {
      promise.reject("Error getting resized image path", imagePath);
    }
  }
}