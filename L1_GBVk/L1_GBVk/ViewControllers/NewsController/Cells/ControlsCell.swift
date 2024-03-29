//
//  ControlsCell.swift
//  L1_GBVk
//
//  Created by Andrew on 16/10/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

final class ControlsCell: UITableViewCell {
    
    static var reuseIdentifier: String = "ControlsCellReuseId"
    @IBOutlet weak var stackView: ControlsStackView!
    @IBOutlet weak var viewsControl: ViewsControl!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.viewsControl.viewsCount = 0
        self.stackView.likes.likesCount = 0
        self.stackView.comments.commentsCount = 0
        self.stackView.shares.sharesCount = 0
    }
}

class ControlsStackView: UIStackView {
    
    @IBOutlet weak var likes: LikeButtonControl!
    @IBOutlet weak var comments: CommentControl!
    @IBOutlet weak var shares: ShareControl!
}
