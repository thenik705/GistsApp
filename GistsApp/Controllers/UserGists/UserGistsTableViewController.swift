//
//  UserGistsTableViewController.swift
//  GistsApp
//
//  Created by Nik on 02.08.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class UserGistsTableViewController: UITableView, UITableViewDataSource, UITableViewDelegate {

    var sections = [Sections]()
    var rootController: UserGistsViewController!
    var nowSectionType: SectionType = .userInfo

    var user: UserEntity?

    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSettings()
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowSection = sections[section].getType()

        switch rowSection.getId() {
        case SectionEntity.GistList.getId():
            return user?.gists.count ?? 0
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowSection = sections[indexPath.section].getType()

        switch rowSection.getId() {
        case SectionEntity.UserInfo.getId():
            return loadUserCell(indexPath)
        case SectionEntity.GistList.getId():
            return loadGistCell(indexPath)
        default:
            return loadSubstrateCell(indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowSection = sections[indexPath.section].getType()

        if rowSection.getId() == SectionEntity.GistList.getId() {
            if let user = user {
                if !user.gists.isEmpty {
                    rootController.mainTableDelegate?.selectGistItem(user.gists[indexPath.row])
                }
            }
        }
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
    func setController(_ controller: UserGistsViewController) {
        self.rootController = controller
        self.user = rootController.user
    }

    func loadUserCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell

        if let user = user {
            cell.loadCell(user)
            //            cell.delegate = rootController
        } else {
            return loadSubstrateCell(indexPath)
        }

        return cell
    }

    func loadGistCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: GistCell.identifier, for: indexPath) as! GistCell

        if let user = user {
            let rowGist = user.gists[indexPath.row]
            cell.loadCell(rowGist)
        } else {
            return loadSubstrateCell(indexPath)
        }

        return cell
    }

    func loadSubstrateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: SubstrateCell.identifier, for: indexPath) as! SubstrateCell
        let rowSection = sections[indexPath.section]

        cell.loadCell(rowSection.emptyTitle, rowSection.emptySubTitle)

        return cell
    }

    func loadInfo(_ sectionType: SectionType = .userInfo) {
        nowSectionType = sectionType
        sections = Sections.createSections(nowSectionType)

        UIView.transition(
            with: self,
            duration: 0.3,
            options: [.transitionCrossDissolve, UIView.AnimationOptions.beginFromCurrentState],
            animations: {
                self.reloadData()
        })
    }
}
