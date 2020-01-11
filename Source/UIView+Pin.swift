/*
 Copyright © 2020 Rouk OÜ. All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial
 portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

// Mark: Layout code
public extension UIView {

    /// Centers the view in its superview.
    ///
    ///  - Returns : Array of `NSLayoutConstraint` which containts two elements.
    /// First one is the X axis anchor and the second one is the Y axis anchor.
    @discardableResult
    func centerInSuperview() -> [NSLayoutConstraint] {
        let superview = unwrapSuperviewOrFailure()
        return [
            alignAxisTo(axis: .vertical, ofView: superview),
            alignAxisTo(axis: .horizontal, ofView: superview)
        ]
    }

    /// Aligns the specified axis to the corresponding axis of the superview.
    ///
    /// - Parameters:
    ///     - axis: The axis of both the view and the superview which will be aligned to one another.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: The `CGFloat` value added onto the constraint value modifiying the offset
    ///     of the constraint.
    ///
    /// - Returns: The corresponding `NSLayoutConstraint` created by aligning the appropriate axes to each other.
    @discardableResult
    func alignAxisToSuperview(
        axis: LayoutAxis,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        let superview = unwrapSuperviewOrFailure()
        return alignAxisTo(axis: axis, ofView: superview, priority: priority, constant: constant)
    }

    /// Centers the view in the desegnated view.
    ///
    /// - Parameters view: The view to which center the view will be constraint to.
    ///
    ///  - Returns : Array of `NSLayoutConstraint` which containts two elements.
    ///  First one is the X axis anchor and the second one is the Y axis anchor.
    @discardableResult
    func centerIn(view: UIView) -> [NSLayoutConstraint] {
        return [
            alignAxisTo(axis: .vertical, ofView: view),
            alignAxisTo(axis: .horizontal, ofView: view)
        ]
    }

    /// Aligns the specified axis to the corresponding axis of the target view.
    ///
    /// - Parameters:
    ///     - axis: The axis of both the view and the superview which will be aligned to one another.
    ///     - view: The target view which will be aligned to.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: The `CGFloat` value added onto the constraint value modifiying the offset
    ///     of the constraint.
    ///
    /// - Returns: The corresponding `NSLayoutConstraint` created by aligning the appropriate axes to each other.
    @discardableResult
    func alignAxisTo(
        axis: LayoutAxis,
        ofView view: UIView,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let attribute: NSLayoutConstraint.Attribute = axis == .vertical
            ? .centerX
            : .centerY

        let constraint = NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: view,
            attribute: attribute,
            multiplier: 1,
            constant: constant
        )

        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    /// Sets the view's specified dimensions to the specified size.
    ///
    /// - Parameter size: The specific height and widht which the dimensions will be set to.
    ///
    /// - Returns: An array of`NSLayoutConstraint` matching the appropriate anchors for the size constraints. The order is height, then width.
    @discardableResult
    func setDimensions(to size: CGSize) -> [NSLayoutConstraint] {
        return [
            setDimension(.height, toSize: size.height),
            setDimension(.width, toSize: size.width)
        ]
    }

    /// Sets the view's specified dimension to the specified dimension.
    ///
    /// - Parameters:
    ///     - Dimension: The dimension which will be set to the specified size.
    ///
    ///     - size: The specific size which the dimension will be set to.
    ///
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///
    ///      - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///
    ///      - multiplier: The multiplier which is used to modify the size. A size 100 with a multiplier of 0.5
    ///      would result in the dimension size of 50.
    ///
    /// - Returns: `NSLayoutConstraint` matching the appropriate anchor for the size constraint.
    @discardableResult
    func setDimension(
        _ dimension: LayoutDimension,
        toSize size: CGFloat,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self,
            attribute: dimension == .height ? .height : .width,
            relatedBy: relation,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: multiplier,
            constant: size
        )
        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    private func unwrapSuperviewOrFailure() -> UIView {
        guard let superview = superview else { preconditionFailure("The view's superview can't be nil") }
        return superview
    }
}

// Mark: Types provided by the extension

public enum LayoutAxis {

    /// Corresponds to `NSLayoutConstraint.Attribute.centerY`
    case horizontal

    /// Corresponds to `NSLayoutConstraint.Attribute.centerX`
    case vertical
}

public enum LayoutDimension {

    /// Corresponds to `NSLayoutConstraint.Attribute.height`
    case height

    /// Corresponds to `NSLayoutConstraint.Attribute.width`
    case width
}
