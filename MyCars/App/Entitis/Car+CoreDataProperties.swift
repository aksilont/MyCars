//
//  Car+CoreDataProperties.swift
//  MyCars
//
//  Created by Aksilont on 19.05.2021.
//
//

import UIKit
import CoreData

extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var timesDriven: Int16
    @NSManaged public var rating: Double
    @NSManaged public var myChoice: Bool
    @NSManaged public var mark: String?
    @NSManaged public var model: String?
    @NSManaged public var lastStarted: Date?
    @NSManaged public var imageData: Data?
    @NSManaged public var tintColor: UIColor?

}

extension Car : Identifiable {

}
