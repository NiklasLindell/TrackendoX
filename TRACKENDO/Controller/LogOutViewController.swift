import UIKit
import Firebase

class LogOutViewController: UIViewController {
    
    @IBOutlet weak var logOutStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutStyle.layer.cornerRadius = 20
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            
        }
        catch {
            print(error)
            print("error: there was a problem loging out")
        }
    }
}
