//
//  UserGistsViewController.swift
//  GistsApp
//
//  Created by Nik on 02.08.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class UserGistsViewController: UIViewController {

    @IBOutlet weak var infoTableView: UserGistsTableViewController!

    weak var mainTableDelegate: MainTableDelegate?

    var lightStatusBar = false
    var sectionType: SectionType = .userInfo
    var user: UserEntity?

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
        title = "User"
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
}
