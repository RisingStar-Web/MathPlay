

import UIKit

class ParrentsPageViewController: UIViewController {
    
    @IBOutlet weak var leftSlider: RangeSeekSlider! {
        didSet {
          
        }
    }
    
    @IBOutlet weak var rightSlider: RangeSeekSlider!
    
    @IBOutlet weak var minFirstLabel: UILabel!
    @IBOutlet weak var maxFirstLabel: UILabel!
    
    @IBOutlet weak var minSecondLabel: UILabel!
    @IBOutlet weak var maxSecondLabel: UILabel!
    
    @IBOutlet weak var exampleLabel: UILabel!
    
    var currentFirstArgMin = 0
    var currentFirstArgMax = 0
    
    var currentSecondArgMin = 0
    var currentSecondArgMax = 0
    
    @IBOutlet weak var plusButton: UIButton! {
        didSet {
            plusButton.layer.masksToBounds = true
            plusButton.layer.cornerRadius = 8
            plusButton.layer.borderWidth = 1
            plusButton.layer.borderColor = UIColor.clear.cgColor
            plusButton.addTarget(self, action: #selector(plusButtonDidTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var minusButton: UIButton! {
        didSet {
            minusButton.layer.masksToBounds = true
            minusButton.layer.cornerRadius = 8
            minusButton.layer.borderWidth = 1
            minusButton.layer.borderColor = UIColor.clear.cgColor
            minusButton.addTarget(self, action: #selector(minusButtonDidTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var multiplyButton: UIButton! {
        didSet {
            multiplyButton.layer.masksToBounds = true
            multiplyButton.layer.cornerRadius = 8
            multiplyButton.layer.borderWidth = 1
            multiplyButton.layer.borderColor = UIColor.clear.cgColor
            multiplyButton.addTarget(self, action: #selector(multiplyButtonDidTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var divisionButton: UIButton! {
        didSet {
            divisionButton.layer.masksToBounds = true
            divisionButton.layer.cornerRadius = 8
            divisionButton.layer.borderWidth = 1
            divisionButton.layer.borderColor = UIColor.clear.cgColor
            divisionButton.addTarget(self, action: #selector(divisionButtonDidTap), for: .touchUpInside)
        }
    }
    
    var enabledOperations: [Bool] = [false, false, false, false]
    
    @IBOutlet weak var rewardField: UITextField!
    
    @IBOutlet weak var rightAnswersToWinField: UITextField!
    
    
    @IBOutlet weak var saveAndStartButton: UIButton! {
        didSet {
            saveAndStartButton.layer.cornerRadius = 21
            saveAndStartButton.backgroundColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1)
            saveAndStartButton.layer.borderWidth = 1
            saveAndStartButton.layer.borderColor = UIColor.black.cgColor
            saveAndStartButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            saveAndStartButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            saveAndStartButton.layer.shadowOpacity = 2.0
            saveAndStartButton.layer.shadowRadius = 2.0
            saveAndStartButton.addTarget(self, action: #selector(saveandStartButtonDidTap), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            passwordTextField.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            passwordTextField.layer.shadowOpacity = 2.0
            passwordTextField.layer.shadowRadius = 2.0
        }
    }
    
    
    @IBOutlet weak var backView: UIView! {
        didSet {
            backView.layer.cornerRadius = 8
            backView.backgroundColor = UIColor(white: 1, alpha: 0.8)
            
            backView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            backView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            backView.layer.shadowOpacity = 2.0
            backView.layer.shadowRadius = 2.0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupDefaults()
        setupRangeSlider()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupDefaults() {
        currentFirstArgMin = 10
        currentFirstArgMax = 90
        
        currentSecondArgMin = 10
        currentSecondArgMax = 90
        plusButtonDidTap()
        
    }
    
    func setupRangeSlider() {
        leftSlider.minValue = CGFloat(0)
        leftSlider.maxValue = CGFloat(100)
        leftSlider.tintColor = .black
        leftSlider.handleBorderWidth = 1
        leftSlider.handleBorderColor = UIColor.white
        leftSlider.hideLabels = true
        leftSlider.delegate = self
        
        leftSlider.handleColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
        leftSlider.colorBetweenHandles = .black

        leftSlider.backgroundColor = .clear
        leftSlider.selectedMinValue = CGFloat(currentFirstArgMin)
        leftSlider.selectedMaxValue = CGFloat(currentFirstArgMax)
        
        leftSlider.tag = 111
        
        minFirstLabel.text = "min: \(currentFirstArgMin)"
        maxFirstLabel.text = "max: \(currentFirstArgMax)"

        rightSlider.minValue = CGFloat(0)
        rightSlider.maxValue = CGFloat(100)
        rightSlider.tintColor = .black
        rightSlider.handleBorderWidth = 1
        rightSlider.handleBorderColor = UIColor.white
        rightSlider.hideLabels = true
        rightSlider.delegate = self
        
        rightSlider.handleColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
        rightSlider.colorBetweenHandles = .black
        
        rightSlider.backgroundColor = .clear
        rightSlider.selectedMinValue = CGFloat(currentSecondArgMin)
        rightSlider.selectedMaxValue = CGFloat(currentSecondArgMax)
        
        minSecondLabel.text = "min: \(currentSecondArgMin)"
        maxSecondLabel.text = "max: \(currentSecondArgMax)"
        
        
        rightSlider.minDistance = 1
        leftSlider.minDistance = 1
        
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func plusButtonDidTap() {
        if enabledOperations[0] {
            plusButton.backgroundColor = .clear
            plusButton.layer.borderColor = UIColor.clear.cgColor
        } else {
            plusButton.backgroundColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
            plusButton.layer.borderColor = UIColor.darkText.cgColor
        }
        enabledOperations[0] = !enabledOperations[0]
    }
    
    @objc func minusButtonDidTap() {
        if enabledOperations[1] {
            minusButton.backgroundColor = .clear
            minusButton.layer.borderColor = UIColor.clear.cgColor
        } else {
            minusButton.backgroundColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
            minusButton.layer.borderColor = UIColor.darkText.cgColor
        }
        enabledOperations[1] = !enabledOperations[1]
    }
    
    @objc func multiplyButtonDidTap() {
        if enabledOperations[2] {
            multiplyButton.backgroundColor = .clear
            multiplyButton.layer.borderColor = UIColor.clear.cgColor
        } else {
            multiplyButton.backgroundColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
            multiplyButton.layer.borderColor = UIColor.darkText.cgColor
        }
        enabledOperations[2] = !enabledOperations[2]
    }
    
    @objc func divisionButtonDidTap() {
        if enabledOperations[3] {
            divisionButton.backgroundColor = .clear
            divisionButton.layer.borderColor = UIColor.clear.cgColor
        } else {
            divisionButton.backgroundColor = UIColor(red: 0/255, green: 181/255, blue: 138/255, alpha: 1.0)
            divisionButton.layer.borderColor = UIColor.darkText.cgColor
        }
        enabledOperations[3] = !enabledOperations[3]
    }
    
    @objc func saveandStartButtonDidTap() {
        var password = UserDefaults.standard.string(forKey: UserDefaultsNames.password)
        if let newPass = passwordTextField.text, !newPass.isEmpty {
            password = newPass
        }
        guard let currentPassword = password, !currentPassword.isEmpty else {
            presentAlertWithTitle(title: "Empty password", message: "You have to set password for save data", options: "OK")
            return
        }
        UserDefaults.standard.set(currentPassword, forKey: UserDefaultsNames.password)
        UserDefaults.standard.set(currentFirstArgMin, forKey: UserDefaultsNames.minLeft)
        UserDefaults.standard.set(currentFirstArgMax, forKey: UserDefaultsNames.maxLeft)
        UserDefaults.standard.set(currentSecondArgMin, forKey: UserDefaultsNames.minRight)
        UserDefaults.standard.set(currentSecondArgMax, forKey: UserDefaultsNames.maxRight)
        UserDefaults.standard.set(enabledOperations, forKey: UserDefaultsNames.enabledOperations)
        if let reward = rewardField.text, !reward.isEmpty {
            UserDefaults.standard.set(reward, forKey: UserDefaultsNames.reward)
        } else {
            UserDefaults.standard.set("No reward :(", forKey: UserDefaultsNames.reward)
        }
        if let rightAnswersToWin = rightAnswersToWinField.text, !rightAnswersToWin.isEmpty {
            UserDefaults.standard.set(Int(rightAnswersToWin), forKey: UserDefaultsNames.rightAnswersToWin)
        } else {
            UserDefaults.standard.set(5, forKey: UserDefaultsNames.rightAnswersToWin)
        }
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(name: Notification.Name("StartGame"), object: nil)
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
}


extension ParrentsPageViewController : RangeSeekSliderDelegate {
    
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
   
        if  slider.tag == 111 {
            minFirstLabel.text = "min: \(Int(minValue))"
            maxFirstLabel.text = "max: \(Int(maxValue))"
            
            currentFirstArgMin = Int(minValue)
            currentFirstArgMax = Int(maxValue)
            
        } else {
            minSecondLabel.text = "min: \(Int(minValue))"
            maxSecondLabel.text = "max: \(Int(maxValue))"
           
            currentSecondArgMin = Int(minValue)
            currentSecondArgMax = Int(maxValue)
        }
    }
    
    func didEndTouches(in slider: RangeSeekSlider) {
        let leftInt =  Int.random(in: currentFirstArgMin..<currentFirstArgMax)
        let rightInt = Int.random(in: currentSecondArgMin..<currentSecondArgMax)
        
        exampleLabel.text = "\(leftInt) + \(rightInt) = \(leftInt + rightInt)"
    }
    

    
}
