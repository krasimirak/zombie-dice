import Die

public struct Turn {
    var currentBrains: Int = 0
    var currentFeet: Int = 0
    var currentBombs: Int = 0
    
    var inUse: [Bool]
    
    init(diceCollectionCount: Int) {
        for _ in 1...diceCollectionCount {
            inUse.append(false)
        }
    }
    
    mutating func chooseDice(inout numberOfDice: Int, diceCollectionCount: Int, inout inUse: [Bool]) -> [Int] {
        let diceIndexes = 0...(diceCollectionCount - 1)
        
        // check if needed dice for turn are more than the available dice
        var freeDice: Int = 0
        for i in diceIndexes {
            if ! inUse[i] {
                freeDice += 1
            }
        }
        
        if freeDice < numberOfDice {
            numberOfDice = freeDice // if there are less unused dice make the number of dice needed to be how many are available
        }
        
        var resultDiceIndex: [Int] = []
        var currentIndex: Int = 0
        // get as many dice indexes as need checking if they are in use already
        for _ in 1...numberOfDice {
            
            repeat {
                currentIndex = Int.random(in: diceIndexes)
            } while (inUse[currentIndex])
            
            resultDiceIndex.append(currentIndex)
            inUse[currentIndex] = true
        }
        
        
    }
    
    func startTurn() {
        
    }
        
}

