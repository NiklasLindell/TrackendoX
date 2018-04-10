import Foundation
import Firebase

class Workout {
    
    var title: String
    var exercises: [String]
    
    init(title: String) {
        self.title = title
        self.exercises = []
    }    
}
