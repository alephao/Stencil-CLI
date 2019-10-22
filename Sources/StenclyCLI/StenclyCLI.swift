import StenclyKit
import SwiftCLI

public class StenclyCLI {
    private let cli: CLI

    public init() {
        let renderCommand = RenderCommand()

        cli = CLI(
            name: "stencly",
            version: VERSION,
            description: "Render stencil templates using a data source",
            commands: [renderCommand]
        )

        cli.parser.routeBehavior = .searchWithFallback(renderCommand)
    }

    public func run() {
        cli.goAndExit()
    }
}

class RenderCommand: Command {
    let name = "render"
    let shortDescription: String = "Render a stencil template using a data source"

    let templatePath = Key<String>("-t", "--template", description: "The path to the stencil template you want to render.")
    let dataSourcePath = Key<String>("-d", "--datasource", description: "The path to the datasource. A JSON or Yaml file.")
    let outputPath = Key<String>("-o", "--output", description: "The path where you want to save the generated file.")

    func execute() throws {
        let stencly = Stencly()

        let template = getTemplatePathIfMissing()
        let dataSource = getDataSourcePathIfMissing()
        let output = getOutputPathIfMissing()

        try stencly.run(templatePathString: template, dataSourcePathString: dataSource, outputPathString: output)

        stdout <<< "Rendered file on path \(output)"
    }

    private func getTemplatePathIfMissing() -> String {
        return templatePath.value ?? Input.readLine(prompt: "Template path:")
    }

    private func getDataSourcePathIfMissing() -> String {
        return dataSourcePath.value ?? Input.readLine(prompt: "Data source path:")
    }
    private func getOutputPathIfMissing() -> String {
        return outputPath.value ?? Input.readLine(prompt: "Output path:")
    }
}
