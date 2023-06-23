import UIKit

class TestViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupScrollView()
        setupTextView()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .orange
        view.addSubview(scrollView)
        
        // Set up constraints for the scroll view to cover the entire view
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTextView() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(textView)
        
        // Set up constraints for the text view
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            textView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Set other text view properties as needed
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Update the content size of the scroll view based on the text view's content size
        scrollView.contentSize = textView.bounds.size
    }
}

extension TestViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        // Update the content size of the scroll view as the text view's content size changes
        scrollView.contentSize = textView.bounds.size
    }
}
