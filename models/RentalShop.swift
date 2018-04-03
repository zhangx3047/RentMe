
import Foundation

import Foundation
import MapKit

struct Rental {
  var name: String
  var rating: Float
  var price: Float
  var distance: Float
  var pictures: [UIImage]
  var shop: RentalShop
}

class RentalShop: NSObject, MKAnnotation {
  var locationName: String = ""
  var coordinate: CLLocationCoordinate2D
  var rentals: [Rental] = []
  
  init(locationName: String, coordinate: CLLocationCoordinate2D) {
    self.locationName = locationName
    self.coordinate = coordinate
    super.init()
  }
  
  func addRental(rental: Rental) {
    self.rentals.append(rental)
  }
  
  
  var title: String? {
    return locationName
  }
  
  var subtitle: String? {
    return locationName
  }
}
