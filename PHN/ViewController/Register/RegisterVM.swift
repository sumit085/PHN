extension ConstantString {
    static let SUCCESS_REGISTER = "Register Successfully...!"
    static let ALREADY_REGISTER = "This email id already used. please change your email id."
    static let ENNTER_USERNAME = "Enter username."
    static let ENNTER_CONFIRM_PASSWORD = "Enter confirm password."
    static let PASSWORD_NOT_MATCH = "password and confirm password should be same."
    
}


import Foundation

final class RegisterVM {
    
    var obsSuccess: ObservableObject<Bool> = ObservableObject(nil)
    var error: ObservableObject<String> = ObservableObject(nil)
    
    func isValid(model: UserModel) -> Bool {
        if let username = model.username, username.isEmpty {
            error.value = ConstantString.ENNTER_USERNAME
            return false
        } else if let email = model.emailId, email.isEmpty {
            error.value = ConstantString.ENNTER_EMAIL
            return false
        } else if let email = model.emailId, !email.isValidEmail() {
            error.value = ConstantString.ENNTER_VALID_EMAIL
            return false
        } else if let password = model.password, password.isEmpty {
            error.value = ConstantString.ENNTER_PASSWORD
            return false
        } else if let confirmPassword = model.confirmPassword, confirmPassword.isEmpty {
            error.value = ConstantString.ENNTER_CONFIRM_PASSWORD
            return false
        } else if model.password ?? "" != model.confirmPassword ?? "" {
            error.value = ConstantString.PASSWORD_NOT_MATCH
            return false
        }
        return true
    }
    
    func register(model: UserModel) {
        if let retrievedData = UserDefaults.standard.data(forKey: UserDefaultConstantString.KEY_USER_DATA) {
            if var retrievedArray = try? JSONDecoder().decode([UserModel].self, from: retrievedData) {
                if retrievedArray.filter({$0.emailId == model.emailId}).count > 0 {
                    obsSuccess.value = false
                } else {
                    retrievedArray.append(model)
                    saveData(model: retrievedArray)
                    obsSuccess.value = true
                }
            }
        } else {
            saveData(model: [model])
            obsSuccess.value = true
        }
    }
    
    func saveData(model: [UserModel] ) {
        if let encoded = try? JSONEncoder().encode(model) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultConstantString.KEY_USER_DATA)
        }
    }
}

