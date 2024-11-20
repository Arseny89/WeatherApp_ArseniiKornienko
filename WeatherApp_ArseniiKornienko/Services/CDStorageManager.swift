//
//  CoreDataManager.swift
//  WeatherApp_ArseniiKornienko
//
//  Created by Арсений Корниенко on 6/24/24.
//

import Foundation
import CoreData

final class CDStorageManager {
    private let syncQueue = DispatchQueue(label: "CDStorageManager.syncQueue")
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error { fatalError("Loading failed") }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
}

extension CDStorageManager {
    //MARK: Upload
    func set(_ data: [CityData], completion: @escaping (Bool) -> Void) {
        syncQueue.sync { [weak context] in
                   guard let context else { return }
            
            data.forEach { data in
                let city = CityCoreData(context: context)
                city.id = data.id
                city.name = data.name
                city.state = data.state
                city.country = data.country
                city.lat = data.coordinates.latitude
                city.lon = data.coordinates.longitude
            }
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Error saving to CoreData")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    //MARK: Read
    func fetch(completion: @escaping ([CityData]?) -> Void) {
        syncQueue.sync { [weak context] in
                   guard let context else { return }
            
            let fetchRequest:
            NSFetchRequest<CityCoreData> = CityCoreData.fetchRequest()
            let fetchResult = try? context.fetch(fetchRequest)
            
            let data = fetchResult?.map {city in
                CityData(id: city.id,
                         name: city.name ?? "",
                         state: city.state ?? "",
                         country: city.country ?? "",
                         coordinates: Coordinates(latitude: city.lat,
                                                  longitude: city.lon))
            }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    func fetchData(with id: Int, completion: @escaping (CityData?) -> Void) {
        syncQueue.sync { [weak context] in
                   guard let context else { return }
            
            let fetchRequest = CityCoreData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
            let fetchResult = try? context.fetch(fetchRequest)
            let city = fetchResult?.first
            DispatchQueue.main.async {
                if let city {
                    completion(CityData(id: city.id,
                                        name: city.name ?? "",
                                        state: city.state ?? "",
                                        country: city.country ?? "",
                                        coordinates: Coordinates(latitude: city.lat,
                                                                 longitude: city.lon)))
                } else {
                    completion(nil)
                }
            }
        }
    }
    
    func fetchCitySearch(with searchText: String, completion: @escaping ([CityData]) -> Void) {
        let fetchRequest = CityCoreData.fetchRequest()
        let nameDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [nameDescriptor]
        fetchRequest.fetchBatchSize = 20
        
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText.lowercased())
        
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { request in
            guard let result = request.finalResult else { return }
            
            let data = result.map { city in
                return CityData(id: city.id,
                                name: city.name ?? "",
                                state: city.state ?? "",
                                country: city.country ?? "",
                                coordinates: Coordinates(latitude: city.lat,
                                                         longitude: city.lon))
            }
            DispatchQueue.main.async {
                completion(data)
        }
    }
        do {
            try context.execute(asyncFetchRequest)
        } catch {
            completion([])
        }
}
        //MARK: Delete
        func removeAllData(completion: @escaping (Bool) -> Void) {
            syncQueue.sync { [weak context] in
                       guard let context else { return }
                
                let fetchRequest:
                NSFetchRequest<CityCoreData> = CityCoreData.fetchRequest()
                let fetchResult = try? context.fetch(fetchRequest)
                
                fetchResult?.forEach { data in
                    context.delete(data)
                }
            }
            do {
                try context.save()
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Error saving to CoreData")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
        
        func remove(_ id: Int, completion: @escaping (Bool) -> Void) {
            syncQueue.sync { [weak context] in
                       guard let context else { return }
                
                let fetchRequest:
                NSFetchRequest<CityCoreData> = CityCoreData.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
                let fetchResult = try? context.fetch(fetchRequest)
                
                fetchResult?.forEach { data in
                    context.delete(data)
                }
            }
            do {
                try context.save()
                
                DispatchQueue.main.async {
                    completion(true)
                }
            } catch {
                print("Error saving to CoreData")
                
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    
    
}
