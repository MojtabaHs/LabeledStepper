//
//  Style.swift
//  
//
//  Created by Seyed Mojtaba Hosseini Zeidabadi on 1/13/22.
//  
//
//  StackOverflow: https://stackoverflow.com/story/mojtabahosseini
//  Linkedin: https://linkedin.com/in/MojtabaHosseini
//  GitHub: https://github.com/MojtabaHs
//

import SwiftUI

public struct Style {

    public init(
        height: Double = 34.0,
        labelWidth: Double = 48.0,
        buttonWidth: Double = 48.0,
        buttonPadding: Double = 12.0,
        backgroundColor: Color = Color(.quaternarySystemFill),
        activeButtonColor: Color = Color(.label),
        inactiveButtonColor: Color = Color(.tertiaryLabel),
        titleColor: Color = Color(.label),
        descriptionColor: Color = Color(.secondaryLabel),
        valueColor: Color = Color(.label)
    ) {
        self.height = height
        self.labelWidth = labelWidth
        self.buttonWidth = buttonWidth
        self.buttonPadding = buttonPadding
        self.backgroundColor = backgroundColor
        self.activeButtonColor = activeButtonColor
        self.inactiveButtonColor = inactiveButtonColor
        self.titleColor = titleColor
        self.descriptionColor = descriptionColor
        self.valueColor = valueColor
    }

    // TODO: Make these dynamic
    var height: Double
    var labelWidth: Double

    var buttonWidth: Double
    var buttonPadding: Double

    // MARK: - Colors
    var backgroundColor: Color
    var activeButtonColor: Color
    var inactiveButtonColor: Color

    var titleColor: Color
    var descriptionColor: Color
    var valueColor: Color
}
