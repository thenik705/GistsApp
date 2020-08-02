//
//  CommitsTableViewController.swift
//  GistsApp
//
//  Created by n.poliakov on 31.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class CommitsTableViewController: UITableView, UITableViewDataSource, UITableViewDelegate {

    var rootController: CommitsViewController!
    var gist: GistEntity?

    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSettings()
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gist?.comments.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return loadCommitCell(indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    // MARK: - Settings
    func initSettings() {
        dataSource = self
        delegate = self

        estimatedRowHeight = 200
    }

    // MARK: - Additional functions
    func setController(_ controller: CommitsViewController) {
        self.rootController = controller
        self.gist = rootController.gist
    }

    func loadCommitCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: CommitCell.identifier, for: indexPath) as! CommitCell

        if !(gist?.comments.isEmpty ?? true) {
            if let nowGist = gist, let rowComment = gist?.comments[indexPath.row] {
                cell.loadCell(nowGist, rowComment)
            }
        } else {
            return loadSubstrateCell(indexPath)
        }

        return cell
    }

    func loadSubstrateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: SubstrateCell.identifier, for: indexPath) as! SubstrateCell
        return cell
    }

    func loadComments() {
        API().getGistCommits(APICallback(completion: { (result: (NSObject)) in
            if let commentsResult = result as? [CommitEntity] {
                self.gist?.comments = commentsResult
                self.reloadTable()
            }
        }, error: { (resultError: (ErrorEntity)) in
            print(resultError)
        }), gistId: gist?.idItem ?? "")
    }

    func reloadTable() {
        UIView.transition(
            with: self,
            duration: 0.3,
            options: [.transitionCrossDissolve, UIView.AnimationOptions.beginFromCurrentState],
            animations: {
                self.reloadData()
        })
    }
}
