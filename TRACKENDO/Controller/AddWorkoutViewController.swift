import UIKit

class AddWorkoutViewController: UIViewController {
    
    let segueID = "goToTableView"
    
    var workoutList : [Workout]?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var exerciseTextField: UITextField!
    
    @IBOutlet weak var setTextField: UITextField!
    
    @IBOutlet weak var repsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
     
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        let workOut = Workout(title: titleTextField.text!, exercise: exerciseTextField.text! , reps: Int(repsTextField.text!)!, set: Int(setTextField.text!)!)
        
        workoutList?.append(workOut)
       
        createAlertAdd(title: "Saved", message: "Your workout has been saved")
        
     
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {

        print("prep for segue")

        if (segue.identifier == segueID) {

            let destination = segue.destination as! ListViewController
            destination.workoutList = self.workoutList
        }
   }

    
  
    
 
    
    

    // Skapar ett alert message för att säga att datan är sparad
    func createAlertAdd(title: String, message:String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

