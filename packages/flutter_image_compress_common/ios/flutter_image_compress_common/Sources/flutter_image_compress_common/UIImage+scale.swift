import UIKit

extension UIImage {
    func scale(withMinWidth minWidth: CGFloat, minHeight: CGFloat) -> UIImage {
        let oldWidth = self.size.width
        let oldHeight = self.size.height
        
        let scaleFactor = min(oldWidth / minWidth, oldHeight / minHeight)
        
        if scaleFactor >= 1 {
            return self
        }
        
        let newHeight = oldHeight / scaleFactor
        let newWidth = oldWidth / scaleFactor
        let newSize = CGSize(width: newWidth, height: newHeight)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    func rotate(_ degrees: CGFloat) -> UIImage {
        let radians = degrees * .pi / 180.0
        
        // Calculate the size of the rotated image
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        rotatedViewBox.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContextWithOptions(rotatedSize, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        
        // Move the origin to the middle of the image so we rotate around the center
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        
        // Rotate the image context
        context.rotate(by: radians)
        
        // Draw the image centered
        self.draw(in: CGRect(x: -size.width / 2, y: -size.height / 2, width: size.width, height: size.height))
        
        // Get the rotated image
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage ?? self
    }
} 