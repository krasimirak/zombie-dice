import Die
import Player
import Result
import Helpers

public struct Turn {
    var currentBrains: Int = 0
    var currentFeet: Int = 0
    var currentBombs: Int = 0
    
    var inUse: [Bool] = []
    var diceToRoll: [Int] = []
    var player: Player
    var winningTurn: Bool = false
    
    public init(diceCollection: [Die], player: inout Player) {
        self.player = player

        // initiate turn with all dice unsed
        for _ in 1...diceCollection.count {
            inUse.append(false)
        }
        
        // then start turn
        let result: Result = startTurn(gameDice: diceCollection)
        
        switch result {
        case .win:
            winningTurn = true
        case .noPoints:
            print("You got 3 bombs; No points added")
        case .addedPoints:
            player.addPoints(newPoints: currentBrains)
            print("\(currentBrains) points added!")
        default:
            break
        }
    }
}

extension Turn {
    public mutating func startTurn(gameDice: [Die]) -> Result {
        var stopTurn: Result
        repeat {
            stopTurn = rollDice(gameDice: gameDice)
        }
        while stopTurn == .doNothing
        
        return stopTurn
    }
}

extension Turn {
    mutating func rollDice(gameDice: [Die]) -> Result {
        let newDice: [Int] = chooseDice(numberOfDice: 3 - diceToRoll.count)
        diceToRoll.append(contentsOf: newDice)
        
        var result: String = ""
        var currentDieColor: Die
        var currentDieResult: String
        var toRollAgain: [Int] = []
        
        currentFeet = 0
        
        print("\n\nDice you rolled are:")
        
        for diceIndex in diceToRoll {
            currentDieColor = gameDice[diceIndex];
            currentDieResult = rollADie(die: currentDieColor);
            result += "\(currentDieColor): \(currentDieResult) \t"

            if currentDieResult == "👣" {
                toRollAgain.append(diceIndex)
            }

            if checkRollResult(result: currentDieResult) == .noPoints {
                printTurnResult(result)
                return .noPoints
            }
        }

        printTurnResult(result)
        
        if player.getPoints() + currentBrains >= 13 {
            return .win
        }
        
        print("Do you want to keep the points or continue. Enter: k to keep or press enter to continue rolling the dice")
        let action = readLine()
        
        if action == "k" {
            return .addedPoints
        }
        
        return .doNothing
    }
}

extension Turn {
    mutating func chooseDice(numberOfDice: Int) -> [Int] {
        let diceIndexes = 0...(inUse.count - 1)
       
        // check if needed dice for turn are more than the available dice
        var freeDice: Int = 0
        for i in diceIndexes {
            if !inUse[i] {
                freeDice += 1
            }
        }

        var toChoose: Int = numberOfDice
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
}

extension Turn {
    mutating func checkRollResult(result: String) -> Result { // returns if turn should be stopped
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
            return .noPoints
        }
        
        return .doNothing
    }
}

extension Turn {
    public func isAWin() -> Bool { winningTurn }
}


extension Turn {
    func printTurnResult(_ result: String) {
        let lineLength: Int = result.count + 3 * 4 // adding tabulation
        
        var toPrint: String = appendChar(times: lineLength, char: "=")
        toPrint += "\n"
        toPrint += result
        toPrint += "\n"
        toPrint += appendChar(times: lineLength, char: "=")
        toPrint += "\n"
        
        print(toPrint)
    }
}
