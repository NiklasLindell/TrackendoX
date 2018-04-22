import UIKit
import Firebase

class AddWorkoutViewController: UIViewController,UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate {
  
    let segueID = "goToTableView"
    
    var workoutList : [Workout]? 
    
    var workout : Workout?
    
    
    @IBOutlet weak var addTableView: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var exerciseTextField: UITextField!
    
    @IBOutlet weak var addExerciseStyle: UIButton!
    
    @IBOutlet weak var editStyle: UIButton!
    
    @IBOutlet weak var saveStyle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addExerciseStyle.layer.cornerRadius = 20
        editStyle.layer.cornerRadius = 20
        saveStyle.layer.cornerRadius = 20
        
        
        self.titleTextField.delegate = self
        self.exerciseTextField.delegate = self
       
        workout = Workout()
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
        cell.textLabel?.font = UIFont(name: (cell.textLabel?.font.fontName)!, size:20)
        
        
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

    @IBOutlet weak var editLable: UIButton!
    @IBAction func edit(_ sender: UIButton) {
        addTableView.isEditing = !addTableView.isEditing
        if sender.currentTitle == "Edit" {
            editLable.setTitle("Done", for: .normal)
        } else {
            editLable.setTitle("Edit", for: .normal)
        }
        
    
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
        
        if exerciseTextField.text != "" {
            workout?.exercises.append(exerciseTextField.text!)
        }
        exerciseTextField.text? = ""
        
        addTableView.reloadData()
        
        view.endEditing(true)
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        if (titleTextField.text != "" && exerciseTextField.text == "" && addTableView != nil){

            workout?.title = titleTextField.text!
            workoutList?.append(workout!)
        
            createAlertAdd(title: "Saved", message: "Your workout has been saved")
            titleTextField.text = ""
            exerciseTextField.text = ""
            addTableView.reloadData()
          
            let workoutDB = Database.database().reference().child("Workouts")
            
            let childRef = workoutDB.childByAutoId()
            childRef.setValue(workout?.toAnyObject())
            
            workout?.exercises.removeAll()
            addTableView.reloadData()
        }
        
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        
        if (titleTextField.text != "" && exerciseTextField.text == "" && addTableView != nil){
            createAlertAdd(title: "Hey!", message: "You need to save your workout before you go back")
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
  

    // Skapar ett alert message för att säga att datan är sparad
    func createAlertAdd(title: String, message:String ){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}












