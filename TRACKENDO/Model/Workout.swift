import Foundation
import Firebase

class Workout {
    
    var title: String
    var exercises: [String]

    
    init() {
        self.title = ""
        self.exercises = []
    }
 
    init( snapshot : DataSnapshot ) {
        let snapshotValue = snapshot.value as! [ String : AnyObject]
        title = snapshotValue["title"] as! String
        exercises = snapshotValue["exercises"] as! [String]
    }
    
    func toAnyObject() -> Any {
        return [ "title" : title, "exercises" : exercises]
    }

    
    
}
