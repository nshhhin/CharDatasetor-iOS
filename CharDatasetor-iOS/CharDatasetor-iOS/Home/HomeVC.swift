import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var userNameTextFiled: UITextField!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var formBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton! {
        didSet {
            submitBtn.isEnabled = false
            submitBtn.alpha = 0.5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tappedStartBtn(_ sender: Any) {
        // ✏️TODO✏️ : R.swiftの遷移
        
        let storyboard: UIStoryboard = UIStoryboard(name: "DrawingVC", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "DrawingVC")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
    
    @IBAction func tappedFromBtn(_ sender: Any) {
        // ✏️TODO✏️ : GoogleフォームをWebビューで表示
        let storyboard: UIStoryboard = UIStoryboard(name: "GoogleFormVC", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "GoogleFormVC")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
}
