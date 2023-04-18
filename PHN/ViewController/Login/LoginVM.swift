import Foundation

final class LoginVM {
    
    var obsSuccess: ObservableObject<Bool> = ObservableObject(nil)
    var error: ObservableObject<String> = ObservableObject(nil)
    
    func isValid(model: UserModel) -> Bool {
        if let email = model.emailId, email.isEmpty {
            error.value = ConstantString.ENNTER_EMAIL
            return false
        } else if let email = model.emailId, !email.isValidEmail() {
            error.value = ConstantString.ENNTER_VALID_EMAIL
            return false
        } else if let password = model.password, password.isEmpty {
            error.value = ConstantString.ENNTER_PASSWORD
            return false
        }
        return true
    }
    
    func login(model: UserModel) {
        if let retrievedData = UserDefaults.standard.data(forKey: UserDefaultConstantString.KEY_USER_DATA) {
            if let retrievedArray = try? JSONDecoder().decode([UserModel].self, from: retrievedData) {
                if retrievedArray.filter({$0.emailId == model.emailId && $0.password == model.password}).count > 0 {
                    obsSuccess.value = true
                } else {
                    error.value = ConstantString.USER_NOT_FOUND
                }
            }
        } else {
            error.value = ConstantString.USER_NOT_FOUND
        }
    }
}

