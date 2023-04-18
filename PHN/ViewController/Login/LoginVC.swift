import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var lblEmailId: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    
    private var viewModel = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let isLoginUser = UserDefaults.standard.value(forKey: UserDefaultConstantString.KEY_IS_LOGIN) as? Bool, isLoginUser {
            self.navigationController?.pushViewController(MainModule.getHomeVC(), animated: false)
        }
        
        hideKeyboardWhenTappedAround()
        viewModel.obsSuccess.bind { [weak self] result in
            guard let self else { return}
            if result == true {
                UserDefaults.standard.set(true, forKey: UserDefaultConstantString.KEY_IS_LOGIN)
                self.navigationController?.pushViewController(MainModule.getHomeVC(), animated: true)
            }
        }
        
        viewModel.error.bind { err in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                if let errorValue = err {
                    AlertViewManager.show(alertWithTitle: ConstantString.ERROR_TITLE, subTitle: errorValue )
                }
            })
        }
    }
    
    @IBAction func onTapLogin(_ sender: UIButton) {
        let emailId = lblEmailId.text?.trim
        let pass = lblPassword.text?.trim
        let model = UserModel(emailId: emailId, password: pass)
        
        if viewModel.isValid(model: model) {
            viewModel.login(model: model)
        }
    }
    
    @IBAction func onTapRegister(_ sender: UIButton) {
        navigationController?.pushViewController(MainModule.getRegisterVC(), animated: true)
    }
}
