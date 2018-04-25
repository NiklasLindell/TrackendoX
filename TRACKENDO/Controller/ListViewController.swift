import UIKit
import Firebase

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let segueToShow = "goToShowWorkout"
    let segueToAdd = "goToAdd"
    var workoutList : [Workout]?
    let cellID = "cellIdentifier"
    var selectedWorkout : Workout?
    var ref : DatabaseReference!
    var currentUserId = Auth.auth().currentUser?.uid

    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if (workoutList == nil) {
            workoutList = []
            
        }
        
        ref = Database.database().reference()
        
        ref.child(currentUserId!).child("Workouts").observeSingleEvent(of: .value, with: { (snapshot) in
            
            var workoutList : [Workout] = []
            
            for item in snapshot.children{
                let listItem = Workout(snapshot: item as! DataSnapshot)
                workoutList.append(listItem)
            }
            self.workoutList = workoutList
            self.tableView?.reloadData()
        })

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
            cell.detailTextLabel?.text =  workout[indexPath.row].date
      
        }
        cell.textLabel?.textColor = UIColor.white
        cell.detailTextLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name:"Copperplate", size:25)
        cell.detailTextLabel?.font = UIFont(name: "Copperplate", size: 15)
        return cell
    }
    
    // gör så att man kan radera en rad i tableviewn genom att swipa med fingret
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let workout = workoutList![indexPath.row]
            workoutList?.remove(at: indexPath.row)
            removeFromDB(workout: workout)
            tableView.reloadData()
        }
    }
    
    // Skickar över data till ShowWorkout om man klickar på en titel
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWorkout = (workoutList?[indexPath.row])!
        
        performSegue(withIdentifier: segueToShow, sender: self)
        
    }
    
    
//     Skickar över listan från denna sida till ShowWorkout så att dem är samma
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == segueToShow) {
             let destination = segue.destination as! ShowWorkout
                destination.workout =  selectedWorkout!

        }
    }
    
    func removeFromDB(workout : Workout){
        
        let woRef = ref.child(currentUserId!).child("Workouts").child(workout.id)
        woRef.removeValue()
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        
        let refreshAlert = UIAlertController(title: "Log out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            refreshAlert .dismiss(animated: true, completion: nil)
        }))
        present(refreshAlert, animated: true, completion: nil)
        
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        }
        catch {
            print("error: there was a problem logging out")
        }
        
       
    }
    
}

