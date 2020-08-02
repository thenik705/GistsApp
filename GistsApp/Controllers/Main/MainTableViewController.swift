//
//  MainTableViewController.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class MainTableViewController: UITableView, UITableViewDataSource, UITableViewDelegate {

    weak var mainTableDelegate: MainTableDelegate?

    var sections = Sections.createSections()
    var rootController: MainViewController!
    var gists = [GistEntity]()
    var users = [UserEntity]()

    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSettings()
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = dequeueReusableHeaderFooterView(withIdentifier: TableSectionHeader.identifier) as! TableSectionHeader
        let rowSection = sections[section]

        if rowSection.getType().getIsHidden() {
            return UIView()
        }

        cell.loadSection(rowSection)
        cell.isShowAllButton(rowSection.getType().getIsShowAll())
        cell.background.backgroundColor = .clear

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowSection = sections[section].getType()

        switch rowSection.getId() {
        case SectionEntity.GistList.getId():
            return gists.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowSection = sections[indexPath.section].getType()

        switch rowSection.getId() {
        case SectionEntity.TopUsers.getId():
            return loadTopUserCell(indexPath)
        case SectionEntity.GistList.getId():
            return loadGistCell(indexPath)
        default:
            return loadSubstrateCell(indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowSection = sections[indexPath.section].getType()

        if rowSection.getId() == SectionEntity.GistList.getId() {
            if !gists.isEmpty {
                mainTableDelegate?.selectGistItem(gists[indexPath.row])
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }

    // MARK: - Settings
    func initSettings() {
        dataSource = self
        delegate = self

        estimatedRowHeight = 200
        sectionFooterHeight = 0

        let nib = UINib(nibName: TableSectionHeader.identifier, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: TableSectionHeader.identifier)
    }

    // MARK: - Additional functions
    func setController(_ controller: MainViewController) {
        self.rootController = controller
    }

    func loadGists() {
        API().getGists(APICallback(completion: { (result: (NSObject)) in
            if let gistsResult = result as? [GistEntity] {
                self.gists = gistsResult
                self.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
                self.loadUsers()
            }
        }, error: { (resultError: (ErrorEntity)) in
            print(resultError)
        }))
    }

    func loadUsers() {
        var users = [UserEntity]()

        for gist in gists {
            if let user = gist.user {
                let user = users.first(where: { $0.name == user.name }) ?? user

                if !users.contains(user) {
                    users.append(user)
                }

                user.gists.append(gist)
            }
        }

        self.users = users.sorted {
            $0.gists.count > $1.gists.count
        }

        self.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }

    func loadTopUserCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: TopUserCell.identifier, for: indexPath) as! TopUserCell

        cell.loadCell(rootController, users: users)

        return cell
    }

    func loadGistCell(_ indexPath: IndexPath) -> UITableViewCell {
        if gists.isEmpty {
            return loadSubstrateCell(indexPath)
        }

        let cell = dequeueReusableCell(withIdentifier: GistCell.identifier, for: indexPath) as! GistCell
        let rowGist = gists[indexPath.row]

        cell.loadCell(rowGist)

        return cell
    }

    func loadSubstrateCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: SubstrateCell.identifier, for: indexPath) as! SubstrateCell
//        let rowSection = sections[indexPath.section]
//        cell.loadCell(rowSection.emptyTitle, rowSection.emptySubTitle)

        return cell
    }
}
