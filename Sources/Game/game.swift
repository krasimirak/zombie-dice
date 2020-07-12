import Player
import Die
import Turn
import Result
import Helpers

public func startGame() {
    print("\n\nIf you want to start a game press enter\n If you want to quit type whatever you want then press enter.")
    let initialCommand = readLine()
    
    if initialCommand != "" {
        print("\n\nExiting program")
        return
    }

    let numPlayers = getNumPlayers()
    do {
        let _ = try Game(numberOfPlayers: numPlayers)
    }
    catch {
        print("Something went wrong! Did you follow the instructions?")
    }
}

func getNumPlayers() -> Int {
    var numPlayersInput: String? = nil
    
    while(numPlayersInput == nil) {
        print("To start the game - please enter number of players (between 2 and 8):")
        numPlayersInput = readLine()
    }
    
    return validateNumberOfPlayers( Int(numPlayersInput!) )
}

func validateNumberOfPlayers(_ num: Int?) -> Int {
    if num == nil {
        // If not contertable to Int ask for valid input
        print("\n\nPlease enter a valid number between 2 and 8")
        return getNumPlayers()
    } else if num! < 2 {
        print("\n\nNot enough players! Minimum is 2. Please enter number of players: ")
        return getNumPlayers()
    } else if num! > 8 {
        print("\n\nExceeded amount of players. Maximum is 8. Please enter number of players: ")
        return getNumPlayers()
    }
    
    return num!
}

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

var appendDie: (inout [Die], Die, Int) -> Void = { (arr, color, count) in
    for _ in 1...count {
        arr.append(color)
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
