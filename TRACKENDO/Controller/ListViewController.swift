import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let segueToShow = "goToShowWorkout"
    let segueToAdd = "goToAdd"
    var workoutList : [Workout]?
    let cellID = "cellIdentifier"
    var selectedWorkout : Workout?

    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
   
        if (workoutList == nil) {
            workoutList = []
        }
        tableView?.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView?.reloadData()
    }
    
    // hur många rader det ska vara i tableviewn
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let workout = workoutList {
            return workout.count
        } else {
            return 0
        }
    }
    
    // vad som ska synas i varje rad i tableviewn
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        if let workout = workoutList {
            cell.textLabel?.text = workout[indexPath.row].title
        }
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    // gör så att man kan radera en rad i tableviewn genom att swipa med fingret
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            workoutList?.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    // Skickar över data till ShowWorkout om man klickar på en titel
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWorkout = (workoutList?[indexPath.row])!
        
        performSegue(withIdentifier: segueToShow, sender: self)
        
    }
    
    
//     skickar över listan från denna sida till add-sidan så att dem är samma
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == segueToAdd) {
            let destination = segue.destination as! AddWorkoutViewController
            destination.workoutList = self.workoutList
        } else if (segue.identifier == segueToShow) {
             let destination = segue.destination as! ShowWorkout
            destination.workout =  selectedWorkout!
            
        }
    }
    
}

