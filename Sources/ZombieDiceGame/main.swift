import Die
import Player

let dice: Die = .green
print("Test what you get with a green die \t \(greenDie.shuffled()[0]) ")
print("Game start")

let player1 = Player()
let krasi = Player("Krasi")
print("Player1: \( player1.getName() ); Player2: \( krasi.getName() )")
