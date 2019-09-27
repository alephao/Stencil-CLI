import Foundation
import PathKit
import StencilSwiftKit
import SwiftyJSON
import Yams

public func generateAndWriteFile(templatePathString: String, dataSourcePathString: String, outputPathString: String) {
    let generatedFile = try! generateFile(templatePathString: templatePathString, dataSourcePathString: dataSourcePathString)

    let outputPath = Path(outputPathString)
    try! outputPath.write(generatedFile)
}

public func generateFile(templatePathString: String, dataSourcePathString: String) throws -> String {
    let templatePath = Path(templatePathString)
    let dataSourcePath = Path(dataSourcePathString)

    let templateString: String = try templatePath.read()
    let template = StencilSwiftTemplate(templateString: templateString)
    let dataSource = try loadDataSource(path: dataSourcePath)

    let generatedFile = try template.render(dataSource)

    return generatedFile
}

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

func loadDataSource(path: Path) throws -> [String: Any]? {
    if path.isJSONFile {
        return try loadDataSourceJSON(path: path)
    } else if path.isYamlFile {
        return try loadDataSourceYaml(path: path)
    } else {
        fatalError("Unsupported file, input file should be .yaml, .yml, or .json")
    }
}

func loadDataSourceJSON(path: Path) throws -> [String: Any]? {
    let contentsOfFile: Data = try path.read()
    guard let loadedDictionary = try JSON(data: contentsOfFile).dictionaryObject else {
        fatalError("JSON root is not an object")
    }
    return loadedDictionary
}

func loadDataSourceYaml(path: Path) throws -> [String: Any]? {
    let contentsOfFile: String = try path.read()
    guard let loadedDictionary = try Yams.load(yaml: contentsOfFile) as? [String: Any] else {
        fatalError("Yaml root is not an object")
    }
    return loadedDictionary
}
