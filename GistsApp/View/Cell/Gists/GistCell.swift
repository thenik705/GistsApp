//
//  GistCell.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit
import Kingfisher

protocol GistCellDelegate: class {
    func selectOpenCommits(_ gist: GistEntity)
}

class GistCell: UITableViewCell {

    static let identifier = "GistCell"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!

    weak var delegate: GistCellDelegate?

    var rowGist: GistEntity!

    // MARK: - load
    func loadCell(_ gist: GistEntity) {
        rowGist = gist
        let descript = rowGist.descript
        let userName = rowGist.user?.name ?? ""
        let fileName = rowGist.files.first?.name ?? ""

        title.text = fileName.isNotEmpty() ? "\(userName) / \(fileName)" : userName
        subTitle.text = descript

        if let url = URL(string: rowGist.user?.avatarUrl ?? "") {
            userAvatar.kf.indicatorType = .activity
            userAvatar.kf.setImage(with: url)
        }
    }

    // MARK: - Actions
    @IBAction func selectOpenCommitsActionButton(_ sender: Any) {
        delegate?.selectOpenCommits(rowGist)
    }
}
