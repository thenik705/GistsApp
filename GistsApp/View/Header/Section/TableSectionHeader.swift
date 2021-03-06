//
//  TableSectionHeader.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

protocol SectionDelegate: class {
    func tappedSection(_ type: SectionType)
}

class TableSectionHeader: UITableViewHeaderFooterView {

    static let identifier = "TableSectionHeader"

    weak var delegate: SectionDelegate?

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var allButton: UIButton!

    @IBOutlet weak var subTitleHeight: NSLayoutConstraint!

    var rowSection: Sections?
    var countMaxLabel = 0

    func loadSection(_ section: Sections, _ categories: Bool = true) {
        rowSection = section

        title.text = rowSection?.title ?? ""
        setSubTextSection("", categories)
    }

    func isShowAllButton(_ show: Bool = false) {
        allButton.alpha = show ? 1 : 0
    }

    func setSubTextSection(_ subText: String = "", _ categories: Bool = true) {
        var newSubTitle = rowSection?.subTitle ?? ""
        if rowSection != nil {
            newSubTitle += subText.isNotEmpty() ? " «\(subText)»" : ""

        }

        subTitle.text = newSubTitle
        subTitleHeight.constant = newSubTitle.isNotEmpty() ? 20 : 0
    }

    @IBAction func tappedAllButtonAction(_ sender: Any) {
//        delegate?.tappedSection(rowSection?.getType() === SectionEntity.History ? .history : .main)
    }
}
