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
        dateFormatter.dateFormat = "dd/MM-yy"
        self.date = dateFormatter.string(from: Date())
    }
 
    init( snapshot : DataSnapshot ) {
        let snapshotValue = snapshot.value as! [ String : AnyObject]
        title = snapshotValue["title"] as! String
        exercises = snapshotValue["exercises"] as! [String]
        date = snapshotValue["date"] as! String
        id = snapshot.key
    }
    
    func toAnyObject() -> Any {
        return [ "title" : title, "exercises" : exercises, "date" : date]
    }

    
}
