//
//  StrokeModel.swift
//  CharDatasetor-iOS
//
//  Created by 新納真次郎 on 2018/09/06.
//  Copyright © 2018年 新納真次郎. All rights reserved.
//

import Foundation
import UIKit

class StrokeModel {
    
    var points: [CGPoint] = []
    
    func set( points: [CGPoint] ) {
        self.points = points
    }
    
    func addPoint( pt: CGPoint ){
        points.append( pt )
    }
    
    func dict() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
        
        var arrayPt: [Dictionary<String,CGFloat>] = []
        
        for point in points {
            arrayPt.append( point.dict() )
        }
        
        dict["points"] = arrayPt
        
        return dict
    }
    
}
