# Stencly

Render a [Stencil](https://github.com/stencilproject/Stencil) template by using a JSON or Yaml data source.

Tags and filters from [StencilSwiftKit](https://github.com/SwiftGen/StencilSwiftKit) are supported.

## Why this project exists?

I often find myself in need to generate Swift code from a data source. Most of the time I don't need to do something very complicated, I just want to have access to a key-value object inside my template.

Thanks to [this blog post on NSHipster](https://nshipster.com/swift-gyb/), I found out about GYB, and that was good enough for my needs. However, this requires the rest of the team to learn some python, which might not be optimal in a team of Swift developers.

So this project exists to make code generation via data sources easy for Swift developers, without needing to go outside of our comfort zone.

## Installing

### Using [Mint](https://github.com/yonaskolb/mint):

```
$ mint install alephao/Stencly
```

### Using Make

```
$ git clone https://github.com/alephao/Stencly.git
$ cd Stencly
$ make install
```

## Usage

```
$ stencly render -t path/to/template.stencil -d path/to/datasource.stencil -o path/to/output
```

## Example

Given the stencil template

```stencil
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

Stencly generates

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

Stencly is available under the MIT license. See LICENSE for more information.
