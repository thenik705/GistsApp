//
//  DetailInfoGistTableViewController.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class DetailInfoGistTableViewController: UITableView, UITableViewDataSource, UITableViewDelegate {

    var sections = [Sections]()
    var rootController: DetailInfoGistViewController!
    var nowSectionType: SectionType = .gistInfo

    var gist: GistEntity?

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
        case SectionEntity.Preview.getId():
            return gist?.files.count ?? 0
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowSection = sections[indexPath.section].getType()

        switch rowSection.getId() {
        case SectionEntity.GistInfo.getId():
            return loadGistCell(indexPath)
        case SectionEntity.Preview.getId():
            return loadPreviewCell(indexPath)
        default:
            return loadSubstrateCell(indexPath)
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
    func setController(_ controller: DetailInfoGistViewController) {
        self.rootController = controller
        self.gist = rootController.gist
    }

    func loadGistCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: GistCell.identifier, for: indexPath) as! GistCell

        if let gist = gist {
            cell.loadCell(gist)
            cell.delegate = rootController
        } else {
            return loadSubstrateCell(indexPath)
        }

        return cell
    }

    func loadPreviewCell(_ indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: PreviewCell.identifier, for: indexPath) as! PreviewCell

        if let gist = gist {
            let rowFile = gist.files[indexPath.row]
            cell.loadCell(rowFile)
            cell.delegate = rootController
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

    func loadInfo(_ sectionType: SectionType = .gistInfo) {
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
