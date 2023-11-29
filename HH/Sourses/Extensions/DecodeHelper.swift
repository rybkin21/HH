
import Foundation

class DecodeHelper {
    static let shared: DecodeHelper = DecodeHelper()
    private let jsonDecoder = JSONDecoder()

    private init() {}

    func decode<T: Decodable>(data: Data?, type: T.Type) -> T? {
        guard let data = data else {
            return nil
        }

        do {
            return try jsonDecoder.decode(type, from: data)
        } catch {
            print("Failed to decode date \(error)")
            return nil
        }
    }
}
