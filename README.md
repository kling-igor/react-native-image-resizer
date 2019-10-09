
# react-native-image-resizer

## Getting started

`$ npm install react-native-image-resizer --save`

### Mostly automatic installation

`$ react-native link react-native-image-resizer`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-image-resizer` and add `RNImageResizer.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNImageResizer.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNImageResizerPackage;` to the imports at the top of the file
  - Add `new RNImageResizerPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-image-resizer'
  	project(':react-native-image-resizer').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-image-resizer/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-image-resizer')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNImageResizer.sln` in `node_modules/react-native-image-resizer/windows/RNImageResizer.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Image.Resizer.RNImageResizer;` to the usings at the top of the file
  - Add `new RNImageResizerPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNImageResizer from 'react-native-image-resizer';

// TODO: What to do with the module?
RNImageResizer;
```
  