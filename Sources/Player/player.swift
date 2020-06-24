public class Player {
    var name: String?
    var points: Int
    
    public init(_ name: String? = nil) {
        if name == nil {
            self.name = "No name"
        }
        else {
            self.name = name
        }

        points = 0
    }
    
    public func addPoints(newPoints: Int) {
        self.points += newPoints
    }

    public func getName() -> String {   name!    }
    public func getPoints() -> Int {  points  }
    public func resetResult() {  points = 0  }
}
