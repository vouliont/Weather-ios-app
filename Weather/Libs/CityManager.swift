import UIKit
import CoreData

class CityManager {
    let managedContext: NSManagedObjectContext
    
    init() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = delegate.persistentContainer.viewContext
    }
    
    func getCities() -> [City] {
        let request: NSFetchRequest<City> = City.fetchRequest()
        var cities = [City]()
        
        do {
            cities = try managedContext.fetch(request)
        } catch {
            print("Core data fetching cities error.")
        }
        
        return cities
    }
    
    func addCity(_ name: String, lat: Double, lng: Double) {
        let coordinate = Coordinate(context: managedContext)
        coordinate.latitude = lat
        coordinate.longitude = lng
        let city = City(context: managedContext)
        city.name = name
        city.coordinate = coordinate
        
        do {
            try managedContext.save()
        } catch {
            print("Error while try to save context after adding city.")
        }
    }
    
    func removeCity(_ city: City) {
        managedContext.delete(city)
        
        do {
            try managedContext.save()
        } catch {
            print("Error while try to save context after removing city")
        }
    }
}
