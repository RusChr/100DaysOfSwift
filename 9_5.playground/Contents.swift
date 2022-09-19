import UIKit

struct FaceBookUser {
    private var privatePosts: [String]
    public var publicPosts: [String]
    
    init(privatePosts: [String], publicPosts: [String]) {
        self.privatePosts = privatePosts
        self.publicPosts = publicPosts
    }
}
let user = FaceBookUser(privatePosts: ["1", "2"], publicPosts: ["3", "4"])
user.publicPosts

//


struct Order {
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
}
let order = Order(id: 1)

//

struct Doctor {
    var name: String
    var location: String
    private var currentPatient = "No one"
    
    init(name: String, location: String) {
        self.name = name
        self.location = location
    }
}
let doc = Doctor(name: "aa", location: "gr")

//

struct Contributor {
    private var name = "Anonymous"
}
let paul = Contributor()


