import Foundation
import Firebase

class Workout {
    
    var title: String
    var exercises: [String]
    var id: String
    let date: String
    let dateFormatter = DateFormatter()
    
    
    
    
    init() {
        self.title = ""
        self.exercises = []
        self.id = ""
        dateFormatter.dateFormat = "MM-dd-yyyy"
        self.date = dateFormatter.string(from: Date())
    }
 
    init( snapshot : DataSnapshot ) {
        let snapshotValue = snapshot.value as! [ String : AnyObject]
        title = snapshotValue["title"] as! String
        if let exercises = snapshotValue["exercises"] as? [String] {
            self.exercises = exercises
        } else {
            self.exercises = [String]()
        }
        date = snapshotValue["date"] as! String
        id = snapshot.key
    }
    
    func toAnyObject() -> Any {
        return [ "title" : title, "exercises" : exercises, "date" : date]
    }

    
}
