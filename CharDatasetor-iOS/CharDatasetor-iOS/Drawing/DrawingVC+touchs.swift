
import Foundation
import UIKit

extension DrawingVC {
    
    func isInsideCanvas( currentPoint: CGPoint ) -> Bool {
        if  currentPoint.x < 0 ||
            currentPoint.x > self.canvas.bounds.size.width ||
            currentPoint.y < 0 ||
            currentPoint.y > self.canvas.bounds.size.height {
            return false
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        points = []
        
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        
        if !isInsideCanvas(currentPoint: currentPoint) {
            return
        }
        points.append( currentPoint )
        bezierPath = UIBezierPath()
        bezierPath.lineWidth = 8.0
        //        bezierPath.lineJoinStyle = .miter
        //        bezierPath.lineCapStyle = .butt
        bezierPath.move(to:currentPoint)
        
        bStroking = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        
        if !bStroking {
            return
        }
        
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        
        if points.last == currentPoint {
            return
        }
        
        points.append( currentPoint )
        bezierPath.addLine(to: currentPoint)
        drawLine(path: bezierPath)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if bezierPath == nil {
            return
        }
        
        if !bStroking {
            return
        }
        
        bStroking = false
        
        let touchEvent = touches.first!
        let currentPoint:CGPoint = touchEvent.location(in: self.canvas)
        
        if points.last != currentPoint {
            points.append( currentPoint )
        }
        
        let stroke = StrokeModel()
        stroke.set(points: points)
        
        if( points.count < 4 ) {
            return
        }
        
        curCharStroke.addStroke(st: stroke)
        
        bezierPath.addLine(to: currentPoint)
        
        updateLabel()
        
        drawLine(path: bezierPath)
    }
    
    //描画処理
    func drawLine( path: UIBezierPath ){
        
        UIGraphicsBeginImageContext(canvas.frame.size)
        
        if let image = self.lastDrawImage {
            image.draw(at: CGPoint.zero)
        }
        
        let lineColor = UIColor.black
        lineColor.setStroke()
        path.stroke()
        self.canvas.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.lastDrawImage = canvas.image
    }
    
    func redrawCanvas(){
        
        canvas.image = UIImage()
        lastDrawImage = UIImage()
        
        for stroke in curCharStroke.strokes {
            
            let points = stroke.points
            bezierPath = UIBezierPath()
            bezierPath.lineWidth = 8.0
            bezierPath.lineJoinStyle = .round
            bezierPath.lineCapStyle = .butt
            
            for pi in 0..<points.count {
                let point = points[pi]
                if pi == 0 {
                    bezierPath.move(to: point)
                } else {
                    bezierPath.addLine(to: point)
                }
            }
            
            drawLine(path: bezierPath)
        }
        
        lastDrawImage = canvas.image
        
    }

}
