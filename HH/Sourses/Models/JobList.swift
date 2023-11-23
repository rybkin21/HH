
import Foundation

struct JobList: Decodable {
    var items: [Item]
    let found: Int
    let pages: Int
    let perPage: Int
    var page: Int
    let alternateUrl: String

    private enum CodingKeys: String, CodingKey {
        case items
        case found
        case pages
        case perPage = "per_page"
        case page
        case alternateUrl = "alternate_url"
    }
}

struct Item: Decodable {
    let id: String?
    let name: String?
    let salary: Salary?
    let employer: Employer?
    let snippet: Snippet?
}

struct Salary: Decodable {
    let from: Int?
    let to: Int?
    let currency: String
}

struct Employer: Decodable {
    let id: String?
    let name: String?
    let logoUrls: LogoUrls?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoUrls = "logo_urls"
    }
}

struct LogoUrls: Decodable {
    let original: String?
    let small: String?
    let medium: String?

    private enum CodingKeys: String, CodingKey {
        case original
        case small = "90"
        case medium = "240"
    }
}

struct Snippet: Decodable {
    let requirement: String?
    let responsibility: String?
}
