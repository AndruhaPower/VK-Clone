//
//  NewsViewModel.swift
//  L1_GBVk
//
//  Created by Andrew on 24/10/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit


final class NewsViewModel: CustomStringConvertible {
    
    var commentCount: Int
    var date: Double
    var likesCount: Int
    var repostCount: Int
    var viewsCount: Int
    var text: String
    var name: String
    var avatarPhotoUrl: String
    var attachments: [Attachments]
    
    var description: String {
        return String(self.date) + " - ДАТА \n" + String(self.text) + " \n - ТЕКСТ \n" + String(self.name) + " - ГРУППА"
    }
    
    init(news: Feed, name: String, avatarPhotoUrl: String) {
        self.commentCount = news.commentCount
        self.likesCount = news.likesCount
        self.repostCount = news.repostCount
        self.viewsCount = news.viewsCount
        self.attachments = news.attachments
        self.text = news.text
        self.date = news.date
        self.name = name
        self.avatarPhotoUrl = avatarPhotoUrl
    }
}

final class NewsViewModelFabric {
    
    static func setupNewsData(news: [Feed], groups: [Groups]) -> ([NewsViewModel]) {
        var newsViewModel: [NewsViewModel] = []
        for post in news {
            for group in groups {
                if group.id == -(post.source_id) {
                    newsViewModel.append(NewsViewModel(news: post, name: group.name, avatarPhotoUrl: group.photoUrl))
                }
            }
        }
        return newsViewModel
    }
}
