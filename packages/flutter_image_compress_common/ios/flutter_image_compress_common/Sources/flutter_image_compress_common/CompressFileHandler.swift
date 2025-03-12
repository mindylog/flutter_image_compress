import Flutter
import UIKit
import SDWebImage
import SDWebImageWebPCoder
import SYPictureMetadata

class CompressFileHandler: NSObject {
    func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! [Any]
        let path = args[0] as! String
        let minWidth = args[1] as! Int
        let minHeight = args[2] as! Int
        let quality = args[3] as! Int
        let rotate = args[4] as! Int
        let formatType = args[6] as! Int
        let keepExif = args[7] as! Bool
        
        var img: UIImage?
        
        let imageUrl = URL(fileURLWithPath: path)
        guard let nsdata = try? Data(contentsOf: imageUrl) else {
            result(FlutterError(code: "file_not_found", message: "Could not read file at path: \(path)", details: nil))
            return
        }
        
        let imageType = mimeTypeByGuessingFromData(nsdata)
        
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
        
        if imageType == "image/webp" {
            img = SDImageWebPCoder.shared.decodedImage(with: nsdata, options: nil)
        } else {
            img = UIImage(data: nsdata)
        }
        
        guard let image = img else {
            result(FlutterError(code: "invalid_image", message: "Could not decode image at path: \(path)", details: nil))
            return
        }
        
        guard let data = CompressHandler.compress(withUIImage: image, minWidth: minWidth, minHeight: minHeight, quality: quality, rotate: rotate, format: formatType) else {
            result(FlutterError(code: "compression_error", message: "Failed to compress image", details: nil))
            return
        }
        
        var finalData = data
        
        if keepExif {
            do {
                let metadata = try SYMetadata(fileURL: URL(fileURLWithPath: path))
                metadata.orientation = .up
                let metadataData = try metadata.apply(to: data)
                finalData = metadataData
            } catch {
                print("Error applying metadata: \(error)")
            }
        }
        
        result(FlutterStandardTypedData(bytes: finalData))
    }
    
    func handleCompressFileToFile(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as! [Any]
        let path = args[0] as! String
        let minWidth = args[1] as! Int
        let minHeight = args[2] as! Int
        let quality = args[3] as! Int
        let targetPath = args[4] as! String
        let rotate = args[5] as! Int
        let formatType = args[7] as! Int
        let keepExif = args[8] as! Bool
        
        var img: UIImage?
        
        let imageUrl = URL(fileURLWithPath: path)
        guard let nsdata = try? Data(contentsOf: imageUrl) else {
            result(FlutterError(code: "file_not_found", message: "Could not read file at path: \(path)", details: nil))
            return
        }
        
        let imageType = mimeTypeByGuessingFromData(nsdata)
        
        let webPCoder = SDImageWebPCoder.shared
        SDImageCodersManager.shared.addCoder(webPCoder)
        
        if imageType == "image/webp" {
            img = SDImageWebPCoder.shared.decodedImage(with: nsdata, options: nil)
        } else {
            img = UIImage(data: nsdata)
        }
        
        guard let image = img else {
            result(FlutterError(code: "invalid_image", message: "Could not decode image at path: \(path)", details: nil))
            return
        }
        
        guard let data = CompressHandler.compressData(withUIImage: image, minWidth: minWidth, minHeight: minHeight, quality: quality, rotate: rotate, format: formatType) else {
            result(FlutterError(code: "compression_error", message: "Failed to compress image", details: nil))
            return
        }
        
        var finalData = data
        
        if keepExif {
            do {
                let metadata = try SYMetadata(fileURL: URL(fileURLWithPath: path))
                metadata.orientation = .up
                let metadataData = try metadata.apply(to: data)
                finalData = metadataData
            } catch {
                print("Error applying metadata: \(error)")
            }
        }
        
        do {
            try finalData.write(to: URL(fileURLWithPath: targetPath), options: .atomic)
            result(targetPath)
        } catch {
            result(FlutterError(code: "file_save_error", message: "Could not save file to path: \(targetPath)", details: error.localizedDescription))
        }
    }
    
    private func mimeTypeByGuessingFromData(_ data: Data) -> String {
        var bytes = [UInt8](repeating: 0, count: 12)
        data.copyBytes(to: &bytes, count: min(12, data.count))
        
        let bmp: [UInt8] = [0x42, 0x4D]
        let gif: [UInt8] = [0x47, 0x49, 0x46]
        let swf: [UInt8] = [0x46, 0x57, 0x53]
        let swc: [UInt8] = [0x43, 0x57, 0x53]
        let jpg: [UInt8] = [0xFF, 0xD8, 0xFF]
        let psd: [UInt8] = [0x38, 0x42, 0x50, 0x53]
        let iff: [UInt8] = [0x46, 0x4F, 0x52, 0x4D]
        let webp: [UInt8] = [0x52, 0x49, 0x46, 0x46]
        let ico: [UInt8] = [0x00, 0x00, 0x01, 0x00]
        let tif_ii: [UInt8] = [0x49, 0x49, 0x2A, 0x00]
        let tif_mm: [UInt8] = [0x4D, 0x4D, 0x00, 0x2A]
        let png: [UInt8] = [0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A]
        let jp2: [UInt8] = [0x00, 0x00, 0x00, 0x0C, 0x6A, 0x50, 0x20, 0x20, 0x0D, 0x0A, 0x87, 0x0A]
        
        if matchesSignature(bytes, signature: bmp, length: 2) {
            return "image/x-ms-bmp"
        } else if matchesSignature(bytes, signature: gif, length: 3) {
            return "image/gif"
        } else if matchesSignature(bytes, signature: jpg, length: 3) {
            return "image/jpeg"
        } else if matchesSignature(bytes, signature: psd, length: 4) {
            return "image/psd"
        } else if matchesSignature(bytes, signature: iff, length: 4) {
            return "image/iff"
        } else if matchesSignature(bytes, signature: webp, length: 4) {
            return "image/webp"
        } else if matchesSignature(bytes, signature: ico, length: 4) {
            return "image/vnd.microsoft.icon"
        } else if matchesSignature(bytes, signature: tif_ii, length: 4) || matchesSignature(bytes, signature: tif_mm, length: 4) {
            return "image/tiff"
        } else if matchesSignature(bytes, signature: png, length: 8) {
            return "image/png"
        } else if matchesSignature(bytes, signature: jp2, length: 12) {
            return "image/jp2"
        }
        
        return "application/octet-stream" // default type
    }
    
    private func matchesSignature(_ bytes: [UInt8], signature: [UInt8], length: Int) -> Bool {
        guard bytes.count >= length, signature.count >= length else { return false }
        for i in 0..<length {
            if bytes[i] != signature[i] {
                return false
            }
        }
        return true
    }
} 