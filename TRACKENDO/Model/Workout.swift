import Foundation
import Firebase

class Workout {
    
    var title: String
    var exercises: [String]
    var id: String
    
    init() {
        self.title = ""
        self.exercises = []
        self.id = ""
    }
 
    init( snapshot : DataSnapshot ) {
        let snapshotValue = snapshot.value as! [ String : AnyObject]
        title = snapshotValue["title"] as! String
        exercises = snapshotValue["exercises"] as! [String]
        id = snapshot.key
    }
    
    func toAnyObject() -> Any {
        return [ "title" : title, "exercises" : exercises]
    }

    
    
}
