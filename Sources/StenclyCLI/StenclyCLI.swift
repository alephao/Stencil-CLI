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
