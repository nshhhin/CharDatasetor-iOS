
import Foundation
import UIKit
import Alamofire

class GoogleFormVC: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var googleFormView: UIWebView!
    
    override func viewDidLoad() {
        googleFormView.delegate = self
        
        let url = URL(string : "https://docs.google.com/forms/d/e/1FAIpQLSf1plMJnun-i4JAqdrWOyNhZfoy6Wstp385MNw3FAPGOiBl_w/viewform?usp=sf_link")!
        let url_req = URLRequest(url: url)
        
        googleFormView.loadRequest(url_req) 
    }
    
    @IBAction func tappedFinishBtn(_ sender: Any) {
        // ✏️TODO✏️ : MySQLに追加処理
//        Alamofire.request(.post, "http://httpbin.org/get", parameters: ["foo": "bar"])
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tappedDismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
