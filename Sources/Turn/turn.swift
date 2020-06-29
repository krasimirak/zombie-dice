import Die

public struct Turn {
    var currentBrains: Int = 0
    var currentFeet: Int = 0
    var currentBombs: Int = 0
    
    mutating func chooseDice(numberOfDice: Int, diceCollection: [Die], inUse: [Bool]) {
        var diceIndex: [Int] = []
        for _ in 1...numberOfDice {
            var die = Int.random(in: 0...12)
            
            while(inUse[die]) {
                die = Int.random(in: 0...12)
            }
            
            diceIndex.append(die)
        }
    }
    
    func startTurn() {
        
    }
        
}

