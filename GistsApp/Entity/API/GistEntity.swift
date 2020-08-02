//
//  GistEntity.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import Foundation

class GistEntity: NSObject {

    var idItem: String?
    var user: UserEntity?
    var descript: String?

    var files = [FileEntity]()
    var comments = [CommitEntity]()
}
