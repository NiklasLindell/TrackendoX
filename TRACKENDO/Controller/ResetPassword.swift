import UIKit
import Firebase
import SVProgressHUD

class ResetPassword: UIViewController {
    
    @IBOutlet weak var resetEmailPW: UITextField!
    
    @IBAction func resetPW(_ sender: Any) {
        resetPassword(email: resetEmailPW.text!)
    }
    
     @IBOutlet weak var restStyle: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restStyle.layer.cornerRadius = 20
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
                self.createAlertLogIn(title: "Reset Password!", message: "An email with information on how to reset your password has been sent to you")
            } else{
                print(error!.localizedDescription)
            }
        })
    }
    
    
    
    
    
    
    
}
