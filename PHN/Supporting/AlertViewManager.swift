import UIKit

public class AlertViewManager: NSObject {
    
    static func show(alertWithTitle title:String, subTitle withSubTitle:String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: withSubTitle, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: ConstantString.OK, style: .default, handler: {_ in
                UIApplication.topViewController()?.dismiss(animated: false)
            }))
            UIApplication.topViewController()?.present(alert, animated: false, completion: nil)
        }
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let tabController = controller as? UITabBarController {
            return topViewController(controller: tabController.selectedViewController)
        }
        if let navController = controller as? UINavigationController {
            return topViewController(controller: navController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
