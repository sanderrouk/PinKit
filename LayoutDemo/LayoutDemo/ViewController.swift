import UIKit

class ViewController: UIViewController {

    private let redCircle = UIView()
    private let whiteBlob = UIView()
    private let orangeSquare = UIView()
    private let greenSquare = UIView()
    private let yellowSquare = UIView()
    private let tealQuadlateral = UIView()
    private let pinkBlob = UIView()
    private let button = UIButton(type: .system)

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
        layout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        view.backgroundColor = .white

        redCircle.backgroundColor = .red
        redCircle.layer.cornerRadius = 25

        whiteBlob.backgroundColor = .white
        whiteBlob.layer.cornerRadius = 5

        orangeSquare.backgroundColor = .orange
        greenSquare.backgroundColor = .green
        yellowSquare.backgroundColor = .yellow
        tealQuadlateral.backgroundColor = .systemTeal

        pinkBlob.backgroundColor = .systemPink
        pinkBlob.layer.cornerRadius = 25

        button.setTitle("Press me", for: .normal)
    }

    private func layout() {
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
    }

}

private extension CGSize {
    static func equalSides(of size: CGFloat) -> CGSize {
        return .init(width: size, height: size)
    }
}

private extension UIEdgeInsets {
    static func top(_ size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: size, left: 0, bottom: 0, right: 0)
    }

    static func bottom(_ size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: size, right: 0)
    }

    static func left(_ size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: size, left: 0, bottom: size, right: 0)
    }

    static func right(_ size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: size)
    }

    static func horizontal(_ size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: size, bottom: 0, right: size)
    }

    static func vertical(_ size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: size, left: 0, bottom: size, right: 0)
    }

    static func uniform(_ size: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }

    static func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: lhs.top + rhs.top,
            left: lhs.left + rhs.left,
            bottom: lhs.bottom + rhs.bottom,
            right: lhs.right + rhs.right
        )
    }
}

