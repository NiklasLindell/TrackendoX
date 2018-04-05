import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let segueID = "goToAdd"
    var workoutList : [Workout]?
    let cellID = "cellIdentifier"

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
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if let workout = workoutList {
            cell.textLabel?.text = workout[indexPath.row].title
        }
        return cell
    }
    
    // gör så att man kan radera en rad i tableviewn genom att swipa med fingret
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            workoutList?.remove(at: indexPath.row)
            tableView.reloadData()
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
    
//     skickar över listan från denna sida till add-sidan så att dem är samma
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == segueID) {
            let destination = segue.destination as! AddWorkoutViewController
            destination.workoutList = self.workoutList
        }
    }
    
}

