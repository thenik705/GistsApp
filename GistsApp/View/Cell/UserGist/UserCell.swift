//
//  UserCell.swift
//  GistsApp
//
//  Created by Nik on 02.08.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit
import Kingfisher

class UserCell: UITableViewCell {

    static let identifier = "UserCell"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!

    var rowUser: UserEntity!

    // MARK: - load
    func loadCell(_ user: UserEntity) {
        rowUser = user

        title.text = rowUser.name ?? ""

        if let url = URL(string: rowUser.avatarUrl ?? "") {
            userAvatar.kf.indicatorType = .activity
            userAvatar.kf.setImage(with: url)
        }
    }
}
