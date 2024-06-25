//
//  City+CoreDataProperties.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/24/24.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var lon: Double
    @NSManaged public var lat: Double

}

extension City : Identifiable {

}
