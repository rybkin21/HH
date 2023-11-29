
import Foundation

extension String {
    var attributedStringFromHTML: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch let error {
            print("Ошибка при преобразовании HTML: \(error.localizedDescription)")
            return nil
        }
    }
}
