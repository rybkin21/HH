
import Foundation

extension String {
    func removingTags() -> String {
        return self.replacingOccurrences(of: "<highlighttext>", with: "")
                .replacingOccurrences(of: "</highlighttext>", with: "")
    }
}
