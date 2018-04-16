import UIKit
import Firebase
import SVProgressHUD

class LogInController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var logInStyle: UIButton!
    
    @IBOutlet weak var signUpStyle: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        logInStyle.layer.cornerRadius = 20
        signUpStyle.layer.cornerRadius = 20
        
     
    }
  
    @IBAction func logInPressed(_ sender: UIButton) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                self.createAlertLogIn(title: "Try again!", message: "Something went wrong")
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
    
}
