//
//  AlertAction.swift
//  ImageActionSheet
//
//  Created by Bisma Saeed on 21.05.20.
//  Copyright © 2020 Bisma Saeed. All rights reserved.
//

import UIKit

public class AlertAction {
    let title: String?
    let icon: UIImage?
    @objc let action: (() -> Void)?
    
    init(title: String?, icon: UIImage?, action: (() -> Void)?) {
        self.title = title
        self.icon = icon
        self.action = action
    }
}

extension AlertAction: Equatable {
    public static func == (lhs: AlertAction, rhs: AlertAction) -> Bool {
        return lhs.title == rhs.title &&
            lhs.icon == rhs.icon
    }
}
