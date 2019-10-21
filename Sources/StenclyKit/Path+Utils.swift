import Foundation
import PathKit

extension Path {
    var isJSONFile: Bool {
        guard isFile,
            let fileExtension = self.extension else { return false }
        return fileExtension.lowercased() == "json"
    }

    var isYamlFile: Bool {
        guard isFile,
            let fileExtension = self.extension else { return false }
        return ["yaml", "yml"].contains(fileExtension.lowercased())
    }
}
