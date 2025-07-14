import Foundation
import UIKit

class ToastManager {
    static let shared = ToastManager()

    private init() {}

    private var isShowing = false
    private var queue: [ToastView] = []

    func show(_ toast: ToastView, duration: TimeInterval = 3.0) {
        DispatchQueue.main.async {
            self.queue.append(toast)
            self.showNextIfPossible(duration: duration)
        }
    }

    private func showNextIfPossible(duration: TimeInterval) {
        guard !isShowing, !queue.isEmpty else { return }
        guard let window = getKeyWindow() else { return }
            
        isShowing = true
        let toast = queue.removeFirst()
        toast.alpha = 0
        window.addSubview(toast)

        toast.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = toast.topAnchor.constraint(equalTo: window.safeAreaLayoutGuide.topAnchor, constant: -20)
        NSLayoutConstraint.activate([
            toast.centerXAnchor.constraint(equalTo: window.safeAreaLayoutGuide.centerXAnchor),
            topConstraint,
            toast.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
        toast.onClose = {
            UIView.animate(withDuration: 0.2, animations: {
                toast.alpha = 0
            }) { _ in
                toast.removeFromSuperview()
                self.isShowing = false
                self.showNextIfPossible(duration: duration)
            }
        }
        
        // wait for 1 second until the window is fully loaded
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else {return}
            
            UIView.animate(withDuration: 0.3, animations: {
                topConstraint.constant = 60
                toast.alpha = 1
                window.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: 0.3, delay: duration, options: [], animations: {
                    toast.alpha = 0
                    topConstraint.constant = -20
                    window.layoutIfNeeded()
                }) { _ in
                    toast.removeFromSuperview()
                    self.isShowing = false
                    self.showNextIfPossible(duration: duration)
                }
            }
        }
    }
    
    private func getKeyWindow() -> UIWindow? {
        if #available(iOS 13.0, *) {
            return UIApplication.shared
                .connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

