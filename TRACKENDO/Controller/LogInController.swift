import UIKit
import Firebase
import SVProgressHUD

class LogInController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var resetEmailPW: UITextField!
    
    @IBAction func resetPW(_ sender: Any) {
        resetPassword(email: resetEmailPW.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
    }

    
    @IBAction func logInPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                self.createAlertLogIn(title: "Try again!", message: "Wrong Password.")
                print(error!)
            }
            else {
                SVProgressHUD.dismiss()
                print("Login In Successful")
                self.performSegue(withIdentifier: "goToList", sender: self)
            }
        }
    }
    
    func createAlertLogIn(title: String, message:String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func resetPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil{
                self.createAlertLogIn(title: "Reset Password!", message: "An email with information on how to reset your password has been sent to you.")
            } else{
                print(error!.localizedDescription)
            }
        })
    }
    
}
