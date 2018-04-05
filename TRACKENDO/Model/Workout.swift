import Foundation
import Firebase

class Workout {
    
    var title: String
    var exercise: String
    var reps: Int
    var set: Int
    
    init(title: String, exercise: String, reps: Int, set: Int) {
        self.title = title
        self.exercise = exercise
        self.reps = reps
        self.set = set
    }
    
//    init(snapshot: DataSnapshot) {
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        title = snapshotValue["title"] as! String
//        exercise = snapshotValue["exercise"] as! String
//        reps = snapshotValue["reps"] as! Int
//        set = snapshotValue["set"] as! Int
//        
//    }
//    
//    func toAnyObject() -> Any {
//        return ["title": title, "exercise": exercise, "reps": reps, "set": set]
//    }
    
}
