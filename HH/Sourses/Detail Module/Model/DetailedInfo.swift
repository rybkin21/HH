
import Foundation

struct DetailedInfo: Decodable {
    let id: String?
    let name: String?
    let salary: Salary?
    let description: String?
    let area: Area?
}

struct Area: Decodable {
    let name: String?
}
