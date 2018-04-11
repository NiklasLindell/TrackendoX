//import UIKit
//import Firebase
//
//class ShowWorkouts: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    override func viewDidLoad() {
//
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    }
//
//
//
//    // lägger till ett checkmark vid högra sidan i tableviewn om man klickar på den och tar bort om man klickar igen
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//}

