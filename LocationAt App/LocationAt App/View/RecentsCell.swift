//
//  RecentsCell.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/25/20.
//

import UIKit

class RecentsCell: UITableViewCell {
    
    lazy var mainView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width + 70, height: 80))
        view.backgroundColor = Constants.shared.viewsColor
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 8, y: 8, width: mainView.frame.width - 8, height: 30))
        label.font = UIFont(name: Constants.shared.mainFont, size: 18)
        label.textColor = Constants.shared.mainColor
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 8, y: 40, width: mainView.frame.width - 8, height: 30))
        label.font = UIFont(name: Constants.shared.mainFont, size: 15)
        label.textColor = .darkGray
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        mainView.layer.cornerRadius = 5
        mainView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        addSubview(mainView)
        mainView.addSubview(nameLabel)
        mainView.addSubview(addressLabel)
    }
    
}
