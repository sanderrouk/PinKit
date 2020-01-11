import UIKit

class ViewController: UIViewController {

    private let redCircle = UIView()
    private let whiteBlob = UIView()

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
    }

    private func layout() {
        view.addSubview(redCircle)
        redCircle.centerInSuperview()
        redCircle.setDimensions(to: .equalSides(of: 50))

        view.addSubview(whiteBlob)
        whiteBlob.centerIn(view: redCircle)
        whiteBlob.setDimension(.height, toSize: 20)
        whiteBlob.setDimension(.width, toSize: 30)
    }

}

private extension CGSize {
    static func equalSides(of size: CGFloat) -> CGSize {
        return .init(width: size, height: size)
    }
}

