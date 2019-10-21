import Foundation
import PathKit
import SwiftyJSON
import Yams

func loadDataSource(path stringPath: String) throws -> [String: Any]? {
    let path = Path(stringPath)
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
