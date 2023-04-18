import Foundation
import UIKit

enum STORYBOARD: String {
    case MAIN = "Main"
}

class MainModule {
    
    static func getStoryboard(type: STORYBOARD) -> UIStoryboard {
        return UIStoryboard(name: type.rawValue, bundle: Bundle.main)
    }
    
    static func getRegisterVC() -> RegisterVC {
        guard let viewController = getStoryboard(type: .MAIN).instantiateViewController(withIdentifier: String(describing: RegisterVC.self)) as? RegisterVC else {return RegisterVC()}
        return viewController
    }
    
    static func getHomeVC() -> HomeVC {
        guard let viewController = getStoryboard(type: .MAIN).instantiateViewController(withIdentifier: String(describing: HomeVC.self)) as? HomeVC else {return HomeVC()}
        return viewController
    }
    
    static func getDetailVC() -> DetailVC {
        guard let viewController = getStoryboard(type: .MAIN).instantiateViewController(withIdentifier: String(describing: DetailVC.self)) as? DetailVC else {return DetailVC()}
        return viewController
    }
}
