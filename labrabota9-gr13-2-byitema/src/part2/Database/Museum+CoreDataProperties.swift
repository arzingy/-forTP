import Foundation
import CoreData

extension Museum {
    @NSManaged public var museum: String?
    @NSManaged public var address: String?
    @NSManaged public var exhibitions: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Museum> {
        return NSFetchRequest<Museum>(entityName: "Museum")
    }
}
