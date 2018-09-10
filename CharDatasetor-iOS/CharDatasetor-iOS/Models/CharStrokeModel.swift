
import Foundation
import UIKit

class CharStrokeModel {
    
    var strokes: [StrokeModel] = []
    var id = 0
    var name = "あ"
    var hand = "利き手"
    var maxStrokeCount = 0
    var createdAt: Date?
    
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
    
    func dict() -> Dictionary<String, Any> {
        var dict = Dictionary<String, Any>()
    
        var arraySt: [Dictionary<String,Any>] = []
    
        for stroke in strokes {
            arraySt.append( stroke.dict() )
        }
    
        dict["strokes"] = arraySt
        dict["name"] = self.name
        dict["id"] = self.id
        dict["hand"] = self.hand
        dict["strokeLength"] = self.strokes.count
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        
        // ⚠️dictを作る時間を現在いれてる⚠️
        dict["createdAt"] = dateFormatter.string(from: Date())

        
        return dict
    }
    
}
