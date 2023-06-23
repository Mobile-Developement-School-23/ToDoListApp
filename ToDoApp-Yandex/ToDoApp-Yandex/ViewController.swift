import UIKit

class ViewController: UIViewController, UITextViewDelegate{
    
    let dividerView = UIView()
    let grayDividerView = UIView()
    let stackView = UIStackView()
    let lineView = UIView()
    let scrollView = UIScrollView()
    let grayLineView = UIView()
    let calendarView = CalendarView()
    let secondView = CustomView()
    let deleteButton = DeleteButton()
    let miniTextView = MiniTextView()
    var customNavigationBar: CustomNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextView.appearance().tintColor = .black
        //textView.delegate = self
        miniTextView.delegate = self

        scrollView.backgroundColor = UIColor(named: "BackgroundColor")
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        customNavigationBar = CustomNavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 56))
                customNavigationBar.titleLabel.text = "Дело"
        customNavigationBar.titleLabel?.font = UIFont.boldSystemFont(ofSize:17)

                
        scrollView.addSubview(customNavigationBar)
        // Set constraints for the scroll view to occupy the whole screen
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        // Create a stack view as the container
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
       
        scrollView.addSubview(stackView)
        
        // Set constraints for the stack view to fill the scroll view
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 72).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
        let maximumStackViewHeight: CGFloat = traitCollection.verticalSizeClass == .compact ? 200 : 650
        let maximumStackViewHeightConstraint = stackView.heightAnchor.constraint(lessThanOrEqualToConstant: maximumStackViewHeight)

        // Activate the maximum height constraint
        maximumStackViewHeightConstraint.isActive = true
        
        
        stackView.addArrangedSubview(miniTextView)

        let importanceView = FirstView()
        stackView.addArrangedSubview(importanceView)

        let segmentedControl = SegmentedControlView(selectedSegmentIndex: 1)
               importanceView.addSubview(segmentedControl)
        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: importanceView.leadingAnchor, constant: 225),
            segmentedControl.centerYAnchor.constraint(equalTo: importanceView.centerYAnchor)
        ])
        // Create the line view
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor(named: "BackSecondary")
        stackView.addArrangedSubview(lineView)
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        grayLineView.backgroundColor = UIColor(named: "SupportSeperator")
        lineView.addSubview(grayLineView);
        grayLineView.translatesAutoresizingMaskIntoConstraints = false;
        grayLineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        grayLineView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, constant: 16).isActive = true
        grayLineView.trailingAnchor.constraint(equalTo: lineView.trailingAnchor, constant: -16).isActive = true
        // Add the line view to the superview of stackView
        secondView.layer.cornerRadius = 15
        secondView.clipsToBounds = true
        secondView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        stackView.addArrangedSubview(secondView)

        // Set constraints for the line view
   

       


      
        
       // deleteButton.isTextViewEmpty = true
        stackView.addArrangedSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        deleteButton.isEnabled = false

        
        
        let toggleSwitch = UISwitch()
                toggleSwitch.translatesAutoresizingMaskIntoConstraints = false
                secondView.addSubview(toggleSwitch)
        NSLayoutConstraint.activate([
            toggleSwitch.leadingAnchor.constraint(equalTo: secondView.leadingAnchor, constant: 285),
                      toggleSwitch.centerYAnchor.constraint(equalTo: secondView.centerYAnchor)
                  ])
        toggleSwitch.addTarget(self, action: #selector(toggleSwitchValueChanged), for: .valueChanged)

        // Create the button
        

        stackView.addArrangedSubview(deleteButton)
        stackView.setCustomSpacing(16.0, after: miniTextView)
        stackView.setCustomSpacing(0, after: importanceView)
        stackView.setCustomSpacing(0, after: lineView)
        stackView.setCustomSpacing(16.0, after: secondView)
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }

    @objc func toggleSwitchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
            
            dividerView.translatesAutoresizingMaskIntoConstraints = false
            dividerView.backgroundColor = UIColor(named: "BackSecondary")
            stackView.addArrangedSubview(dividerView)
            dividerView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            
            grayDividerView.backgroundColor = UIColor(named: "SupportSeperator")
            dividerView.addSubview(grayDividerView);
            grayDividerView.translatesAutoresizingMaskIntoConstraints = false;
            grayDividerView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
            grayDividerView.leadingAnchor.constraint(equalTo: dividerView.leadingAnchor, constant: 16).isActive = true
            grayDividerView.trailingAnchor.constraint(equalTo: dividerView.trailingAnchor, constant: -16).isActive = true
            // Change the corner radius of the secondView to zero
            secondView.layer.cornerRadius = 0
            secondView.toggleAdditionalLabelVisibility(sender.isOn)
            let initialDate = calendarView.datePicker.date
            secondView.updateAdditionalLabel(withDate: initialDate)
            // Create and display the pop-up calendar view
            // Configure the view as needed
            calendarView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(calendarView)
            calendarView.layer.cornerRadius = 15
            calendarView.clipsToBounds = true
            calendarView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            // Position the pop-up calendar view below the secondView with a distance of 16
            NSLayoutConstraint.activate([
                calendarView.topAnchor.constraint(equalTo: secondView.bottomAnchor),
                calendarView.leadingAnchor.constraint(equalTo: secondView.leadingAnchor),
                calendarView.trailingAnchor.constraint(equalTo: secondView.trailingAnchor),
             //   calendarView.heightAnchor.constraint(equalToConstant: 332) // Set the desired height
            ])
            calendarView.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
            deleteButton.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(deleteButton)

            // Update the constraints for deleteButton
            NSLayoutConstraint.activate([
                //  deleteButton.topAnchor.constraint(equalTo: calendarView.bottomAnchor, constant: 16),
                deleteButton.heightAnchor.constraint(equalToConstant: 56),
                // Add other constraints for deleteButton positioning as needed
            ])
            stackView.setCustomSpacing(16.0, after: calendarView)

            // Bring the view below the calendar to the front
            view.bringSubviewToFront(calendarView)
        } else {
            // Reset the corner radius of the secondView to its original value
            secondView.layer.cornerRadius = 15

            // Remove the pop-up calendar view if the switch is turned off
            calendarView.removeFromSuperview()
            dividerView.removeFromSuperview()
            grayDividerView.removeFromSuperview()
            secondView.toggleAdditionalLabelVisibility(false) // Hide additional label

        }
        
    }


    @objc func deleteButtonTapped() {
        // Perform actions when the deleteButton is tapped
        print("Delete button tapped")
        // Add your desired functionality here
    }
