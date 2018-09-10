
import UIKit

extension HomeVC: UIGestureRecognizerDelegate {
    // 画面外タップでキーボードをさげる.
    @objc func dismissKeyboard(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}
