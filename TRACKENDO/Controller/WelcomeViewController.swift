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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

}
