//
//  TopGistsItemCell.swift
//  GistsApp
//
//  Created by Nik on 01.08.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class TopUserItemCell: UICollectionViewCell {

    static let identifier = "TopUserItemCell"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!

    var rowUser: UserEntity!

    // MARK: - load
    func loadCell(_ user: UserEntity) {
        rowUser = user
        let userName = user.name ?? ""

        title.text = userName

        if let url = URL(string: user.avatarUrl ?? "") {
            userAvatar.kf.indicatorType = .activity
            userAvatar.kf.setImage(with: url)
        }
    }
}
