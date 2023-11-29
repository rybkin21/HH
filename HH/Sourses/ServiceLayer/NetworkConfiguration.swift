
import Foundation

struct NetworkConfiguration {
    private enum Key: String {
        case mainUrl
    }

    static var mainUrl: String {
        guard let mainUrl = Bundle.main.infoDictionary![Key.mainUrl.rawValue] as? String else {
            return "No value by key \(Key.mainUrl.rawValue)"
        }
        return mainUrl
    }
}
