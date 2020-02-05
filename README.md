# PinKit
PinKit is an UIKit extension meant to be used in iOS and iPadOS projects. The purpose of this extension is to provide developers with a simple way to write layout code without having to  go through the trouble of having to use UIKit's cumbersome NSLayoutConstraint and anchor constraint syntax. The syntax of this extension is inspired by [PureLayout](https://github.com/PureLayout/PureLayout). This extension only offers basic functionality such as constraining edges, dimensions and axis. The extension also supports setting more specific rules when creating constraints using `NSLayoutConstraint.Relation` and `UILayoutPriority` as well as the standard constants and multipliers. If a more robust framework is required it is recommended to use something like [PureLayout](https://github.com/PureLayout/PureLayout) instead. This extension is intended to be used as a drop in extension rather a framework. What this means is that while this extension will not be updated automatically using a dependency system it also does not cause extra compile time issues in CI/CD services. It also enables developers to tweak this framework to their liking as it is built 100% in swift.

## Installation

### Using the Extension
The simplest way to avoid using any additional dependencies in your project is by taking the source code from `Sources/PinKit/UIView+PinKit.swift` and adding it into your project. The benefits of this method are that this is fast to do, you can easily alter the source code if necessary, you do not need any dependency management tools, CI/CD build times are basically unaffected. The downsides are that using this method the source code does not get updated when the project is updated.

### Swift Package Manager
As of Xcode 11 SPM integrates nicely with Xcode. This means that installing dependencies with Xcode support is super easy. To add the dependency using Swift Package Manager do the following steps:

1. Select the desired project and choose the `Swift Packages` tab of your project.
2. Tap on the + button.
3. Enter `https://github.com/sanderrouk/PinKit.git` onto the search bar and click next.
4. Choose the `Version` option leaving the selection on `Up to Next Major` option.
5. Click Next.
6. Click Finish.
7. Either create a separate file for it or add `import PinKit` in the file where you want to use it.

### Carthage
1. Add `github "sanderrouk/PinKit" ~> 1.0.0` project to your Cartfile.
2. Run `$ carthage update --platform ios`, this library does not support building for platforms other than iOS.
3. [Do the additional steps required for carthage frameworks.](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application)
4. Either create a separate file for it or add `import PinKit` in the file where you want to use it.

## Usage
PinKit works just like any other constraint based framework out there by extending the functionality of Swift's views. To use it's functionality you call the methods on the views. There is an example project included in this repository which can be consulted for a better overview of how the kit can be used. This is a short snippet from the example project:

```swift
        // Red circle centered in the view (r=25)
        view.addSubview(redCircle)
        redCircle.centerInSuperview()
        redCircle.setDimensions(to: .equalSides(of: 50))

        // White blob centered in the red square with dimensions of 30x20
        view.addSubview(whiteBlob)
        whiteBlob.centerIn(view: redCircle)
        whiteBlob.setDimension(.height, toSize: 20)
        whiteBlob.setDimension(.width, toSize: 30)

        // Orange square 50x50 aligned to horizontal axis, pinned to superview right
        // 20 units away from right edge
        view.addSubview(orangeSquare)
        orangeSquare.alignAxisToSuperview(axis: .horizontal)
        orangeSquare.pinEdge(toSuperviewEdge: .right, constant: -20)
        orangeSquare.setDimensions(to: .equalSides(of: 50))

        // Green square pinned to orange squares edges with insets of 20
        orangeSquare.addSubview(greenSquare)
        greenSquare.pinEdgesToSuperviewEdges(insets: .uniform(20))

        // Yellow square matching green squares dimensions aligned to orange square's
        // vertical axis and placed 20 units above orange square
        view.addSubview(yellowSquare)
        yellowSquare.matchDimensionsTo(view: greenSquare)
        yellowSquare.alignAxisTo(axis: .vertical, ofView: orangeSquare)
        yellowSquare.pinEdge(.bottom, to: .top, of: orangeSquare, constant: -20)

        // Teal quadlateral aligned to superview's horizontal axis
        // Pinned to superview's all edges except right, with insets of 20
        // width set to 50
        view.addSubview(tealQuadlateral)
        tealQuadlateral.pinEdges(toSuperviewEdges: .all(except: .right), insets: .uniform(20))
        tealQuadlateral.setDimension(.width, toSize: 50)

        // Pink blob matching its superview's dimensions, centered in superview
        tealQuadlateral.addSubview(pinkBlob)
        pinkBlob.matchDimensionsToSuperview()
        pinkBlob.centerInSuperview()

        // A button with undefined width and height of 30 centered on vertical axis,
        // pinned to superview safe area bottom
        view.addSubview(button)
        button.setDimension(.height, toSize: 30)
        button.alignAxisToSuperview(axis: .vertical)

        if #available(iOS 11.0, *) {
            button.pinEdge(toSuperviewSafeAreaEdge: .bottom)
        } else {
            button.pinEdge(toSuperviewEdge: .bottom)
        }
```

## Roadmap
Currently there are plans to add support for margin based constraints. Other than that there is no plan to make this kit any more complicated as there are pleanty of tools out there which already accomplish this.

## License
The project is under the MIT licence meaning you can use this project however you want.

## Project status
This project is considered feature complete. However as Apple will release changes to UIKit this framework will be updated as well.