//
    internal func textViewDidChange(_ miniTextView: UITextView) {
        let isTextViewEmpty = miniTextView.text.isEmpty
        
        customNavigationBar.saveButton.isEnabled = !isTextViewEmpty
        customNavigationBar.saveButton.setTitleColor(isTextViewEmpty ? UIColor(named: "labelColor") : .systemBlue, for: .normal)
        
        deleteButton.isEnabled = !isTextViewEmpty
        deleteButton.buttonLabel.textColor = isTextViewEmpty ? .gray : .red
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.label
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Что надо сделать?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    @objc private func datePickerValueChanged() {
        // Assuming you have a reference to the CustomView instance

        // Assuming you have a reference to the selected date from the date picker
        let selectedDate = calendarView.datePicker.date

        // Update the chosen date label in the CustomView
        secondView.updateAdditionalLabel(withDate: selectedDate)
        
        if let dayView = calendarView.datePicker.subviews.first?.subviews.first(where: { String(describing: type(of: $0)) == "UIDatePickerDayView" }) {
            if let dayLabel = dayView.subviews.first?.subviews.first(where: { $0 is UILabel }) as? UILabel {
                // Reset the color of all day labels
                for subview in dayView.subviews {
                    if let label = subview as? UILabel {
                        label.textColor = .blue
                    }
                }
                dayLabel.textColor = .white
            }
        }
    }
}
