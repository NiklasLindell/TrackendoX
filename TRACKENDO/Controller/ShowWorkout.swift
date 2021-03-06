import UIKit
import Firebase

class ShowWorkout: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var workout : Workout?
    var currentUserId = Auth.auth().currentUser?.uid
    var ref : DatabaseReference!
    
    @IBOutlet weak var exerciseTextField: UITextField!
    @IBOutlet weak var showWorkoutTable: UITableView!
    @IBOutlet weak var addExerciseStyle: UIButton!
    
    @IBOutlet weak var workoutTitle: UILabel!
    
    
    override func viewDidLoad() {
        addExerciseStyle.layer.cornerRadius = 20
        editLabel.layer.cornerRadius = 20
        self.exerciseTextField.delegate = self
        ref = Database.database().reference()
        exerciseTextField.isHidden = true
        addExerciseStyle.isHidden = true
        editLabel.isHidden = true
       workoutTitle.text = workout?.title
    }

    
    @IBAction func addExercise(_ sender: UIButton) {
        
        if exerciseTextField.text != "" {
            workout?.exercises.append(exerciseTextField.text!)
            
            let workoutRef = ref.child(currentUserId!).child("Workouts").child((workout?.id)!)
            workoutRef.child("exercises").setValue(workout?.exercises)
        }

        exerciseTextField.text? = ""
        
        showWorkoutTable.reloadData()
        
        view.endEditing(true)
    }
    
    @IBOutlet weak var editLabel: UIButton!
    @IBAction func editWorkout(_ sender: UIButton) {
        showWorkoutTable.isEditing = !showWorkoutTable.isEditing
        if sender.currentTitle == "Edit" {
            editLabel.setTitle("Done", for: .normal)
        } else {
            editLabel.setTitle("Edit", for: .normal)
        }
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let wo = workout {
            return wo.exercises.count
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size:20)
        
        cell.textLabel?.text = workout?.exercises[indexPath.row]
        
        return cell
        
    }

    
    // gör så att man kan radera en rad i tableviewn genom att swipa med fingret
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            workout?.exercises.remove(at: indexPath.row)
            
            let workoutRef = ref.child(currentUserId!).child("Workouts").child((workout?.id)!)
            workoutRef.child("exercises").setValue(workout?.exercises)
            showWorkoutTable.reloadData()

        }
    }    
    
    // lägger till ett checkmark vid högra sidan i tableviewn om man klickar på den och tar bort om man klickar igen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
     // gör så att man kan ändra ordningen på exercises när man skapar passet
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = workout?.exercises[sourceIndexPath.row]
        workout?.exercises.remove(at: sourceIndexPath.row)
        workout?.exercises.insert(item!, at: destinationIndexPath.row)
        let workoutRef = ref.child(currentUserId!).child("Workouts").child((workout?.id)!)
        workoutRef.child("exercises").setValue(workout?.exercises)
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
    
    @IBOutlet weak var showEditStyle: UIBarButtonItem!
    @IBAction func showEdit(_ sender: UIBarButtonItem) {
        if showEditStyle.image == UIImage(named: "ShowEdit"){
            showEditStyle.image = UIImage(named: "EditDone")
            exerciseTextField.isHidden = false
            addExerciseStyle.isHidden = false
            editLabel.isHidden = false
            workoutTitle.isHidden = true
        } else if (editLabel.currentTitle != "Done") {
            showEditStyle.image = UIImage(named: "ShowEdit")
            exerciseTextField.isHidden = true
            addExerciseStyle.isHidden = true
            editLabel.isHidden = true
            workoutTitle.isHidden = false
        }
    }
}

