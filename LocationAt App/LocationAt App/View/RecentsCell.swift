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
        view.backgroundColor = Constants.shared.clearColor
        return view
    }()
    
    lazy var nameLabel: UILabel = {
       let lbl = UILabel(frame: CGRect(x: 8, y: 8, width: mainView.frame.width - 8, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont(name: Constants.shared.mainFont, size: 18)
        lbl.textColor = Constants.shared.mainColor
        return lbl
    }()
    
    lazy var addressLabel: UILabel = {
       let lbl = UILabel(frame: CGRect(x: 8, y: 40, width: mainView.frame.width - 8, height: 30))
        lbl.textAlignment = .left
        lbl.font = UIFont(name: Constants.shared.mainFont, size: 15)
        lbl.textColor = .white
        return lbl
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
