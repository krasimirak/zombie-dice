import Player
import Die

public class Game {
    var players: [Player] = []
    var dice: [Die] = []
    var dieInUse: [Bool] = []
    public init (numberOfPlayers: Int) {
        
        for i in 1...numberOfPlayers {
            let newPlayer = getPlayer(playerNumber: i)
            players.append(newPlayer)
        }
        
        for _ in 1...6 {
            dice.append(Die.green)
            dieInUse.append(false)
        }
        
        for _ in 1...4 {
            dice.append(Die.yellow)
            dieInUse.append(false)
        }
        
        for _ in 1...3 {
            dice.append(Die.red)
            dieInUse.append(false)
        }
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


func getPlayer(playerNumber: Int) -> Player {
    print("\n\nPlease enter player \(playerNumber) name: ")
    let inputName: String? = readLine()
    let defaultName:String = "Player \(String(playerNumber))"
    
    if inputName == nil {
        return Player(defaultName)
    }
    if inputName! == "" {
        return Player(defaultName)
    }
    
    return Player(inputName!)
}

public func startGame() {
    print("\n\nIf you want to start a game press enter\n If you want to quit type whatever you want then press enter.")
    let initialCommand = readLine()
    
    if initialCommand != "" {
        print("\n\nExiting program")
        return
    }

    let numPlayers = getNumPlayers()
    let _ = Game(numberOfPlayers: numPlayers)
}
