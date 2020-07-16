//
//  BSAlertAction.swift
//  ImageActionSheet
//
//  Created by Bisma Saeed on 21.05.20.
//  Copyright © 2020 Bisma Saeed. All rights reserved.
//

import UIKit

public class BSAlertAction {
    let title: String?
    let icon: UIImage?
    @objc let action: (() -> Void)?
    
    public init(title: String?, icon: UIImage?, action: (() -> Void)?) {
        self.title = title
        self.icon = icon
        self.action = action
    }
}

extension BSAlertAction: Equatable {
    public static func == (lhs: BSAlertAction, rhs: BSAlertAction) -> Bool {
        return lhs.title == rhs.title &&
            lhs.icon == rhs.icon
    }
}
