import ArgumentParser
import StencilRenderer

final class RenderCommand: ParsableCommand {
    static let configuration: CommandConfiguration = .init(
        commandName: "render",
        abstract: "Render a stencil template using a data source"
    )
    
    @Option(name: [.customShort("t"), .customLong("template")], help: "The path to the stencil template you want to render.")
    var templatePath: String?

    @Option(name: [.customShort("d"), .customLong("datasource")], help: "The path to the datasource. A JSON or Yaml file.")
    var dataSourcePath: String?

    @Option(name: [.customShort("o"), .customLong("output")], help: "The path where you want to save the generated file.")
    var outputPath: String?

    func run() throws {
        let stencilRenderer = StencilRenderer()

        let template = getTemplatePathIfMissing()
        let dataSource = getDataSourcePathIfMissing()
        let output = getOutputPathIfMissing()

        try stencilRenderer.run(templatePathString: template, dataSourcePathString: dataSource, outputPathString: output)

        print("Rendered file on path \(output)")
    }

    private func readLine(prompt: String) -> String? {
        print(prompt)
        return Swift.readLine(strippingNewline: true)?.trimmingCharacters(in: [" "])
    }

    private func getTemplatePathIfMissing() -> String {
        return templatePath ?? readLine(prompt: "Template path:")!
    }

    private func getDataSourcePathIfMissing() -> String {
        return dataSourcePath ?? readLine(prompt: "Data source path:")!
    }

    private func getOutputPathIfMissing() -> String {
        return outputPath ?? readLine(prompt: "Output path:")!
    }
}
