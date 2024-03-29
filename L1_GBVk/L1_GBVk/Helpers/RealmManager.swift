//
//  RealmManager.swift
//  L1_GBVk
//
//  Created by Andrew on 21/07/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Realm
import RealmSwift

final public class RealmManager {
    
    static func friendsManager(friends: [Friend]) {
        for each in friends {
            let friend = RFriend()
            friend.name = each.name
            friend.photo = each.photo
            friend.id = each.id
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(friend, update: .modified)
                }
            } catch {
                print(error)
            }
        }
    }
    
    static func groupsManager(groups: [Group]) {
        for each in groups {
            let group = RGroup()
            group.name = each.name
            group.id = each.id
            group.photo = each.photo
            group.isMember = each.isMember
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(group, update: .modified)
                }
            }catch {
                    print(error)
                }
        }
    }
}
