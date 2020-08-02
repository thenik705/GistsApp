//
//  PreviewCell.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

protocol GistPreviewCellDelegate: class {
    func selectOpenPreview(_ file: FileEntity)
}

class PreviewCell: UITableViewCell {

    static let identifier = "PreviewCell"

    @IBOutlet weak var nameFile: UILabel!
    @IBOutlet weak var previewText: UITextView!
    @IBOutlet weak var noContentTitle: UILabel!
    @IBOutlet weak var loaderContent: UIActivityIndicatorView!

    weak var delegate: GistPreviewCellDelegate?

    var rowFile: FileEntity!

    // MARK: - viewDidLoad
    func loadCell(_ file: FileEntity) {
        rowFile = file

        nameFile.text = rowFile.name

        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                self.loadPreview()
            }
        }
    }

    // MARK: - Actions
    @IBAction func selectOpenPreviewActionButton(_ sender: Any) {
        delegate?.selectOpenPreview(rowFile)
    }

    @IBAction func selectCopyActionButton(_ sender: Any) {

    }

    // MARK: - Additional functions
    func loadPreview() {
        isEditStatusPreview()

        API().loadContentUrl(rowFile.rawUrl ?? "", callback: {(text) -> Void in
             self.previewText.text = text
            self.isEditStatusPreview(false)
         }, callbackError: {() -> Void in
             self.isEditStatusPreview(false)
         })
    }

    func isEditStatusPreview(_ isHidden: Bool = true) {
        previewText.isHidden = isHidden
        self.noContentTitle.isHidden = !previewText.text.isEmpty
        loaderContent.isHidden = !isHidden
    }
}
