//
//  ErrorEntity.swift
//  GistsApp
//
//  Created by Nik on 27.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import Foundation

class ErrorEntity: NSObject {

    var code: Int
    var message: String

    internal init(_ code: Int, _ message: String) {
        self.code = code
        self.message = message
    }

    func getErrorTitle() -> String {
        return message
    }
}
