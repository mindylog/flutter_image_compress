import UIKit
import Foundation
import SDWebImage
import SDWebImageWebPCoder

class CompressHandler: NSObject {
    static func compress(withData data: Data, minWidth: Int, minHeight: Int, quality: Int, rotate: Int, format: Int) -> Data? {
        guard let image = UIImage(data: data) else { return nil }
        return compress(withUIImage: image, minWidth: minWidth, minHeight: minHeight, quality: quality, rotate: rotate, format: format)
    }
    
    static func compress(withUIImage image: UIImage, minWidth: Int, minHeight: Int, quality: Int, rotate: Int, format: Int) -> Data? {
        var targetImage = image
        
        if minWidth > 0 && minHeight > 0 {
            targetImage = targetImage.scale(withMinWidth: CGFloat(minWidth), minHeight: CGFloat(minHeight))
        }
        
        if rotate != 0 {
            targetImage = targetImage.rotate(CGFloat(rotate))
        }
        
        return compressData(withUIImage: targetImage, minWidth: minWidth, minHeight: minHeight, quality: quality, rotate: rotate, format: format)
    }
    
    static func compressData(withUIImage image: UIImage, minWidth: Int, minHeight: Int, quality: Int, rotate: Int, format: Int) -> Data? {
        let compressionQuality = CGFloat(quality) / 100.0
        
        switch format {
        case 1: // jpeg
            return image.jpegData(compressionQuality: compressionQuality)
        case 2: // png
            return image.pngData()
        case 3: // webp
            if let webPData = SDImageWebPCoder.shared.encodedData(with: image, format: .webP, options: [SDImageCoderOption.encodeCompressionQuality: compressionQuality]) {
                return webPData
            }
            return nil
        case 4: // heic
            if #available(iOS 11.0, *) {
                let ciContext = CIContext()
                let ciImage = CIImage(image: image)
                if let ciImage = ciImage, let colorSpace = ciImage.colorSpace {
                    return try? ciContext.heifRepresentation(of: ciImage, format: .RGBA8, colorSpace: colorSpace, options: [kCGImageDestinationLossyCompressionQuality as CIImageRepresentationOption: compressionQuality])
                }
            }
            // Fall back to JPEG if HEIC is not available
            return image.jpegData(compressionQuality: compressionQuality)
        default: // default is jpeg
            return image.jpegData(compressionQuality: compressionQuality)
        }
    }
} 