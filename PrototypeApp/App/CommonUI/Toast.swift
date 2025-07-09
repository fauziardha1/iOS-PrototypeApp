//import UIKit
//
//class ToastView: UIView {
//    var onClose: (() -> Void)?
//    var type: ToastType = .info
//    var message = String()
//
//    private let messageLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = ""
//        label.textColor = UIColor.white
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.numberOfLines = 0
//        
//        return label
//    }()
//    private let closeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImage(named: "image_close_button")?.withRenderingMode(.alwaysOriginal)
//        
//        if let image = image {
//            button.setImage(image, for: .normal)
//        } else {
//            button.setTitle("X", for: .normal)
//        }
//        
//        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        button.layer.cornerRadius = 12
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.white.cgColor
//        button.layer.masksToBounds = true
//        return button
//    } ()
//
//    init(message: String, type: ToastType) {
//        super.init(frame: .zero)
//        self.type = type
//        self.message = message
//        setupView()
//    }
//    
//    private func setupView() {
//        backgroundColor = type.backgroundColor
//        layer.cornerRadius = 12
//        clipsToBounds = true
//
//        messageLabel.text = self.message
//        messageLabel.textColor = self.type.textColor
//
//        closeButton.setTitleColor(self.type.textColor, for: .normal)
//        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
//
//        addSubview(messageLabel)
//        addSubview(closeButton)
//        NSLayoutConstraint.activate([
//            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
//            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
//            messageLabel.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -8),
//
//            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
//            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
//            closeButton.widthAnchor.constraint(equalToConstant: 24),
//            closeButton.heightAnchor.constraint(equalToConstant: 24)
//        ])
//    }
//
//    @objc private func closeTapped() {
//        onClose?()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//    convenience init() {
//        self.init(message: "", type: .info)
//    }
//    
//    func setMessage(_ message: String) -> ToastView {
//        self.message = message
//        setupView()
//        return self
//    }
//
//    func setType(_ type: ToastType) -> ToastView {
//        self.type = type
//        return self
//    }
//
//    func setOnClose(_ action: @escaping () -> Void) -> ToastView {
//        self.onClose = action
//        setupView()
//        return self
//    }
//        
//}
//
//
//enum ToastType {
//    case success
//    case warning
//    case danger
//    case info
//    case custom(background: UIColor, text: UIColor)
//
//    var backgroundColor: UIColor {
//        switch self {
//        case .success:
//            return AppColor.primary
//        case .warning:
//            return UIColor.systemYellow
//        case .danger:
//            return AppColor.danger
//        case .info:
//            return UIColor.systemBlue
//        case .custom(let bg, _):
//            return bg
//        }
//    }
//
//    var textColor: UIColor {
//        switch self {
//        case .success, .warning, .danger, .info:
//            return .white
//        case .custom(_, let textColor):
//            return textColor
//        }
//    }
//}
