//
//  SectionEntity.swift
//  GistsApp
//
//  Created by Nik on 28.07.2020.
//  Copyright © 2020 Nik. All rights reserved.
//

import UIKit

class SectionEntity {

    static public let TopUsers = SectionEntity(0, title: "Top Users")
    static public let GistList = SectionEntity(1, title: "Gists")
    static public let Preview = SectionEntity(2, title: "Preview")
    static public let GistInfo = SectionEntity(4, title: "GistInfo")
    static public let UserInfo = SectionEntity(5, title: "UserInfo")

    static public func allValues() -> [SectionEntity] {
        return [TopUsers, GistList, Preview, GistInfo, UserInfo]
    }

    static public func mainValues() -> [SectionEntity] {
        return [TopUsers, GistList]
    }

    static public func detailValues() -> [SectionEntity] {
        return [GistInfo, Preview]
    }

    static public func detailUserValues() -> [SectionEntity] {
        return [UserInfo, GistList]
    }

    static public func getValues(_ sectionType: SectionType = .main) -> [SectionEntity] {
        return values(sectionType)
    }

    static public func getAddValuesIndex(_ sectionType: SectionType = .main, _ type: SectionEntity) -> Int {
        let typeValues = values(sectionType)
        return typeValues.firstIndex(where: { $0.itemId == type.itemId }) ?? 0
    }

    public var itemId: Int
    public var title: String
    public var subTitle: String?
    public var emptyTitle: String
    public var emptySubTitle: String
    public var isHidden: Bool
    public var isShowAll: Bool

    fileprivate init(_ itemId: Int, title: String, subTitle: String? = nil, emptyTitle: String = "", emptySubTitle: String = "", isHidden: Bool = false, isShowAll: Bool = false) {
        self.itemId = itemId
        self.title = title
        self.subTitle = subTitle
        self.emptyTitle = emptyTitle
        self.emptySubTitle = emptySubTitle
        self.isHidden = isHidden
        self.isShowAll = isShowAll
    }

    static public func byId(_ itemId: Int) -> SectionEntity? {
        return allValues().first(where: { $0.itemId == itemId })
    }

    static public func byTitle(_ title: String) -> SectionEntity? {
        return allValues().first(where: { $0.title == title })
    }

    static public func values(_ sectionType: SectionType = .main) -> [SectionEntity] {
        var volues = mainValues()

        if sectionType == .gistInfo {
            volues = detailValues()
        } else if sectionType == .userInfo {
            volues = detailUserValues()
        }

        return volues
    }

    func setTitle(_ title: String) {
        self.title = title
    }

    func setSubTitle(_ subTitle: String) {
        self.subTitle = subTitle
    }

    public func getId() -> Int {
        return itemId
    }

    public func getTitle() -> String {
        return title
    }

    public func getSubTitle() -> String {
        return subTitle ?? ""
    }

    public func getIsShowAll() -> Bool {
        return isShowAll
    }

    public func getIsHidden() -> Bool {
        return isHidden
    }
}
