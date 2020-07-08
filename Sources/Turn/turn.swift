import Die
import Player

public struct Turn {
    var currentBrains: Int = 0
    var currentFeet: Int = 0
    var currentBombs: Int = 0
    
    var inUse: [Bool] = []
    
    public init(diceCollection: [Die], player: inout Player) {
        // initiate turn with all dice unsed
        for _ in 1...diceCollection.count {
            inUse.append(false)
        }
        
        // then start turn
        startTurn(gameDice: diceCollection, player: player)
    }
    
    mutating func chooseDice(numberOfDice: inout Int) -> [Int] {
        let diceIndexes = 0...(inUse.count - 1)
        
        // check if needed dice for turn are more than the available dice
        var freeDice: Int = 0
        for i in diceIndexes {
            if !inUse[i] {
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
        
        return resultDiceIndex
    }
    
    public mutating func startTurn(gameDice: [Die], player: inout Player) -> Int {
        func rollDice(diceToUse: [Int]) -> Bool {
            var diceToRoll: Int = 3 - diceToUse.count
            var diceToRollIndexes: [Int] = diceToUse
            let newDice: [Int] = chooseDice(numberOfDice: &diceToRoll)
            diceToRollIndexes.append(newDice)
            
            var result: String = ""
            var currentDieColor: Die
            var currentDieResult: String
            var toRollAgain: [Int]
            var count = 0
            
            currentFeet = 0
           print("Dice you rolled are:")
           for diceIndex in diceToRollIndexes {
               currentDieColor = gameDice[diceIndex]
               currentDieResult = rollADie(die: currentDieColor)
               result += "\(currentDieColor): \(currentDieResult)\t"
               
               checkRollResult(result: currentDieResult)
            
           }
           print(result)

        }
        
       
        rollDice(diceToUse: [])

        return 0
    }

    mutating func checkRollResult(result: String) {
        switch result {
        case "🧠":
            currentBrains += 1
        case "👣":
            currentFeet += 1
        case "💥":
            currentBombs += 1
        default:
            print("Unvalid result")
        }
        
        if currentFeet >= 3 {
            endTurn(points: 0)
        }
    }
    
    func endTurn(points: Int) {
        
        if points == 0 {
            print("You have at least 3 bombs\n You do not get points from your turn")
        }
        else {
            print("\(points) \(points == 1 ? "point has" : "points have") been added to your result")
        }
    }
}



