import UIKit
import Firebase
import SVProgressHUD


class SignUpViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        SVProgressHUD.show()
       Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                self.createAlertSignUp(title: "Try again!", message: "Your password needs to be at least 6 characters long.")
            }
            else {
                SVProgressHUD.dismiss()
                print("Sign Up Seccesfull")
                
                self.performSegue(withIdentifier: "goToList", sender: self)
            }
        }
    }
    
    func createAlertSignUp(title: String, message:String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
