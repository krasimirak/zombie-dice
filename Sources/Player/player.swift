import Person

public class Player: Person {
    var points: Int
    
    public override init(_ name: String? = nil) throws {
        points = 0
        try super.init(name)
    }
    
    public convenience init(playerNumber: Int) throws {
        let defaultName = "Player \(playerNumber)"
        try self.init(defaultName)
    }
    
    deinit {
        print("Clearing player: \(name) from memory")
    }
}


extension Player {
    public func addPoints(newPoints: Int) {
        self.points += newPoints
    }
    public func getPoints() -> Int {  points  }
    public func resetResult() {  points = 0  }
}
