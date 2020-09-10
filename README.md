# CmdlineUtility

Support code for developing command line utilities.

## Contents

### Key Entry

Raw mode key-press detection

### Output Stream

A wrapper to convert an `UnsafeMutablePointer<FILE>` to a `TextOutputStream`

### Transformative Output Stream

`TextOutputStream`s that apply a closure to transform their contents before printing.

## Installation

File > Swift Packages > Add Package Dependency…:

```
https://github.com/erica/Swift-Cmdline-Utility
```

SwiftPM:

```
dependencies: [
    .package(url: "https://github.com/erica/Swift-Cmdline-Utility", from: "0.0.1"),
],
targets: [
    .target(
        name: "TARGET-NAME",
        dependencies: [
           .product(name: "CmdlineUtility"),
        ],
    ),
],
```
