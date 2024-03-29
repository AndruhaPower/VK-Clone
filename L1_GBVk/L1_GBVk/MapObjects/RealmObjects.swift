//
//  RealmObjects.swift
//  L1_GBVk
//
//  Created by Andrew on 18/07/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import RealmSwift
import Realm

protocol RealmIndexable {
    var name: String { get set }
    var id: Int { get set }
}

class RFriend: Object, RealmIndexable {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String? = nil

    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id","name"]
    }
}

class RGroup: Object, RealmIndexable {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String? = nil
    @objc dynamic var isMember: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
