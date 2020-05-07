# Stencil CLI

A CLI tool to render [Stencil](https://github.com/stencilproject/Stencil) templates by using a JSON or Yaml data source.

Tags and filters from [StencilSwiftKit](https://github.com/SwiftGen/StencilSwiftKit) are supported.

## Installing

### Using [Mint](https://github.com/yonaskolb/mint):

```
$ mint install alephao/Stencil-CLI
```

### Using Make

```
$ git clone https://github.com/alephao/Stencil-CLI.git
$ cd stencil-cli
$ make install
```

## Usage

```
$ stencil render -t path/to/template.stencil -d path/to/datasource.stencil -o path/to/output
```

## Example

Given the stencil template

```
extension Color {
    {% for color in colors %}
    public static let {{ color.name }} = Color(hex: 0x{{ color.hex }})
    {% endfor %}
}
```

And the yaml file

```yaml
colors:
- name: color1
  hex: '111111'
- name: color2
  hex: '222222'
- name: color3
  hex: '333333'
- name: color4
  hex: '444444'
```

stencil-cli generates

```swift
extension Color {
    public static let color1 = Color(hex: 0x111111)
    public static let color2 = Color(hex: 0x222222)
    public static let color3 = Color(hex: 0x333333)
    public static let color4 = Color(hex: 0x444444)
}

```

## Attributions

This tool is powered by:

* [Stencil](https://github.com/stencilproject/Stencil)
* [SwiftStencilKit](https://github.com/SwiftGen/StencilSwiftKit)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
* [Yams](https://github.com/jpsim/Yams)
* [swift-argument-parser](https://github.com/apple/swift-argument-parser)
* Tested using [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)

## License

Stencil CLI is available under the MIT license. See LICENSE for more information.
