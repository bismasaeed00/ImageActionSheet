//
//  ActionSheetConfiguration.swift
//  ImageActionSheet
//
//  Created by Bisma Saeed on 21.05.20.
//  Copyright © 2020 Bisma Saeed. All rights reserved.
//

import UIKit

public struct ActionSheetConfiguration {
    var cancelButtonTitle = "Cancel"
    var tintColor = UIColor.systemBlue
    var infoColor = UIColor.lightGray
    var titleFontSize: CGFloat = 15
    var messageFontSize: CGFloat = 14
    var alertFontSize: CGFloat = 17
    var cancelFontSize: CGFloat = 17
    
    //MARK: Layout configurations
    var viewPadding: CGFloat = 16.0
    var bottomPadding: CGFloat = 32.0
    var seperationPadding: CGFloat = 10.0
    var contentPadding: CGFloat = 20.0
    var elementHeight: CGFloat = 40
}
