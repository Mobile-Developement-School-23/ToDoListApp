import UIKit

class CustomTableViewCell: UITableViewCell {
    var control: UIControl!
    let radioButton = RadioButton()
    let textLabelPadding: CGFloat = 12
    
    var textLabelHeightConstraint: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        control = UIControl()
        radioButton.backgroundColor = UIColor(named: "BackSecondary")
        
        control.addSubview(radioButton)
        contentView.addSubview(control)
        
        control.translatesAutoresizingMaskIntoConstraints = false
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            control.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            control.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            control.widthAnchor.constraint(equalToConstant: 24),
            control.heightAnchor.constraint(equalToConstant: 24),
            
            radioButton.leadingAnchor.constraint(equalTo: control.leadingAnchor),
            radioButton.trailingAnchor.constraint(equalTo: control.trailingAnchor),
            radioButton.topAnchor.constraint(equalTo: control.topAnchor),
            radioButton.bottomAnchor.constraint(equalTo: control.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let textRect = contentView.bounds.inset(by: UIEdgeInsets(top: 0, left: 40 + textLabelPadding, bottom: 0, right: 0))
        textLabel?.frame = textRect
        
        // Additional customizations
        textLabel?.numberOfLines = 3
        textLabel?.lineBreakMode = .byTruncatingTail
        textLabel?.textColor = .black
        textLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
