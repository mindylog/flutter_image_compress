import Flutter
import UIKit

class CompressListHandler: NSObject {
    func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [Any] else {
            result(FlutterError(code: "invalid_args", message: "Invalid arguments provided", details: nil))
            return
        }
        
        guard let list = args[0] as? FlutterStandardTypedData else {
            result(FlutterError(code: "invalid_data", message: "The provided data is not valid", details: nil))
            return
        }
        
        let minWidth = args[1] as! Int
        let minHeight = args[2] as! Int
        let quality = args[3] as! Int
        let rotate = args[4] as! Int
        let format = args[6] as! Int
        
        let data = list.data
        
        guard let resultData = CompressHandler.compress(withData: data, minWidth: minWidth, minHeight: minHeight, quality: quality, rotate: rotate, format: format) else {
            result(FlutterError(code: "compression_error", message: "Failed to compress image data", details: nil))
            return
        }
        
        result(FlutterStandardTypedData(bytes: resultData))
    }
} 