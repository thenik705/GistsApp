//
//  CommitCell.swift
//  GistsApp
//
//  Created by n.poliakov on 31.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit
import Kingfisher

class CommitCell: UITableViewCell {

    static let identifier = "CommitCell"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var dateTite: UILabel!
    @IBOutlet weak var addedRowsLabel: UILabel!
    @IBOutlet weak var deletedRowsLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!

    var rowCommint: CommitEntity!
    var gist: GistEntity?

    // MARK: - load
    func loadCell(_ gist: GistEntity, _ commint: CommitEntity) {
        rowCommint = commint

        title.text = gist.user?.name ?? ""
        subTitle.text = rowCommint.version

        if let date = rowCommint.date {
            dateTite.text = DateUtils.getTimeString(date)
        } else {
            dateTite.text = "-"
        }

        addedRowsLabel.text = "\(rowCommint.addedRow ?? 0)"
        deletedRowsLabel.text = "\(rowCommint.deletedRow ?? 0)"

        if let url = URL(string: gist.user?.avatarUrl ?? "") {
            userAvatar.kf.indicatorType = .activity
            userAvatar.kf.setImage(with: url)
        }
    }
}
