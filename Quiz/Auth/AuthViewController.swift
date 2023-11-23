//
//  AuthViewController.swift
//  JChat
//
//  Created by Ботурбек Имомдодов on 13/09/23.
//

import UIKit
import SnapKit
enum AuthType:String{
    case register = "Регистрация"
    case login = "Авторизация"
}
class AuthViewController: UIViewController {
    var email:UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.placeholder = "Почта:"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    var name:UITextField = {
        let textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.placeholder = "Имя:"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    var password:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль:"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 50))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()
    var authTitle:UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 35,weight: .bold)
        return label
    }()
    var contentVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 23
        stackView.alignment = .trailing
        return stackView
    }()
    var doneButton:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 25
        button.addTarget(nil, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    var authType:AuthType = .register {
        didSet {
            UIView.transition(with: self.authTitle,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { self.authTitle.text = self.authType.rawValue},
                              completion: nil)
            
            UIView.animate(withDuration: 0.3) {
                
                var height:Int!
                switch self.authType {
                case .login:
                    height = 0
                    self.name.alpha = 0
                case .register:
                    height = 50
                    self.name.alpha = 1;
                }
                self.name.snp.updateConstraints { make in
                    make.height.equalTo(height)
                }
                self.view.layoutIfNeeded()
                
            }
        }
    }
    var authTypeButton:UIButton = {
        let button = UIButton(type: .custom)
        button.contentHorizontalAlignment = .trailing
        button.setTitle("Регистрация", for: .selected)
        button.setTitle("У вас уже есть аккаунт?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .selected)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        button.addTarget(nil, action: #selector(authTypeButtonTapped), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        self.view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.addSubview(authTitle)
        self.view.addSubview(contentVStack)
        self.view.addSubview(doneButton)
        self.view.addSubview(authTypeButton)
        authTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(60)
        }
        contentVStack.addArrangedSubview(name)
        contentVStack.addArrangedSubview(email)
        contentVStack.addArrangedSubview(password)
        contentVStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        for view in contentVStack.arrangedSubviews {
            view.snp.makeConstraints { make in
                make.left.right.equalToSuperview()
                make.height.equalTo(50)
            }
        }
        authTypeButton.snp.makeConstraints { make in
            make.top.equalTo(contentVStack.snp.bottom).inset(-10)
            make.trailing.equalTo(contentVStack).inset(5)
            
        }
        doneButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(70)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
    }
    @objc func authTypeButtonTapped(){
        authTypeButton.isSelected = !authTypeButton.isSelected
        if authTypeButton.isSelected {
            authType = .login
        }
        else{
            authType = .register
        }
    }
    @objc func doneButtonTapped(){
        guard let emailText = email.text, let passwordText = password.text, emailText != "", passwordText != "" else{
            return
        }
        if authType == .register && (name.text ?? "").count < 3 {
            return
        }
        switch authType {
        case .register :
            AuthService.shared.createUser(withEmail: emailText, password: passwordText) { (user,error) in
                if user != nil {
                   self.navigationController?.pushViewController(QuizzesViewController(), animated: true)
                }
            }
        case .login:
            AuthService.shared.signIn(withEmail: emailText, password: passwordText){
                (user,error) in
                if user != nil {
                    self.navigationController?.pushViewController(QuizzesViewController(), animated: true)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
