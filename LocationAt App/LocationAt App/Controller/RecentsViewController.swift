//
//  RecentsViewController.swift
//  LocationAt App
//
//  Created by Jawaher Alagel on 12/25/20.
//

import UIKit
import RealmSwift

class RecentsViewController: UIViewController {
    
    // MARK: - properties
    
    // Create instance of Realm
    let realm = try! Realm()
    
    var savedNames: [String] = []
    var savedAddress: [String] = []
    
    var tableView = UITableView()
    let cellId = "cell"
    
    lazy var headerView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: tableView.frame.width, height: 60))
        view.backgroundColor = Constants.shared.mainColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 150, y: 8, width: 100, height: 50))
        lbl.textAlignment = .center
        lbl.text = "Recents"
        lbl.font = UIFont(name: Constants.shared.mainFont, size: 25)
        lbl.textColor = .white
        return lbl
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        renderRecents()
        
        headerView.addSubview(titleLabel)
        self.tableView.tableHeaderView = headerView
    }
    
    // MARK: - Helpers
    
    // Render recents data from Realm
    func renderRecents() {
        let recents = realm.objects(Recents.self)
        for r in recents {
            let name = r.name
            let address = r.address
            
            savedNames.append(name)
            savedAddress.append(address)
            print("DEBUG: place name: \(name)")
            print("DEBUG: place address: \(address)")
        }
    }
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        self.view.addSubview(tableView)
        
        tableView.register(RecentsCell.self, forCellReuseIdentifier: cellId)
    }
    
}

// MARK: - UITableViewDelegate + UITableViewDataSource

extension RecentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RecentsCell
        cell.nameLabel.text = savedNames[indexPath.row]
        cell.addressLabel.text = "● " + savedAddress[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
