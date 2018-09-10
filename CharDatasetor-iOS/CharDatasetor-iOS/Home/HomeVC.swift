
import UIKit

class HomeVC: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var formBtn: UIButton!
    @IBOutlet weak var userNameTextFiled: UITextField! {
        didSet {
            if appDelegate.userName != nil {
                userNameTextFiled.text = appDelegate.userName
            }
        }
    }
    
    @IBAction func tappedStartBtn(_ sender: Any) {
        let userName = userNameTextFiled.text
        appDelegate.userName = userName
        userDefaults.set( userName, forKey: "userName")
        
        let storyboard: UIStoryboard = UIStoryboard(name: "DrawingVC", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "DrawingVC")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
    
    @IBAction func tappedFromBtn(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "GoogleFormVC", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "GoogleFormVC")
        next.modalTransitionStyle = .crossDissolve
        self.present(next,animated: true, completion: nil)
    }
}
