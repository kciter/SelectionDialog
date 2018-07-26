//
//  SelectionDialogItem.swift
//  Sample
//
//  Created by LeeSunhyoup on 2015. 9. 29..
//  Copyright © 2015년 SelectionView. All rights reserved.
//

import UIKit

open class SelectionDialogItem: NSObject {
    var icon: UIImage?
    var itemTitle: String
    var handler: (() -> Void)?
    var font: UIFont?
    
    public init(item itemTitle: String) {
        self.itemTitle = itemTitle
    }
    
    public init(item itemTitle: String, icon: UIImage) {
        self.itemTitle = itemTitle
        self.icon = icon
    }
    
    public init(item itemTitle: String, didTapHandler: @escaping (() -> Void)) {
        self.itemTitle = itemTitle
        self.handler = didTapHandler
    }
    
    public init(item itemTitle: String, icon: UIImage, didTapHandler: @escaping (() -> Void)) {
        self.itemTitle = itemTitle
        self.icon = icon
        self.handler = didTapHandler
    }
    
    public init(item itemTitle: String, icon: UIImage, font: UIFont, didTapHandler: @escaping (() -> Void)) {
        self.itemTitle = itemTitle
        self.icon = icon
        self.handler = didTapHandler
        self.font = font
    }
    
    @objc func handlerTap() {
        handler?()
    }
}
