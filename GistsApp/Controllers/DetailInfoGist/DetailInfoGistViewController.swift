//
//  DetailInfoGistViewController.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit
import SafariServices

class DetailInfoGistViewController: UIViewController {

    @IBOutlet weak var infoTableView: DetailInfoGistTableViewController!

    var lightStatusBar = false
    var sectionType: SectionType = .gistInfo
    var gist: GistEntity?

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        initSettings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lightStatusBar = true
        self.navigationController?.isNavigationBarHidden = false
        UIView.animate(withDuration: 0.3) { () -> Void in
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    // MARK: - Settings
    func initSettings() {
        title = "Gist Detailed"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        infoTableView.setController(self)
        infoTableView.loadInfo(sectionType)
    }

    // MARK: - Additional functions
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.lightStatusBar ? .lightContent : .default
    }

    func openCommentsList(_ gist: GistEntity) {
        let controller = Const.GET_STORYBOARD.instantiateViewController(withIdentifier: Const.COMMITS_VIEW_CONTROLLER) as! CommitsViewController
        controller.gist = gist
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension DetailInfoGistViewController: GistPreviewCellDelegate, SFSafariViewControllerDelegate {
    func selectOpenPreview(_ file: FileEntity) {
        if let url = URL(string: file.rawUrl ?? "") {
            let controller = SFSafariViewController(url: url)
            controller.delegate = self
            self.present(controller, animated: true, completion: nil)
        } else {
            print("ERROR!")
        }
    }

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension DetailInfoGistViewController: GistCellDelegate {
    func selectOpenCommits(_ gist: GistEntity) {
        openCommentsList(gist)
    }
}
