
import Foundation
import UIKit
import FirebaseStorage

extension DrawingVC {
    
    @IBAction func tappedUndoBtn(_ sender: Any) {
        curCharStroke.removeStroke()
        redrawCanvas()
        updateLabel()
    }
    
    @IBAction func tappedNextBtn(_ sender: Any) {
        if curCharStroke.strokes.count != curCharStroke.maxStrokeCount {
            // ✏️TODO✏️ : アラート表示
            
            UIAlertController(title: "確認", message: "画数が一致しません", preferredStyle: .alert)
            .addAction(title: "OK", style: .cancel)
            .show()
            
            return
        }
        
        
        // Firebaseにとりあえず保存
        let storage = Storage.storage()
        let reference = storage.reference(forURL: "gs://chardatasetor-ios.appspot.com")
        let name = curCharStroke.name
        let id = curCharStroke.id
        let canvasImage = canvas.image
        let userName = "Aさん"
        let fileName = userName + "/" + name + "/" + String(id)
        var child = reference.child(  fileName + ".png")
        var data = UIImagePNGRepresentation(canvasImage!)!
        child.putData(data, metadata: nil) { (metadata, nil) in
        }
        
        let jsonObj = curCharStroke.dict()
        
        
        // 🐛BUG:全部1.jsonになってしまうバグ🐛
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObj, options: [])
            child = reference.child( fileName + ".json")
            child.putData(jsonData, metadata: nil) { (metadata, nil) in
            }
        } catch let error {
            print(error)
        }
        
        let jsonStr = jsonObj.description
        data = jsonStr.data(using: String.Encoding.utf8)!
        
        do {
            let documentPath = NSSearchPathForDirectoriesInDomains(
                .documentDirectory,
                .userDomainMask, true)[0]
            
            let url = URL(fileURLWithPath: documentPath + "/" + fileName + ".json")
            print(url)
            try data.write(to: url)
        } catch {
            // Failed to write file
        }
        
        curCharStroke.saveStrokes()
        curCharStroke = listCharStrokes.removeFirst()
        updateProgress()
        
        if listCharStrokes.count == 0 {
            UIAlertController(title: "ありがとうございました", message: "これでデータセット構築は終了です", preferredStyle: .alert)
                .addAction(title: "OK", style: .default) { action in
                    self.dismiss(animated: true, completion: nil)
                }
                .show()
            return
        }
        
        curCharStroke = listCharStrokes[0]
        
        redrawCanvas()
        updateLabel()
    }
    
    @IBAction func tappedDismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
