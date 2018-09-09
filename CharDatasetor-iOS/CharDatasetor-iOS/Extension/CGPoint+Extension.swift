
import Foundation
import UIKit

extension CGPoint {
    
    func dict() -> Dictionary<String,CGFloat> {
        let x = self.x
        let y = self.y
        
        return ["x":x, "y":y]
    }
}
