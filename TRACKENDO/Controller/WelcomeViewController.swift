import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "goToList", sender: self)
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

}
