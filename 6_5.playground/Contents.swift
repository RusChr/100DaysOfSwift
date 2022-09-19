import UIKit

func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel() {
    print("I'm driving in my car")
}

travel {
    print("I'm driving in my car")
}


//test
func testTravel(test: String, action: () -> Void) {
    print("\(test) I'm getting ready to go.")
    action()
    print("\(test) I arrived!")
}

testTravel(test: "Test") {
    print("I'm driving in my car")
}

print()
func goCamping(then action: () -> Void) {
    print("We're going camping!")
    action()
}

goCamping {
    print("Sing songs")
    print("Put up tent")
    print("Attempt to sleep")
}

print()
goCamping(){}
goCamping {
    
}
