import SnapshotTesting
@testable import StencilRenderer
import XCTest

final class StencilRendererTests: XCTestCase {
    private func getFilePath(_ path: String) -> String {
        let file = #file
        let fileUrl = URL(fileURLWithPath: "\(file)", isDirectory: false)
        return fileUrl
            .deletingLastPathComponent()
            .appendingPathComponent("__Examples__")
            .appendingPathComponent(path)
            .path
    }

    func testGenerateColors() throws {
        let template = getFilePath("Colors/colors.stencil")
        let jsonDataSource = getFilePath("Colors/colors.json")
        let yamlDataSource = getFilePath("Colors/colors.yaml")

        let renderer = StencilRenderer()

        let generatedFileFromJson = try renderer.renderTemplate(templatePathString: template, dataSourcePathString: jsonDataSource)
        let generatedFileFromYaml = try renderer.renderTemplate(templatePathString: template, dataSourcePathString: yamlDataSource)

        assertSnapshot(matching: generatedFileFromJson, as: .lines)
        assertSnapshot(matching: generatedFileFromYaml, as: .lines)
    }

    static var allTests = [
      ("testGenerateColors", StencilRendererTests.testGenerateColors),
    ]
}
