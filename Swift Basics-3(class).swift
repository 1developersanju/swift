import UIKit

class SpaceShip {
    var fuelLevel = 100
    var oxigenSupply = "proper"
    var name = ""
    
    func thrust()  {
        print("SpaceShip thrusters are initiated for \(name)")
    }
    func cruise()  {
        print("Cruising is initiated for \(name)")
    }
   
}
var myShip = SpaceShip()
myShip.name = "SpaceX"
myShip.cruise()
myShip.thrust()
print("This SpaceShip contains \(myShip.fuelLevel)% of fuel")
print("Name of the SpaceShip is \(myShip.name)")
print("There is a \(myShip.oxigenSupply) Oxygen Supply.")
