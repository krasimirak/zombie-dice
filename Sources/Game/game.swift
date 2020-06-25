import Player
import Die

public class Game {
    var players: [Player]
    var diceWithStatus: [Die: Bool]?
    public init (numberOfPlayers: Int) {
        players = []
        diceWithStatus = nil
    }
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
