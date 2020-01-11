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
    ///     - size: The specific size which the dimension will be set to.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - multiplier: The multiplier which is used to modify the size. A size 100 with a multiplier
    ///     of 0.5
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

    /// Sets the specified dimensions of the view to match the same dimensions of the view's superview.
    ///
    /// - Returns: An array of `NSLayoutConstraint` matching the created constraint.
    ///     The constraints will be in the following order: width, height
    ///
    @discardableResult
    func matchDimensionsToSuperview() -> [NSLayoutConstraint] {
        let superview = unwrapSuperviewOrFailure()
        return matchDimensionsTo(view: superview)
    }

    /// Sets the specified dimensions of the view to match the same dimensions of the target view.
    ///
    /// - Parameter view: The view which the dimensions will be constraint to.
    ///
    /// - Returns: An array of `NSLayoutConstraint` matching the created constraint.
    ///     The constraints will be in the following order: width, height
    ///
    @discardableResult
    func matchDimensionsTo(view: UIView) -> [NSLayoutConstraint] {
        return [
            matchDimension(.width, to: view),
            matchDimension(.height, to: view)
        ]
    }

    /// Sets the specified dimension of the view to match the same dimension of the target view.
    ///
    /// - Parameters:
    ///     - dimension: The dimension which will be matched to the target view's same dimension.
    ///     - view: Target view which will be constrained to.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: A constant added to the new dimension constraint.
    ///     - multiplier: Size difference multiplier.
    ///
    /// - Returns: `NSLayoutConstraint` matching the created constraint.
    ///
    @discardableResult
    func matchDimension(
        _ dimension: LayoutDimension,
        to view: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        return matchDimension(
            dimension,
            to: dimension,
            of: view,
            relation: relation,
            priority: priority,
            constant: constant,
            multiplier: multiplier
        )
    }

    /// Sets the specified dimension of the view to match the specified dimension of the target view.
    ///
    /// - Parameters:
    ///     - dimension: The dimension which will be matched to the target view's target dimension.
    ///     - viewDimension: Target view's dimension which will be constrained to.
    ///     - view: Target view which will be constrained to.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: A constant added to the new dimension constraint.
    ///     - multiplier: Size difference multiplier.
    ///
    /// - Returns: `NSLayoutConstraint` matching the created constraint.
    ///
    @discardableResult
    func matchDimension(
        _ dimension: LayoutDimension,
        to viewDimension: LayoutDimension,
        of view: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self,
            attribute: dimension == .height ? .height : .width,
            relatedBy: relation,
            toItem: view,
            attribute: dimension == .height ? .height : .width,
            multiplier: multiplier,
            constant: constant
        )

        constraint.priority = priority
        constraint.isActive = true

        return constraint
    }

    /// Sets the view's edges equal to the same edges of the view's superview.
    ///
    /// - Parameters:
    ///     - edges: The specific edges of the view which will be constrained, defaults to All edges.
    ///     - insets: The edge insets adding spacing between the edge insets. An edge set of [.top, .bottom]
    ///     with an inset set of .top(10) + .bottom(10) would result in constraints where the top edge
    ///     of the view being constraint is 10 units below the target view and the bottom is above the target
    ///     view by 10 units.
    ///
    /// - Returns: An array of  `NSLayoutConstraint` matching the appropriate layout constraints in
    ///  the following order: Top, Leading, Trailing, Bottom.
    ///
    @discardableResult
    func pinEdgesToSuperviewEdges(
        _ edges: [LayoutEdge] = .all,
        with insets: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        let superview = unwrapSuperviewOrFailure()
        return pinEdges(edges, to: superview, insets: insets)
    }

    /// Sets the view's edge equal to the same edge of the view's superview.
    ///
    /// - Parameters:
    ///     - edge: The specific edge of the view which will be constrained.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: The constant which will be added to the resulting constraint. Adding a constant of
    ///     50 would result in the resulting constraint to be offset by 50 units on the appropriate axis.
    ///     - multiplier: The multiplier which is used to modify the size. A size 100 with a multiplier
    ///     of 0.5
    ///      would result in the dimension size of 50.
    ///
    /// - Returns: `NSLayoutConstraint` matching the appropriate layout constraint generated.
    ///
    @discardableResult
    func pinEdgeToSuperview(
        edge: LayoutEdge,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        let superview = unwrapSuperviewOrFailure()
        return pinEdge(
            edge,
            to: edge,
            of: superview,
            relation: relation,
            priority: priority,
            constant: constant,
            multiplier: multiplier
        )
    }

    /// Sets the view's edges equal to the same edges of another view.
    ///
    /// - Parameters:
    ///     - edges: The specific edges of the view which will be constrained.
    ///     - view: Target view which will be constrained to.
    ///     - insets: The edge insets adding spacing between the edge insets. An edge set of [.top, .bottom]
    ///     with an inset set of .top(10) + .bottom(10) would result in constraints where the top edge
    ///     of the view being constraint is 10 units below the target view and the bottom is above the target
    ///     view by 10 units.
    ///
    /// - Returns: An array of  `NSLayoutConstraint` matching the appropriate layout constraints in
    ///  the same order as the param `edges` was provided generated.
    ///
    @discardableResult
    func pinEdges(
        _ edges: [LayoutEdge],
        to view: UIView,
        insets: UIEdgeInsets = .zero
    ) -> [NSLayoutConstraint] {
        return edges.map({ edge in
            pinEdge(
                edge,
                to: edge,
                of: view,
                constant: translateToConstantFrom(inset: insets, for: edge)
            )
        })
    }

    /// Sets the view's edge equal to the same edge of another view.
    ///
    /// - Parameters:
    ///     - edge: The specific edge of the view which will be constrained.
    ///     - view: Target view which will be constrained to.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: The constant which will be added to the resulting constraint. Adding a constant of
    ///     50 would result in the resulting constraint to be offset by 50 units on the appropriate axis.
    ///     - multiplier: The multiplier which is used to modify the size. A size 100 with a multiplier
    ///     of 0.5
    ///      would result in the dimension size of 50.
    ///
    /// - Returns: `NSLayoutConstraint` matching the appropriate layout constraint generated.
    ///
    @discardableResult
    func pinEdge(
        _ edge: LayoutEdge,
        to view: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        return pinEdge(
            edge,
            to: edge,
            of: view,
            relation: relation,
            priority: priority,
            constant: constant,
            multiplier: multiplier
        )
    }

    /// Sets the view's edge equal to the specified edge of another view.
    ///
    /// - Parameters:
    ///     - edge: The specific edge of the view which will be constrained.
    ///     - viewEdge: The target view's edge which will be constrained to.
    ///     - view: Target view which will be constrained to.
    ///     - relation: The relation between the first attribute and the modified second attribute
    ///      in a constraint.
    ///     - priority: The layout priority is used to indicate to the constraint-based layout system which
    ///      constraints are more important, allowing the system to make appropriate tradeoffs when
    ///      satisfying the constraints of the system as a whole.
    ///     - constant: The constant which will be added to the resulting constraint. Adding a constant of
    ///     50 would result in the resulting constraint to be offset by 50 units on the appropriate axis.
    ///     - multiplier: The multiplier which is used to modify the size. A size 100 with a multiplier
    ///     of 0.5
    ///      would result in the dimension size of 50.
    ///
    /// - Returns: `NSLayoutConstraint` matching the appropriate layout constraint generated.
    ///
    @discardableResult
    func pinEdge(
        _ edge: LayoutEdge,
        to viewEdge: LayoutEdge,
        of view: UIView,
        relation: NSLayoutConstraint.Relation = .equal,
        priority: UILayoutPriority = .required,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1
    ) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint = NSLayoutConstraint(
            item: self,
            attribute: translateToAttributeFrom(edge: edge),
            relatedBy: relation,
            toItem: view,
            attribute: translateToAttributeFrom(edge: viewEdge),
            multiplier: multiplier,
            constant: constant
        )

        constraint.priority = priority
        constraint.isActive = true
        return constraint
    }

    private func unwrapSuperviewOrFailure() -> UIView {
        guard let superview = superview else { preconditionFailure("The view's superview can't be nil") }
        return superview
    }

    private func translateToAttributeFrom(edge: LayoutEdge) -> NSLayoutConstraint.Attribute {
        switch edge {
        case .top: return .top
        case .left: return .left
        case .leading: return .leading
        case .right: return .right
        case .trailing: return .trailing
        case .bottom: return .bottom
        }
    }

    private func translateToConstantFrom(inset: UIEdgeInsets, for edge: LayoutEdge) -> CGFloat {

        let isLeftToRight = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight
        switch edge {
        case .top: return inset.top
        case .left: return inset.left
        case .leading: return isLeftToRight ? inset.left : -inset.right
        case .right: return -inset.right
        case .trailing: return isLeftToRight ? -inset.right : inset.left
        case .bottom: return -inset.bottom
        }
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

public enum LayoutEdge {
    case top
    case left
    case leading
    case right
    case trailing
    case bottom
}

// Mark: Extensions
public extension Collection where Element == LayoutEdge {
    static var all: [LayoutEdge] {
        return [.top, .leading, .trailing, .bottom]
    }

    static func all(except edge: LayoutEdge) -> [LayoutEdge] {
        var edges: [LayoutEdge] = .all
        switch edge {
        case .top:
            edges.removeAll(where: { $0 == .top })
        case .left, .leading:
            edges.removeAll(where: { $0 == .leading })
        case .bottom:
            edges.removeAll(where: { $0 == .bottom })
        case .right, .trailing:
            edges.removeAll(where: { $0 == .trailing })
        }

        return edges
    }
}
