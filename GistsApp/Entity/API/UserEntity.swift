//
//  UserEntity.swift
//  GistsApp
//
//  Created by Nik on 01.08.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import Foundation

class UserEntity: NSObject {

    var name: String?
    var avatarUrl: String?

    var gists = [GistEntity]()
}
