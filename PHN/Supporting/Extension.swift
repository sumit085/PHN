import Foundation
import UIKit
import KingfisherWebP

extension UITableViewCell {
    static var REUSE: String {
        return String.init(describing: self)
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String {
    
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isValidEmail() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}").evaluate(with: self)
    }
}

extension UIImageView {
    
    func setImage(imgUrl : String, defaultIcon: UIImage? = UIImage.init(named: "image-not-found")) {
        self.kf.setImage(with:  URL(string: (imgUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))), placeholder: defaultIcon, options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
    }
}
