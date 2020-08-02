//
//  MainViewController.swift
//  GistsApp
//
//  Created by Nik on 27.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

protocol MainTableDelegate: class {
    func selectGistItem(_ gist: GistEntity)
    func selectUserItem(_ user: UserEntity)
}

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: MainTableViewController!

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        initSettings()
    }

    // MARK: - Settings
    func initSettings() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.isNavigationBarHidden = true

        mainTableView.mainTableDelegate = self
        mainTableView.setController(self)
        mainTableView.loadGists()
    }

    // MARK: - Additional functions
    func openUserDetail(_ user: UserEntity) {
        let controller = Const.GET_STORYBOARD.instantiateViewController(withIdentifier: Const.USER_GISTS__VIEW_CONTROLLER) as! UserGistsViewController
        controller.user = user
        controller.mainTableDelegate = self
//        let nController = UINavigationController(rootViewController: controller)
//        self.present(nController, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func openGistDetail(_ gist: GistEntity) {
        let controller = Const.GET_STORYBOARD.instantiateViewController(withIdentifier: Const.DETAIL_VIEW_CONTROLLER) as! DetailInfoGistViewController
        controller.gist = gist
//        let nController = UINavigationController(rootViewController: controller)
//        self.present(nController, animated: true, completion: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MainViewController: MainTableDelegate {
    func selectUserItem(_ user: UserEntity) {
        openUserDetail(user)
    }

    func selectGistItem(_ gist: GistEntity) {
        openGistDetail(gist)
    }
}
