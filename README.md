# PinKit
PinKit is an UIKit extension meant to be used in iOS and iPadOS projects. The purpose of this extension is to provide developers with a simple way to write layout code without having to  go through the trouble of having to use UIKit's cumbersome NSLayoutConstraint and anchor constraint syntax. The syntax of this extension is inspired by [PureLayout](https://github.com/PureLayout/PureLayout). This extension only offers basic functionality such as constraining edges, dimensions and axis. The extension also supports setting more specific rules when creating constraints using `NSLayoutConstraint.Relation` and `UILayoutPriority` as well as the standard constants and multipliers. If a more robust framework is required it is recommended to use something like [PureLayout](https://github.com/PureLayout/PureLayout) instead. This extension is intended to be used as a drop in extension rather a framework. What this means is that while this extension will not be updated automatically using a dependency system it also does not cause extra compile time issues in CI/CD services. It also enables developers to tweak this framework to their liking as it is built 100% in swift.

## Installation
Installing the extension right now is simple. Take the source of the project from the `Source` directory and add it to your project. We recommend naming the file `UIView+PinKit.swift`. This name indicates that this file contains extensions which affect the `UIView` class and that this extension has to do with `PinKit`. After you have done that, you can use PinKit from your views.

The kit also adds a public collectio extension into the project, however this will only affect collections where the elements are of type `LayoutEdge` which is a type provided by the kit. If however this extension is undesired the access modifier of this extension can be set to `private` to avoid exposing this extension to the rest of the codebase.

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
        greenSquare.pinEdgesToSuperviewEdges(with: .uniform(20))

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
        tealQuadlateral.pinEdges(toSuperviewEdges: .all(except: .right), with: .uniform(20))
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
Currently there are plans to add support for margin based constraints and to possibly make it Swift Package Manager usable. Other than that there is no plan to make this kit any more complicated as there are pleanty of tools out there which already accomplish this. This kit is meant to be a lightweight simple layout solution which does not require dependencies.

## License
The project is under the MIT licence meaning you can use this project however you want.

## Project status
This project is considered feature complete, however a few additional expansions might be added at later dates as well as API changes to allow more granular control with fewer lines of code.