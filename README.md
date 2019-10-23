# Stencly

Render a [Stencil](https://github.com/stencilproject/Stencil) template by using a JSON or Yaml data source.

Tags and filters from [StencilSwiftKit](https://github.com/SwiftGen/StencilSwiftKit) are supported.

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
$ stencly -t path/to/template.stencil -d path/to/datasource.stencil -o path/to/output
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

```
---
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

```
extension Color {
    public static let color1 = Color(hex: 0x111111)
    public static let color2 = Color(hex: 0x222222)
    public static let color3 = Color(hex: 0x333333)
    public static let color4 = Color(hex: 0x444444)
}

```
