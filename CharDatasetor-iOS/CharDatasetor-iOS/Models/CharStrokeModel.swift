
import Foundation
import UIKit

class CharStrokeModel {
    
    var strokes: [StrokeModel] = []
    var id = 0
    var name = "あ"
    var hand = "利き手"
    var maxStrokeCount = 0
    
    init(){
        
    }
    
    init(id: Int, name: String, hand: String, maxStrokeCount: Int){
        self.id = id
        self.name = name
        self.hand = hand
        self.maxStrokeCount = maxStrokeCount
    }
    
    func addStroke( st: StrokeModel ){
        strokes.append( st )
    }
    
    func removeStroke(){
        if strokes.count > 0 {
            strokes.removeLast()
        }
    }
    
    func saveStrokes() {
        // Realmに保存
       
    }
    
}
