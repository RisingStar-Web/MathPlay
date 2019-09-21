import UIKit

class StartPageViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField! {
        didSet {
            passwordField.layer.borderWidth = 1
            //  passwordField.layer.borderColor = UIColor.black.cgColor
            passwordField.layer.cornerRadius = 8
            passwordField.isSecureTextEntry = true
        }
    }
    
    @IBOutlet weak var parrentsButton: UIButton! {
        didSet {
            parrentsButton.layer.borderWidth = 1
            parrentsButton.layer.borderColor = UIColor.black.cgColor
            parrentsButton.layer.cornerRadius = 8
            parrentsButton.addTarget(self, action: #selector(parrentsButtonDidTap), for: .touchUpInside)
            
            parrentsButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            parrentsButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            parrentsButton.layer.shadowOpacity = 2.0
            parrentsButton.layer.shadowRadius = 2.0
        }
    }
    
    @IBOutlet weak var childButton: UIButton! {
        didSet {
            childButton.layer.borderWidth = 1
            //  childButton.layer.borderColor = UIColor.black.cgColor
            childButton.layer.cornerRadius = 8
            childButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
            
            childButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            childButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            childButton.layer.shadowOpacity = 2.0
            childButton.layer.shadowRadius = 2.0
        }
    }
    
    @IBOutlet weak var okButton: UIButton! {
        didSet {
            okButton.layer.borderWidth = 1
            okButton.layer.borderColor = UIColor.black.cgColor
            okButton.layer.cornerRadius = 8
            okButton.addTarget(self, action: #selector(checkPassword), for: .touchUpInside)
            
            okButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            okButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            okButton.layer.shadowOpacity = 2.0
            okButton.layer.shadowRadius = 2.0
        }
    }
    @IBOutlet weak var resetButton: UIButton! {
        didSet {
            resetButton.layer.borderWidth = 1
            resetButton.layer.borderColor = UIColor.black.cgColor
            resetButton.layer.cornerRadius = 8
            resetButton.isEnabled = true
            resetButton.addTarget(self, action: #selector(resetSettings), for: .touchUpInside)
        }
    }
    
    var previousPassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        passwordField.isHidden = true
        resetButton.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(startGame), name: Notification.Name("StartGame"), object: nil)
    }
    
    @objc func parrentsButtonDidTap() {
        if let previousPassword = UserDefaults.standard.string(forKey: UserDefaultsNames.password), !previousPassword.isEmpty {
            passwordField.isHidden = false
            okButton.isHidden = false
            resetButton.isHidden = false
            self.previousPassword = previousPassword
        } else {
            goToParentsPage()
        }
    }
    
    func goToParentsPage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let parrentVC =  storyboard.instantiateViewController(withIdentifier: "ParrentsPageViewController")
        self.navigationController?.pushViewController(parrentVC, animated: true)
    }
    
    @objc func checkPassword() {
        guard let userInput = passwordField.text, !userInput.isEmpty else {
            presentAlertWithTitle(title: "Empty password", message: "You have to input correct password or reset settings", options: "OK")
            return
        }
        if userInput == self.previousPassword {
            passwordField.text = nil
            goToParentsPage()
        } else {
            presentAlertWithTitle(title: "Incorrect password", message: "You have to input correct password or reset settings", options: "OK")
        }
    }
    
    @objc func resetSettings() {
        presentAlertWithTitle(title: "Reset", message: "Are you shoure, you want to reset all settings? It will remove all settings, including reward and other data.", options: "Yes", "No") { (option) in
            switch(option) {
            case 0:
                if let domain = Bundle.main.bundleIdentifier {
                    UserDefaults.standard.removePersistentDomain(forName: domain)
                    UserDefaults.standard.synchronize()
                }
                self.goToParentsPage()
                break
            default:
                break
            }
        }
    }
    
    @objc func startGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let parrentVC =  storyboard.instantiateViewController(withIdentifier: "ChildPageViewController")
        self.navigationController?.pushViewController(parrentVC, animated: true)
    }
    
    
}

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
