//
//  ColorValueTransformer.swift
//  MyCars
//
//  Created by Aksilont on 19.05.2021.
//

import UIKit
import CoreData

@objc(ColorValueTransformer)
final class ColorValueTransformer: NSSecureUnarchiveFromDataTransformer {
    override static var allowedTopLevelClasses: [AnyClass] {
        return [UIColor.self]
    }
}
