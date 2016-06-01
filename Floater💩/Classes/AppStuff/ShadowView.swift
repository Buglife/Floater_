//
//  ShadowView.swift
//

import UIKit
import CoreImage

class ShadowView: UIView {
    override func drawRect(rect: CGRect) {
        let color = UIColor.blackColor()
        let image = UIImage.ellipseShadowImage(rect.size, color: color, amount: 10)
        image.drawInRect(rect)
    }
}

private extension UIImage {
    class func ellipseShadowImage(size: CGSize, color: UIColor, amount: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let rect = CGRect(origin: CGPointZero, size: size)
        let ovalPath = UIBezierPath(ovalInRect: rect)
        color.setFill()
        ovalPath.fill()
        let ovalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let params: [String : AnyObject] = [kCIInputRadiusKey: amount, kCIInputImageKey: CoreImage.CIImage(image: ovalImage)!]
        let filter = CIFilter(name: "CIDiscBlur", withInputParameters: params)
        let ciBlurredImage = filter?.valueForKey(kCIOutputImageKey) as! CoreImage.CIImage
        let ciContext = CIContext(options: nil)
        let extent = ciBlurredImage.extent
        let cgImage = ciContext.createCGImage(ciBlurredImage, fromRect: extent)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, size.height)
        CGContextScaleCTM(context, 1, -1)
        
        CGContextDrawImage(context, rect, cgImage)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}
