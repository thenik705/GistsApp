//
//  ComitsViewController.swift
//  GistsApp
//
//  Created by n.poliakov on 31.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class CommitsViewController: UIViewController {

    @IBOutlet weak var commitsTableView: CommitsTableViewController!

    var lightStatusBar = false
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
        title = "Commits"

        commitsTableView.setController(self)
        commitsTableView.loadComments()
    }

    // MARK: - Additional functions

    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.lightStatusBar ? .lightContent : .default
    }
}
