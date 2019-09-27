import XCTest
import SnapshotTesting
@testable import StenclyKit

final class StenclyTests: XCTestCase {
    private func getFilePath(_ path: String) -> String {
        let file = #file
        let fileUrl = URL(fileURLWithPath: "\(file)", isDirectory: false)
        return fileUrl
            .deletingLastPathComponent()
            .appendingPathComponent("__Examples__")
            .appendingPathComponent(path)
            .path
    }

    func testGenerateColors() {
        let template = getFilePath("Colors/colors.stencil")
        let jsonDataSource = getFilePath("Colors/colors.json")
        let yamlDataSource = getFilePath("Colors/colors.yaml")

        let generatedFileFromJson = try! generateFile(templatePathString: template, dataSourcePathString: jsonDataSource)
        let generatedFileFromYaml = try! generateFile(templatePathString: template, dataSourcePathString: yamlDataSource)

        assertSnapshot(matching: generatedFileFromJson, as: .lines)
        assertSnapshot(matching: generatedFileFromYaml, as: .lines)
    }

    static var allTests = [
        ("testGenerateColors", testGenerateColors),
    ]
}
