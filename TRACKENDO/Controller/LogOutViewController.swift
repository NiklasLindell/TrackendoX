import UIKit
import Firebase

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print(error)
            print("error: there was a problem loging out")
        }
        
//        guard (navigationController?.popToRootViewController(animated: true)) != nil
//            else {
//                print("No View Controller to Pop")
//                return
//        }
    }
}
