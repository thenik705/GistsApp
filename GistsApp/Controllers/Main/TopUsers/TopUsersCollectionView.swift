//
//  TopUsersCollectionView.swift
//  GistsApp
//
//  Created by Nik on 01.08.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import Foundation
import UIKit

class TopUsersCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    weak var mainTableDelegate: MainTableDelegate?

    var users = [UserEntity]()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSettings()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopUserItemCell.identifier, for: indexPath) as! TopUserItemCell

        let rowUser = users[indexPath.row]
        cell.loadCell(rowUser)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rowUser = users[indexPath.row]
        mainTableDelegate?.selectUserItem(rowUser)
    }

     func initSettings() {
        dataSource = self
        delegate = self

        backgroundColor = nil
    }

    // MARK: - Additional functions
}
