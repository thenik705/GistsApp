//
//  IParser.swift
//  GistsApp
//
//  Created by Nik on 27.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

public protocol IParser {
    func parse(_ jsonArray: NSArray) -> NSArray!
    func parse(_ json: NSDictionary) -> NSObject!
}

public class FormParser: IParser {
    public func parse(_ jsonArray: NSArray) -> NSArray! {
        return nil
    }

    public func parse(_ json: NSDictionary) -> NSObject! {
        return nil
    }
}

public class ErrorParser: IParser {
    public func parse(_ jsonArray: NSArray) -> NSArray! {
        return nil
    }

    public func parse(_ json: NSDictionary) -> NSObject! {
        if let message = json["message"] as? String {
            if let code = json["code"] as? Int {
                return ErrorEntity(code, message)
            }
        }

        return nil
    }
}

public class GistsParser: IParser {
    public func parse(_ jsonArray: NSArray) -> NSArray! {
        var gists = [GistEntity]()

        for element in jsonArray {
            let dicElement = element as! NSDictionary

            if let newGist = parse(dicElement) as? GistEntity {
                gists.append(newGist)
            }
        }

        return gists as NSArray
    }

    public func parse(_ json: NSDictionary) -> NSObject! {
        let gist = GistEntity()
        gist.idItem = json["id"] as? String
        gist.descript = json["description"] as? String

        if let owner = json["owner"] as? [String: Any] {
            let user = UserEntity()

            user.avatarUrl = owner["avatar_url"] as? String
            user.name = owner["login"] as? String
            gist.user = user
        }

        if let files = json["files"] as? [String: Any] {
            for file in files {
                let newFile = FileEntity()
                if let fileInfo = file.value as? [String: Any] {
                    newFile.rawUrl = fileInfo["raw_url"] as? String
                    newFile.type = fileInfo["type"] as? String
                }

                newFile.name = file.key
                gist.files.append(newFile)
            }
        }

        return gist
    }
}

public class CommitParser: IParser {
    public func parse(_ jsonArray: NSArray) -> NSArray! {
        var commits = [CommitEntity]()

        for element in jsonArray {
            let dicElement = element as! NSDictionary

            if let newCommit = parse(dicElement) as? CommitEntity {
                commits.append(newCommit)
            }
        }

        return commits as NSArray
    }

    public func parse(_ json: NSDictionary) -> NSObject! {
        let commit = CommitEntity()
        commit.version = json["version"] as? String
        commit.date = json["committed_at"] as? String

        if let status = json["change_status"] as? [String: Any] {
            commit.addedRow = status["additions"] as? Int
            commit.deletedRow = status["deletions"] as? Int
        }

        return commit
    }
}
