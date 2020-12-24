//
//  SegmentedControl.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/23/20.
//

import UIKit

class SegmentedControl: UIControl {
    
    // MARK: - properties
    
    var labels = [UILabel]()
    var thumbView = UIView()
    
    var items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4"] {
        didSet {
            if items.count > 0 { setupLabels() }
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet { displayNewSelectedIndex() }
    }
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func setupView() {
        layer.cornerRadius = frame.height / 2
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 2
        
        backgroundColor = UIColor.clear
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        
        labels.removeAll(keepingCapacity: true)
        for index in 1...items.count {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = items[index - 1]
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = UIFont(name: "Avenir-Black", size: 14)
            label.textColor = index == 1 ? .white : .lightGray
            
            addSubview(label)
            labels.append(label)
        }
        
        // Add constraint to the labels
        addIndividualItemConstraints(labels, mainView: self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if labels.count > 0 {
            let label = labels[selectedIndex]
            label.textColor = .white
            thumbView.frame = label.frame
            thumbView.backgroundColor = UIColor(named: "Deep Sapphire")
            thumbView.layer.cornerRadius = thumbView.frame.height / 2
            displayNewSelectedIndex()
        }
    }
    
    // Get the coordinates where the user hit the touchscreen
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        var calculatedIndex: Int?
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        return false
    }
    
    func displayNewSelectedIndex() {
        for (_, item) in labels.enumerated() {
            item.textColor = .lightGray
        }
        
        let label = labels[selectedIndex]
        label.textColor = .white
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
            self.thumbView.frame = label.frame
        }, completion: nil)
    }
    
    func addIndividualItemConstraints(_ items: [UIView], mainView: UIView) {
        for (index, button) in items.enumerated() {
            button.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
            
            // Set leading constraint
            if index == 0 {
                // Set first item leadingAnchor to mainView
                button.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
            }else{
                let prevButton: UIView = items[index - 1]
                let firstItem: UIView = items[0]
                
                // Set remaining items to previous view and set width the same as first view
                button.leadingAnchor.constraint(equalTo: prevButton.trailingAnchor).isActive = true
                button.widthAnchor.constraint(equalTo: firstItem.widthAnchor).isActive = true
            }
            
            // Set trailing constraint
            if index == items.count - 1 {
                // Set last item trailing anchor to mainView
                button.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
            }else{
                // Set remaining item trailing anchor to next view
                let nextButton: UIView = items[index + 1]
                button.trailingAnchor.constraint(equalTo: nextButton.leadingAnchor).isActive = true
            }
        }
    }
    
}
