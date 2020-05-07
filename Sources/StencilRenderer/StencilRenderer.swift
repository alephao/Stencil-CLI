import PathKit
import Stencil
import StencilSwiftKit

public class StencilRenderer {
    private let environment: Environment

    public init() {
        let ext = Extension()
        ext.registerStencilSwiftExtensions()

        let loader = FileSystemLoader(paths: ["."])
        environment = Environment(loader: loader, extensions: [ext], templateClass: StencilSwiftTemplate.self)
    }

    public func run(templatePathString: String, dataSourcePathString: String, outputPathString: String) throws {
        let templateRendered = try renderTemplate(templatePathString: templatePathString, dataSourcePathString: dataSourcePathString)
        let outputPath = Path(outputPathString)
        try outputPath.write(templateRendered)
    }

    public func renderTemplate(templatePathString: String, dataSourcePathString: String) throws -> String {
        let dataSource = try loadDataSource(path: dataSourcePathString)
        return try environment.renderTemplate(name: templatePathString, context: dataSource)
    }
}
