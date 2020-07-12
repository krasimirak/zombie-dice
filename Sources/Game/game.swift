import Player
import Die
import Turn
import Result
import Helpers

public class Game {
    var players: [Player] = []
    var dice: [Die] = []
    
    public init (numberOfPlayers: Int) throws {
        var longestNameCount: Int = 0
        for i in 1...numberOfPlayers {
            let newPlayer = try getPlayer(playerNumber: i)
            players.append(newPlayer)
            
            if newPlayer.getName().count > longestNameCount {
                longestNameCount = newPlayer.getName().count
            }
        }
        
        appendDie(&dice, Die.green, 6)
        appendDie(&dice, Die.yellow, 4)
        appendDie(&dice, Die.red, 3)
        startTurns(tableCellWidth: longestNameCount + 3)
    }
    
    deinit {
        print("Clearing game from memory")
    }
}

var appendDie: (inout [Die], Die, Int) -> Void = { (arr, color, count) in
    for _ in 1...count {
        arr.append(color)
    }
}

extension Game {
    public func startTurns(tableCellWidth: Int) {
        for var player in players {
            let turn = Turn(diceCollection: dice, player: &player)
            
            printResults(tableCellWidth: tableCellWidth)
            if turn.isAWin() {
                print("\(player.getName()) has eaten \(player.getPoints()) brains! \( player.getName()) ) won !!")
                print("If you would like to continue a new game with the same players write C then press enter. If you would like to quit just press enter.")
                let action = readLine()
                
                if action != "C" {
                    return
                }
                
                // TO DO RESET GAME
            }
        }
    }
}

extension Game {
    func printResults(tableCellWidth: Int) {
        var result: String = "\n"

        for player in players {
            result += appendChar(times: tableCellWidth + 5, char: "=")
            result += "\n"
            
            let playerNameLength: Int = player.getName().count
            result += player.getName()
            result += appendChar(times: tableCellWidth - playerNameLength, char: " ")
            result += "| \(player.getPoints()) \n"
        }
        
        result += appendChar(times: tableCellWidth + 5, char: "=")
        result += "\n"
        print(result)
    }
}

extension Game {
    func getPlayer(playerNumber: Int) throws -> Player  {
        print("\n\nPlease enter player \(playerNumber) name: ")
        let inputName: String? = readLine()
        
        var player: Player
        
        do {
            player = try Player(inputName)
        }
        catch {
            player = try Player(playerNumber: playerNumber)
        }
        
        return player
    }
}
