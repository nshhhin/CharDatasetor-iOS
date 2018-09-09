import UIKit

class DrawingVC: UIViewController {
    
    var bezierPath:UIBezierPath!
    
    @IBOutlet weak var canvas: UIImageView!
    
    var lastDrawImage:UIImage?
    
    var points: [CGPoint] = []
    
    var bStroking = false
    
    var curCharStroke: CharStrokeModel!

    @IBOutlet weak var handLabel: UILabel!
    @IBOutlet weak var targetCharLabel: UILabel!
    @IBOutlet weak var curStrokeCountLabel: UILabel!
    @IBOutlet weak var maxStrokeCountLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var curProgressLabel: UILabel!
    @IBOutlet weak var maxProgressLabel: UILabel!
    
    var listCharStrokes: [CharStrokeModel] = []
    var max = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "Config", ofType:"plist" )
        let plist = NSDictionary(contentsOfFile: filePath!)!
        let figures = plist["Figures"] as! [Dictionary<String,Any>]
        let bNonDominant = plist["NonDominant"] as! Bool
        let bShuffleMode = plist["Shuffle"] as! Bool
        let DrawTime = plist["Times"] as! Int
        
        if bNonDominant {
            handLabel.isHidden = false
        } else {
            handLabel.isHidden = true
        }
        
        for figure in figures {
            let name = figure["Name"] as! String
            let fileName = figure["FileName"] as! String
            let strokeCount = figure["StrokeCount"] as! Int
            
            for hand in ["利き手", "非利き手"] {
                for time in 0..<DrawTime {
                    let charStroke = CharStrokeModel(id: time, name: name, hand: hand, maxStrokeCount: strokeCount)
                    listCharStrokes.append( charStroke )
                }
            }
        }
        
        if bShuffleMode {
            listCharStrokes.shuffle()
        }
        
        max = listCharStrokes.count
        
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
        maxProgressLabel.text = String(max)
        curProgressLabel.text = String(max - listCharStrokes.count)
        progressBar.progress = 1.0 - Float(listCharStrokes.count)/Float(max)
        
    }
    
}
