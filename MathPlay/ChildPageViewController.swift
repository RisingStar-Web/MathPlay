
import UIKit

class ChildPageViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.layer.masksToBounds = true
            resultLabel.layer.cornerRadius = 8
            resultLabel.backgroundColor = UIColor(white: 1, alpha: 0.8)
            
            resultLabel.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            resultLabel.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            resultLabel.layer.shadowOpacity = 2.0
            resultLabel.layer.shadowRadius = 2.0
        }
    }
    
    @IBOutlet weak var leftOperandLabel: UILabel!
    
    @IBOutlet weak var operatorLabel: UILabel!
    
    @IBOutlet weak var rightOperandLabel: UILabel!
    
    @IBOutlet weak var equalsLabel: UILabel! 
    
    @IBOutlet weak var checkButton: UIButton! {
        didSet {
       
            checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
            checkButton.layer.borderWidth = 1
            //  childButton.layer.borderColor = UIColor.black.cgColor
            checkButton.layer.cornerRadius = 8
            checkButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            checkButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            checkButton.layer.shadowOpacity = 2.0
            checkButton.layer.shadowRadius = 2.0
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
    
    @IBOutlet weak var resultField: UITextField!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet weak var safeIcon: UIImageView!
    
    @IBOutlet weak var rewardLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        }
    }
    var minLeft = 10
    var maxLeft = 90
    var minRight = 10
    var maxRight = 90
    var rightAnswer = 0
    var rightAnswersCount = 0
    var targetRightAnswersCount = 20
    var operations: [Int] = []
    var rewardText = "Empty reward :("
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDefaults()
        resultLabel.isHidden = true
        progressBar.progressViewStyle = .default
        progressBar.progress = 0.0
        newTask()
    }
    
    func loadDefaults() {
        guard let pass = UserDefaults.standard.string(forKey: UserDefaultsNames.password), !pass.isEmpty else {
            targetRightAnswersCount = 5
            maxLeft = 90
            maxRight = 90
            operations = [0, 1, 2, 3]
            return
        }
        targetRightAnswersCount = UserDefaults.standard.integer(forKey: UserDefaultsNames.rightAnswersToWin)
        minLeft = UserDefaults.standard.integer(forKey: UserDefaultsNames.minLeft)
        maxLeft = UserDefaults.standard.integer(forKey: UserDefaultsNames.maxLeft)
        minRight = UserDefaults.standard.integer(forKey: UserDefaultsNames.minRight)
        maxRight = UserDefaults.standard.integer(forKey: UserDefaultsNames.maxRight)
        rewardText = UserDefaults.standard.string(forKey: UserDefaultsNames.reward) ?? "Empty reward :("
        if let enabledOperations: [Bool] = UserDefaults.standard.value(forKey: UserDefaultsNames.enabledOperations) as? [Bool] {
            for i in 0..<enabledOperations.count {
                if enabledOperations[i] {
                    operations.append(i)
                }
            }
        }
    }
    
    func newTask() {
        var leftOperand = Int.random(in: minLeft..<maxLeft+1)
        var rightOperand = Int.random(in: minRight..<maxRight+1)
        var valueSign = 0
        if operations.count > 0 {
            let randomS = Int.random(in: 0..<operations.count)
            valueSign = operations[randomS]
        }
        switch valueSign {
        case 0:
            rightAnswer = leftOperand + rightOperand
            operatorLabel.text = "+"
        case 1:
            if !(leftOperand >= rightOperand) {
                let temp = leftOperand
                leftOperand = rightOperand
                rightOperand = temp
            }
            rightAnswer = leftOperand - rightOperand
            operatorLabel.text = "-"
        case 2:
            rightAnswer = leftOperand * rightOperand
            operatorLabel.text = "*"
        case 3:
            if leftOperand == 0 {
                leftOperand = 1
            }
            if rightOperand == 0 {
                rightOperand = 1
            }
            let rValue = leftOperand * rightOperand
            rightAnswer = leftOperand
            leftOperand = rValue
            operatorLabel.text = "÷"
        default:
            break
        }
        leftOperandLabel.text = "\(leftOperand)"
        rightOperandLabel.text = "\(rightOperand)"
    }
    
    @objc func checkButtonDidTap() {
        guard let userStringAnswer = resultField.text, !userStringAnswer.isEmpty, let answer = Int(userStringAnswer) else {
            presentAlertWithTitle(title: "Empty result", message: "You must input result to result field", options: "OK")
            return
        }
        resultLabel.isHidden = false
        if answer == rightAnswer {
            rightAnswersCount += 1
            resultLabel.text = "Right!"
            resultLabel.textColor = UIColor(red: 96/255, green: 187/255, blue: 167/255, alpha: 1)
        } else {
            rightAnswersCount = rightAnswersCount >= 0 ? rightAnswersCount - 1 : 0
            resultLabel.text = "Wrong!"
            resultLabel.textColor = UIColor.red
        }
        
        resultField.text = ""
        progressBar.progress = Float(rightAnswersCount) / Float(targetRightAnswersCount)
        if rightAnswersCount >= targetRightAnswersCount {
            checkButton.isEnabled = false
            rewardLabel.text = rewardText
            safeIcon.image = #imageLiteral(resourceName: "unlocked")
            self.view.endEditing(true)
        } else {
            newTask()
        }
    }
    
    @objc func backButtonDidTap() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}

extension UIViewController {
    
    func presentAlertWithTitle(title: String, message: String, options: String...) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (_, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: nil))
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
