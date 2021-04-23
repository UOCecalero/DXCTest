//
//  String+Extension.swift
//  DXCFilmFounder
//
//  Created by ESFDS on 23/04/2021.
//  Copyright © 2021 Lynx Developers. All rights reserved.
//

import UIKit

extension String {
    /// Returns an attributed string with certain properties.
    /// A nil parameter will be ignored.
    func attributedWith(font: UIFont? = nil,
                        color: UIColor? = nil,
                        underline: NSUnderlineStyle? = nil,
                        lineSpacing: CGFloat? = nil,
                        paragraphSpacing: CGFloat? = nil,
                        lineBreakMode: NSLineBreakMode? = nil,
                        minimumLineHeight: CGFloat? = nil) -> NSAttributedString {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if font != nil {
            attributes[.font] = font
        }
        if color != nil {
            attributes[.foregroundColor] = color
        }
        if let underline = underline {
            attributes[.underlineStyle] = underline.rawValue
        }
        if lineSpacing != nil || paragraphSpacing != nil || lineBreakMode != nil || minimumLineHeight != nil {
            let paragraphStyle = NSMutableParagraphStyle()
            if let paragraphSpacing = paragraphSpacing {
                paragraphStyle.paragraphSpacing = paragraphSpacing
            }
            if let lineBreakMode = lineBreakMode {
                paragraphStyle.lineBreakMode = lineBreakMode
            }
            if let lineSpacing = lineSpacing {
                paragraphStyle.lineSpacing = lineSpacing
            }
            if let minimumLineHeight = minimumLineHeight {
                paragraphStyle.minimumLineHeight = minimumLineHeight
            }
            attributes[.paragraphStyle] = paragraphStyle
        }
        return NSAttributedString(string: self, attributes: attributes)
    }
 }
