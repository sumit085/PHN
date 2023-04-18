import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var lblUserName: UITextField!
    @IBOutlet weak var lblEmailId: UITextField!
    @IBOutlet weak var lblPassword: UITextField!
    @IBOutlet weak var lblConfirmPassword: UITextField!
    
    private let viewModel = RegisterVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        viewModel.obsSuccess.bind { [weak self]result in
            guard let self else { return}
            if result == true {
                self.resetData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    AlertViewManager.show(alertWithTitle: ConstantString.ERROR_TITLE, subTitle: ConstantString.SUCCESS_REGISTER)
                })
            } else if result == false{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                    AlertViewManager.show(alertWithTitle: ConstantString.ERROR_TITLE, subTitle: ConstantString.ALREADY_REGISTER )
                })
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
    
    private func resetData() {
        lblUserName.text = nil
        lblEmailId.text = nil
        lblPassword.text = nil
        lblConfirmPassword.text = nil
    }
    
    @IBAction func onTapRegister(_ sender: UIButton) {
        let userName = lblUserName.text?.trim
        let emailId = lblEmailId.text?.trim
        let pass = lblPassword.text?.trim
        let conPass = lblConfirmPassword.text?.trim
        let model = UserModel(username: userName, emailId: emailId, password: pass, confirmPassword: conPass)
        if viewModel.isValid(model: model) {
            viewModel.register(model: model)
        }
    }
}

