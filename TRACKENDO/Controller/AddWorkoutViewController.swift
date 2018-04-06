import UIKit

class AddWorkoutViewController: UIViewController {
    
    let segueID = "goToTableView"
    
    var workoutList : [Workout]?
    
    @IBOutlet weak var addTableView: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var exerciseTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addExerciseButton(_ sender: UIButton) {
       
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {

        let workOut = Workout(title: titleTextField.text!, exercises: exerciseTextField.text!)

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












