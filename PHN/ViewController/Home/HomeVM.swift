import Foundation

final class HomeVM {
    
    private let repo = HomeRepo()
    
    var obsSuccess: ObservableObject<[ProductsModel]> = ObservableObject(nil)
    var error: ObservableObject<String> = ObservableObject(nil)
    
    func getProductData() {
        repo.getProductData { [weak self] (model: [ProductsModel]) in
            guard let sSelf = self else {return}
            sSelf.obsSuccess.value = model
        } failure: { [weak self] err in
            guard let sSelf = self else {return}
            sSelf.error.value = err.localizedDescription
        }
    }
}

final class HomeRepo {
    func getProductData<T: Codable>(success:@escaping (T) -> Void, failure:@escaping (Error) -> Void) {
        ApiManager.shared.get(url: APIConstants.PRODUCT) { (model: [ProductsModel]) in
            if let localModel = model as? T {
                success(localModel)
            }
        } failure: { err in
            failure(err)
        }
    }
}

