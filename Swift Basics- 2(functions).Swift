import UIKit

// basic function

// when functions are put into a class,they are called metods.

func sayHi() {
    print("hiii")
}
sayHi()

//function with parameters

func sayHello(name:String) {
print("Hello \(name)")
}
sayHello(name: "Sanjeev")

//>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<>>>>>>>>>>>><<<<<<<<<<>>>>>>>>>>>>><<<<<<<>>>>>>>>

func sayHello(name:String,age:Int) {
    print("Hello \(name), You are \(age) years old.")
}
sayHello(name: "Sanjeev", age: 17)

func addNumber(x:Int) -> Int{
    let sum = x + 4
    return sum
}
var result = addNumber(x: 30)
print (result)
