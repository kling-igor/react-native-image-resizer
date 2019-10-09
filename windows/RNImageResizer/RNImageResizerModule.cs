using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Image.Resizer.RNImageResizer
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNImageResizerModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNImageResizerModule"/>.
        /// </summary>
        internal RNImageResizerModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNImageResizer";
            }
        }
    }
}
