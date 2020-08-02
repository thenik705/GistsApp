//
//  TopUserCell.swift
//  GistsApp
//
//  Created by Nik on 01.08.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class TopUserCell: UITableViewCell {

    static let identifier = "TopUserCell"

    @IBOutlet weak var topUsersCollectionView: TopUsersCollectionView!

    // MARK: - load
    func loadCell(_ rootController: MainViewController, users: [UserEntity]) {
        topUsersCollectionView.users = users
        topUsersCollectionView.mainTableDelegate = rootController
        contentView.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
