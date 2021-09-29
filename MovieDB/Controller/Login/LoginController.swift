//
//  LoginController.swift
//  MovieDB
//
//  Created by Hongfei Zheng on 9/27/21.
//

import UIKit

class LoginController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userLabel: UILabel?
    @IBOutlet weak var passwordLabel: UILabel?
    override func viewDidLoad() {
        super.viewDidLoad()
        userLabel?.isHidden = true
        passwordLabel?.isHidden = true
        userName.delegate = self
        passWord.delegate = self
        }
    @IBAction func buttonPress(_ sender: UIButton) {
        if userValidate(userName.text ?? "") && passwordValidate(passWord.text ?? ""){
            let st = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = st.instantiateViewController(withIdentifier: "TableViewController")
                navigationController?.pushViewController(vc, animated: true)
        }
    }
    func userValidate(_ username: String) -> Bool{
        if username.count >= 6{
            userLabel?.isHidden = true
            return true
        }
        userLabel?.isHidden = false
        return false
    }
    
    func passwordValidate(_ password: String)-> Bool{
        if password.count >= 6{
            passwordLabel?.isHidden = true
            return true
        }
        passwordLabel?.isHidden = false
        return false
    }
}

extension LoginController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
