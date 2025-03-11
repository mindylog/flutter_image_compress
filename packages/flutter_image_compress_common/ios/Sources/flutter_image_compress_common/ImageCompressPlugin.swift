import Flutter
import UIKit
import SDWebImage
import SDWebImageWebPCoder

public class ImageCompressPlugin: NSObject, FlutterPlugin {
    private static var showLog: Bool = false
    private static let serialQueue = DispatchQueue.global(qos: .default)
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_image_compress", binaryMessenger: registrar.messenger())
        let instance = ImageCompressPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        ImageCompressPlugin.serialQueue.async {
            switch call.method {
            case "compressWithList":
                let handler = CompressListHandler()
                handler.handleMethodCall(call, result: result)
            case "compressWithFile":
                let handler = CompressFileHandler()
                handler.handleMethodCall(call, result: result)
            case "compressWithFileAndGetFile":
                let handler = CompressFileHandler()
                handler.handleCompressFileToFile(call, result: result)
            case "showLog":
                self.setShowLog(call.arguments as! Bool)
                result(1)
            case "getSystemVersion":
                let systemVersion = UIDevice.current.systemVersion
                result(systemVersion)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    public static func isShowLog() -> Bool {
        return showLog
    }
    
    private func setShowLog(_ log: Bool) {
        ImageCompressPlugin.showLog = log
    }
} 