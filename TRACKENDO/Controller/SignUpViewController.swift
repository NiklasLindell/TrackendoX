import UIKit
import Firebase
import SVProgressHUD


class SignUpViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpStyle.layer.cornerRadius = 20
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        SVProgressHUD.show()
       Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
                SVProgressHUD.dismiss()
                self.createAlertSignUp(title: "Something went wrong!", message: "Either the email address is already in use or your password is too short")
            }
            else {
                SVProgressHUD.dismiss()
                print("Sign Up Seccesfull")
                
                self.performSegue(withIdentifier: "goToList", sender: self)
            }
        }
    }
    
    // tar bort tangentbordet när man klickar någonstans utanför det
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   // tar bort tangentbordet när man klicka på return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return(true)
    }
    
    func createAlertSignUp(title: String, message:String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
