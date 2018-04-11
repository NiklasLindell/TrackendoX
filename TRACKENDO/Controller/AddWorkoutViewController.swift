import UIKit
import Firebase

class AddWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let segueID = "goToTableView"
    
    var workoutList : [Workout]?
    
    var workout : Workout?
    
    @IBOutlet weak var addTableView: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var exerciseTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     // hur många rader det ska vara i tableviewn
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let wo = workout {
            return (wo.exercises.count)
        } else {
            return 0
        }
    }
    
     // vad som ska synas i varje rad i tableviewn
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
    
    // gör så att markeringen när man trycker på en rad bara blinkar till
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func edit(_ sender: UIButton) {
        addTableView.isEditing = !addTableView.isEditing
    }
    
    // gör så att man kan ändra ordningen på exercises när man skapar passet
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = workout?.exercises[sourceIndexPath.row]
        workout?.exercises.remove(at: sourceIndexPath.row)
        workout?.exercises.insert(item!, at: destinationIndexPath.row)
    }
    
    @IBAction func addExerciseButton(_ sender: UIButton) {
            
        if workout == nil {
            workout = Workout(title: titleTextField.text!)
        }
        
       workout?.exercises.append(exerciseTextField.text!)
        
        addTableView.reloadData()
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {

        let workOut = Workout(title: titleTextField.text!)

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












