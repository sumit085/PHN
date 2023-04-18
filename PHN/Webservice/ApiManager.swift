import Foundation
import Alamofire
import KRProgressHUD

final class ApiManager: NSObject {
    
    private override init() {}
    static let shared = ApiManager()
    
    public func get<T: Codable>(url: String, header: HTTPHeaders? = nil, isLoader: Bool? = true, success:@escaping (T) -> Void, failure:@escaping (Error) -> Void) {
        
        if isLoader ?? false {
            KRProgressHUD.show()
        }
        AF.request(url, method: .get, headers: header).responseData { (responseObject) -> Void in
            switch responseObject.result {
            case .success(let value):
                if isLoader ?? false {
                    KRProgressHUD.dismiss()
                }
                do {
                    let json = try JSONDecoder().decode(T.self, from: value)
                    success(json)
                } catch let error {
                    failure(error)
                }
            case .failure(let error):
                if isLoader ?? false {
                    KRProgressHUD.dismiss()
                }
                failure(error)
            }
        }
    }
}
