# ios-app-bootstrap

[![Build Status](https://img.shields.io/travis/xudafeng/ios-app-bootstrap.svg?style=flat-square)](https://travis-ci.org/xudafeng/ios-app-bootstrap)

A starting tutorial for iOS application with Swift.

[native-in-practice](//xudafeng.github.io/slide/archives/native-in-practice)

## Build

```bash
$ carthage update --platform iOS --verbose
$ xcodebuild -project ios-app-bootstrap.xcodeproj -sdk iphonesimulator
```

## Datahub

```bash
$ npm i macaca-datahub -g
$ datahub server -c ./macaca-datahub.config.js --verbose
```

## Testing

```bash
$ make test
```

### Coverage

```bash
$ npm i macaca-cli -g
$ make coverage
```

## Output

npmcdn.com: [ios-app-bootstrap.zip](//npmcdn.com/ios-app-bootstrap@latest/build/ios-app-bootstrap.zip)

## License

The MIT License (MIT)
