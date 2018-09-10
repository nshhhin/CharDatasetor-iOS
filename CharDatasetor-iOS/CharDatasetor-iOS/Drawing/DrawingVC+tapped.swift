
import Foundation
import UIKit
import FirebaseStorage
import SwiftyJSON

extension DrawingVC {
    
    @IBAction func tappedDismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedUndoBtn(_ sender: Any) {
        curCharStroke.removeStroke()
        redrawCanvas()
        updateLabel()
    }
    
    @IBAction func tappedNextBtn(_ sender: Any) {
        if curCharStroke.strokes.count != curCharStroke.maxStrokeCount {
            UIAlertController(title: "確認", message: "画数が一致しません", preferredStyle: .alert)
            .addAction(title: "OK", style: .cancel)
            .show()
            return
        }
        
        // Firebaseにとりあえず保存
        let storage = Storage.storage()
        let reference = storage.reference(forURL: "gs://chardatasetor-ios.appspot.com")
        let name = curCharStroke.name
        let hand = curCharStroke.hand
        let id = curCharStroke.id
        let canvasImage = canvas.image
        let fileName = userName! + "/" + hand + "/" + name + "/" + String(id)
        var child = reference.child(  fileName + ".png")
        var data = UIImagePNGRepresentation(canvasImage!)!
        child.putData(data, metadata: nil) { (metadata, nil) in
        }
        
        print( "==================" )
        print( name, id, userName! )
        print( "==================" )
            
        
        let jsonObj = curCharStroke.dict()
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
            child = reference.child( fileName + ".json")
            child.putData(jsonData, metadata: nil) { (metadata, nil) in
            }
        } catch let error {
            print(error)
        }
        
        // ローカルに一応保存する処理を追加
        
        // 🗒 MEMO: なんだかフォルダを作ってからではないと,write(to:)できないらしい...前までできたのに... 🗒
        let documentPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask, true)[0]
        
        let targetDir = userName! + "/" + hand + "/" + name
        let absoluteTargetDir = documentPath + "/" + targetDir
        do {
            try FileManager.default.createDirectory(atPath: absoluteTargetDir, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print("failed to write: \(error)")
        }
        
        
        
        // 筆跡データの保存
        let json = JSON(jsonObj)
        let jsonStr = json.description
        let jsonData = jsonStr.data(using: String.Encoding.utf8)!
        let jsonURL = URL(fileURLWithPath: absoluteTargetDir + "/" + String(id) + ".json")
        
//        if( FileManager.default.fileExists( atPath: absoluteTargetDir + "/" + String(id) + ".json") ) {
//            
//        } else {
//            print("ファイルなし")
//        }
            
        
        
        do {
            try jsonData.write(to: jsonURL)
        } catch let error as NSError {
            print("failed to write: \(error)")
        }

        // キャンバス画像を保存
        let imageURL = URL(fileURLWithPath: absoluteTargetDir + "/" + String(id) + ".png")
        do {
            try UIImagePNGRepresentation(canvasImage!)?.write(to: imageURL)
        } catch let error as NSError {
            print("failed to write: \(error)")
        }
        
        curCharStroke.saveStrokes()
        curCharStroke = listCharStrokes.removeFirst()
        updateProgress()
        
        if listCharStrokes.count == 0 {
            showFinishAlert()
            return
        }
        
        curCharStroke = listCharStrokes[0]
        
        redrawCanvas()
        updateLabel()
    }
    
}
