//
//  LoginViewController.swift
//  Navigation-
//
//  Created by Aleksey Lexx on 16.06.2022.
//
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var userService: UserService
    
    var delegate: LoginViewControllerDelegate?
    
    init(userService: UserService) {
        self.userService = userService
        super .init(nibName: nil, bundle: nil )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var vkLogotype: UIImageView = {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "logo.png")
        return logo
    }()
    
    private lazy var loginStackView: UIStackView = {
        let signing = UIStackView()
        signing.translatesAutoresizingMaskIntoConstraints = false
        signing.layer.borderColor = UIColor.lightGray.cgColor
        signing.layer.borderWidth = 0.5
        signing.layer.cornerRadius = 10
        signing.alignment = .fill
        signing.axis = .vertical
        signing.distribution = .fillEqually
        signing.clipsToBounds = true
        return signing
    }()
    
    private lazy var loginTextfield: UITextField = {
        let logTextfield = UITextField()
        logTextfield.translatesAutoresizingMaskIntoConstraints = false
        logTextfield.tag = 0
        logTextfield.keyboardType = UIKeyboardType.default
        logTextfield.returnKeyType = UIReturnKeyType.done
        logTextfield.autocorrectionType = .no
        logTextfield.autocapitalizationType = .none
        logTextfield.backgroundColor = .systemGray6
        logTextfield.layer.borderWidth = 0.5
        logTextfield.layer.borderColor = UIColor.lightGray.cgColor
        logTextfield.placeholder = "E-mail or phone"
        logTextfield.textColor = .black
        logTextfield.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        logTextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: logTextfield.frame.height))
        logTextfield.leftViewMode = .always
        logTextfield.delegate = self
        return logTextfield
    }()
    
    private lazy var passTexfield: UITextField = {
        let password = UITextField()
        password.translatesAutoresizingMaskIntoConstraints = false
        password.tag = 1
        password.keyboardType = UIKeyboardType.default
        password.returnKeyType = UIReturnKeyType.done
        password.backgroundColor = .systemGray6
        password.autocorrectionType = .no
        password.autocapitalizationType = .none
        password.isSecureTextEntry = true
        password.textColor = .black
        password.placeholder = "Password"
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: password.frame.height))
        password.leftViewMode = .always
        password.delegate = self
        return password
    }()
    
    private lazy var loginButton: UIButton = {
        let logButton = UIButton()
        logButton.translatesAutoresizingMaskIntoConstraints = false
        logButton.setTitle("Log In", for: .normal)
        logButton.setTitleColor(.lightGray, for: .highlighted)
        logButton.titleLabel?.textColor = UIColor.white
        logButton.layer.cornerRadius = 10
        logButton.clipsToBounds = true
        logButton.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        logButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return logButton
    }()
    
    private lazy var loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
        
    }()
    
    private func setupLoginScrollView() {
        
        loginScrollView.addSubview(contentView)
        loginScrollView.keyboardDismissMode = .onDrag
        contentView.addSubview(loginButton)
        contentView.addSubview(loginStackView)
        contentView.addSubview(vkLogotype)
        loginStackView.addArrangedSubview(loginTextfield)
        loginStackView.addArrangedSubview(passTexfield)
        loginScrollView.addSubview(contentView)
        
        [ loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
          loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
          loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
          
          contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
          contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
          contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
          contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
          contentView.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor),
          
          vkLogotype.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
          vkLogotype.widthAnchor.constraint(equalToConstant: 100),
          vkLogotype.heightAnchor.constraint(equalToConstant: 100),
          vkLogotype.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
          
          loginStackView.topAnchor.constraint(equalTo: vkLogotype.bottomAnchor, constant: 120),
          loginStackView.heightAnchor.constraint(equalToConstant: 100),
          loginStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
          loginStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
          
          loginButton.topAnchor.constraint(equalTo: loginStackView.bottomAnchor, constant: 16),
          loginButton.heightAnchor.constraint(equalToConstant: 50),
          loginButton.leadingAnchor.constraint(equalTo: loginStackView.leadingAnchor),
          loginButton.trailingAnchor.constraint(equalTo: loginStackView.trailingAnchor),
          loginButton.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)]
            .forEach({$0.isActive = true})
    }
    
    private func gesture() {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(self.gestureAction))
        self.view.addGestureRecognizer(gesture)
    }
    //4 INT: Универсальный метод для всплывашек
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func gestureAction() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginScrollView.contentInset.bottom = keyboardSize.height + 32
            loginScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardHiden(notification: NSNotification) {
        loginScrollView.contentInset = .zero
        loginScrollView.verticalScrollIndicatorInsets = .zero
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHiden), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewDidDisappear (_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 4 INT - авторизация пользователя
    @objc func signIn() {
        if let password = passTexfield.text, !password.isEmpty,
           let login =  loginTextfield.text, !login.isEmpty {
            guard delegate?.isCheckDelegate(loginDelegate: login, passwordDelegate: password) == true
            else {return showAlert(title: "Ошибка", message: "Неправильно введен логин или пароль")}
            guard  let user = userService.getUser(password: password, login: login)
            else {return showAlert(title: "Отказ в авторизации", message: "Пользователь не найден")}
            let profileVC = ProfileViewController(currentUser: user)
            navigationController?.pushViewController(profileVC, animated: true)
        } else {
            showAlert(title: "Внимание", message: "Необходимо заполнить все поля авторизации")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        gesture()
        view.addSubview(loginScrollView)
        setupLoginScrollView()
    }
}



