import UIKit

class MiniTextView: UITextView, UITextViewDelegate {
    init() {
        super.init(frame: .zero, textContainer: nil)
        setupTextView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextView()
    }
    
    private func setupTextView() {
        
        backgroundColor = UIColor(named: "BackSecondary")
        layer.cornerRadius = 15
        font = .systemFont(ofSize: 17, weight: .regular)
        let horizontalIndentation: CGFloat = 16.0
        let verticalIndentation: CGFloat = 17.0
        textContainerInset = UIEdgeInsets(top: verticalIndentation, left: horizontalIndentation, bottom: verticalIndentation, right: horizontalIndentation)
        text = "Что надо сделать?"
        textColor = .lightGray
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        
        delegate = self
    }
    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == .lightGray {
//            textView.text = nil
//            textView.textColor = .label
//            
//        }
//    }
//    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Что надо сделать?"
//            textView.textColor = .lightGray
//        }
//    }
}
