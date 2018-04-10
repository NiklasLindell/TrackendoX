import UIKit

class AddWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let segueID = "goToTableView"
    
    //var workoutList : [Workout]?
    
    var workout : Workout?
    
    @IBOutlet weak var addTableView: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var exerciseTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let wo = workout {
            return (wo.exercises.count)
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.white
        
        cell.textLabel?.text = workout?.exercises[indexPath.row]
        
        return cell
        
    }
    
    // gör så att man kan radera en rad i tableviewn genom att swipa med fingret
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            workout?.exercises.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func addExerciseButton(_ sender: UIButton) {
            
        if workout == nil {
            workout = Workout(title: titleTextField.text!)
        }
        
       workout?.exercises.append(exerciseTextField.text!)
        
        addTableView.reloadData()

        
       
    }
    
    
//    @IBAction func savePressed(_ sender: UIButton) {
//
//        let workOut = Workout(title: titleTextField.text!, exercises: exerciseTextField.text!)
//
//        workoutList?.append(workOut)
//
//        createAlertAdd(title: "Saved", message: "Your workout has been saved")
//    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: (Any)?) {
//
//        print("prep for segue")
//
//        if (segue.identifier == segueID) {
//
//            let destination = segue.destination as! ListViewController
//            destination.workoutList = self.workoutList
//        }
//   }
  

    // Skapar ett alert message för att säga att datan är sparad
    func createAlertAdd(title: String, message:String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}












