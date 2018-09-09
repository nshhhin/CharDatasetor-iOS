
import Foundation
import UIKit

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