import Die
import Player

public struct Turn {
    var currentBrains: Int = 0
    var currentFeet: Int = 0
    var currentBombs: Int = 0
    
    var inUse: [Bool] = []
    var diceToRoll: [Int] = []
    var player: Player
    
    public init(diceCollection: [Die], player: inout Player) {
        self.player = player

        // initiate turn with all dice unsed
        for _ in 1...diceCollection.count {
            inUse.append(false)
        }
        
        // then start turn
        startTurn(gameDice: diceCollection)
    }
    
    mutating func chooseDice(numberOfDice: Int) -> [Int] {
        let diceIndexes = 0...(inUse.count - 1)
        
        // check if needed dice for turn are more than the available dice
        var freeDice: Int = 0
        for i in diceIndexes {
            if !inUse[i] {
                freeDice += 1
            }
        }

        var toChoose = numberOfDice
        if freeDice < numberOfDice {
            toChoose = freeDice // if there are less unused dice make the number of dice needed to be how many are available
        }
        
        var resultDiceIndex: [Int] = []
        var currentIndex: Int = 0
        if toChoose == 0 {
            return []
        }
        
        // get as many dice indexes as need checking if they are in use already
        for _ in 1...toChoose {
            
            repeat {
                currentIndex = Int.random(in: diceIndexes)
            } while (inUse[currentIndex])
            
            resultDiceIndex.append(currentIndex)
            inUse[currentIndex] = true
        }
        
        return resultDiceIndex
    }
    
    public mutating func startTurn(gameDice: [Die]) -> Int {
        func rollDice() -> Result {
            let newDice: [Int] = chooseDice(numberOfDice: 3 - diceToRoll.count)
            diceToRoll.append(contentsOf: newDice)
            var result: String = ""
            var currentDieColor: Die
            var currentDieResult: String
            var toRollAgain: [Int] = []
            var count = 0
            
            currentFeet = 0
            
            print("Dice you rolled are:")
            
            for diceIndex in diceToRoll {
                currentDieColor = gameDice[diceIndex];
                currentDieResult = rollADie(die: currentDieColor);
                result += "\(currentDieColor): \(currentDieResult)\t"

                if currentDieResult == "👣" {
                    toRollAgain.append(diceIndex)
                }

                if checkRollResult(result: currentDieResult) {
                    print(result)
                    return Result.noPoints
                }
            }
            print(result)

            if player.getPoints() + currentBrains >= 13 {
                return Result.win
            }
            
            print("Do you want to keep the points or continue. Enter: k to keep or press enter to continue rolling the dice")
            let action = readLine()
            
            if action == "k" {
                return Result.addedPoints
            }
            
            return Result.doNothing
        }
        
        var stopTurn: Result
        
        repeat {
            stopTurn = rollDice()
        }
        while stopTurn != Result.win && stopTurn != Result.noPoints
        
        return 0
    }

    mutating func checkRollResult(result: String) -> Bool { // returns if turn should be stopped
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
        
        if currentBombs >= 3 {
            endTurn(points: 0)
            return true
        }
        
        return false
        
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


enum Result: String {
    case win = "won the game"
    case noPoints = "got 3 or more bombs"
    case addedPoints = "added points"
    case doNothing = "New dice are rolled"
}
