import UIKit

func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}

travel { (place: String) in
    print("I'm going to \(place) in my car")
}


//test
print()

travel { str in
    print(str)
}

print()

travel { str in
    print("asdflkj")
}
//

print()

let changeSpeed = { (speed: Int) in
    print("Changing speed to \(speed)kph")
}

func buildCar(name: String, engine: (Int) -> Void) {
    // build the car
}
