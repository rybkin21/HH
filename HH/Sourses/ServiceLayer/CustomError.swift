
import Foundation

class CustomError: Error {
    var message: String

    init(message: String) {
        self.message = message
    }
}
