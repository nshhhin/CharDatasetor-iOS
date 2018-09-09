
import UIKit

extension UIView {
    func screenShot() -> UIImage? {
        let imageBounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        
        UIGraphicsBeginImageContextWithOptions(imageBounds.size, true, 0)
        
        drawHierarchy(in: imageBounds, afterScreenUpdates: true)
        
        var image: UIImage?
        let contextImage = UIGraphicsGetImageFromCurrentImageContext()
        
        if let contextImage = contextImage, let cgImage = contextImage.cgImage {
            image = UIImage(
                cgImage: cgImage,
                scale: UIScreen.main.scale,
                orientation: contextImage.imageOrientation
            )
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }
   
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
        
    
    
}
