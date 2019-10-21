import Commander
import Foundation
import StenclyKit

let main = command(
    Argument<String>("template", description: "Path to the stencil template"),
    Argument<String>("datasource", description: "Path to the json or yaml file containing the data"),
    Argument<String>("output", description: "Path to output the generated file")
) { templatePath, dataSourcePath, outputPath in
    let stencly = Stencly()
    do {
        try stencly.run(templatePathString: templatePath, dataSourcePathString: dataSourcePath, outputPathString: outputPath)
    } catch {
        print(error.localizedDescription)
    }
}

main.run()
