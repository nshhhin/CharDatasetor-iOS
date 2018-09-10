import UIKit

class DrawingVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var bezierPath:UIBezierPath!
    
    @IBOutlet weak var canvas: UIImageView!
    
    var lastDrawImage:UIImage?
    
    var points: [CGPoint] = []
    
    var bStroking = false
    
    var curCharStroke: CharStrokeModel!
    
    var userName: String?

    @IBOutlet weak var handLabel: UILabel!
    @IBOutlet weak var targetCharLabel: UILabel!
    @IBOutlet weak var curStrokeCountLabel: UILabel!
    @IBOutlet weak var maxStrokeCountLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var curProgressLabel: UILabel!
    @IBOutlet weak var maxProgressLabel: UILabel!
    
    var listCharStrokes: [CharStrokeModel] = []
    var maxProgress = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName = appDelegate.userName
        
        let documentPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask, true)[0]
        let filePath = Bundle.main.path(forResource: "Config", ofType:"plist" )
        let plist = NSDictionary(contentsOfFile: filePath!)!
        let figures = plist["Figures"] as! [Dictionary<String,Any>]
        let bNonDominant = plist["NonDominant"] as! Bool
        let bShuffleMode = plist["Shuffle"] as! Bool
        let DrawTime = plist["Times"] as! Int
        var hands: [String] = []
        
        if bNonDominant {
            handLabel.isHidden = false
            hands = ["利き手", "非利き手"]
        } else {
            handLabel.isHidden = true
             hands = ["利き手"]
        }
        
        // お題リスト listCharStrokes を作成
        for figure in figures {
            let name = figure["Name"] as! String
            let fileName = figure["FileName"] as! String
            let strokeCount = figure["StrokeCount"] as! Int
            
            // ✏️ TODO: シャッフルを緩和 ✏️
            for hand in hands {
                for time in 0..<DrawTime {
                    maxProgress += 1

                    let filePath = documentPath + "/" + userName! + "/" + hand + "/" + name + "/" + String(time) + ".json"
                    
                    if( FileManager.default.fileExists( atPath: filePath ) ) {
                        // すでに書いてあったらとばす
                        continue
                    }
                    let charStroke = CharStrokeModel(id: time, name: name, hand: hand, maxStrokeCount: strokeCount)
                    listCharStrokes.append( charStroke )
                }
            }
        }
        
        // 一つもお題がなければ
        if listCharStrokes.count == 0 {
            showFinishAlert()
            return
        }
        
        if bShuffleMode {
            listCharStrokes.shuffle()
        }
        
        curCharStroke = listCharStrokes[0]
        updateLabel()
        updateProgress()
    }
    
    func updateLabel(){
        curStrokeCountLabel.text = String( curCharStroke.strokes.count )
        maxStrokeCountLabel.text = String( curCharStroke.maxStrokeCount )
        targetCharLabel.text = curCharStroke.name
        handLabel.text = curCharStroke.hand
        if curCharStroke.hand == "非利き手" {
            handLabel.textColor = UIColor.red
        } else {
            handLabel.textColor = UIColor.black
        }
    }
    
    func updateProgress(){
        maxProgressLabel.text = String(maxProgress)
        curProgressLabel.text = String(maxProgress - listCharStrokes.count)
        progressBar.progress = 1.0 - Float(listCharStrokes.count)/Float(maxProgress)
    }
    
    func showFinishAlert(){
        UIAlertController(title: "ありがとうございました", message: "これでデータセット構築は終了です", preferredStyle: .alert)
            .addAction(title: "OK", style: .default) { action in
                self.dismiss(animated: true, completion: nil)
            }
        .show()
    }
    
}
