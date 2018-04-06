import Foundation
import Firebase

class Workout {
    
    var title: String
    var exercises: [Exercise]
    
    init(title: String) {
        self.title = title
        self.exercises = []
    }    
}
