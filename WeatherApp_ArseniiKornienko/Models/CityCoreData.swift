//
//  City.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/24/24.
//

import Foundation
import CoreData

@objc(CityCoreData)
public class CityCoreData: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityCoreData> {
        return NSFetchRequest<CityCoreData>(entityName: "CityCoreData")
    }
    
    @NSManaged public var id: Int
    @NSManaged public var name: String?
    @NSManaged public var state: String?
    @NSManaged public var country: String?
    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
}
