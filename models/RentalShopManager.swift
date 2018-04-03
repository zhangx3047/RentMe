

import Foundation

import Foundation
import MapKit

class RentalShopManager: NSObject {
  
  var rentalShops: [RentalShop]!
  
  static let sharedInstance = RentalShopManager()


//  class var sharedInstance: RentalShopManager {
//    struct Static {
//      static var onceToken: dispatch_once_t = 0
//      static var instance: RentalShopManager? = nil
//    }
//    dispatch_once(&Static.onceToken) {
//      Static.instance = RentalShopManager()
//    }
//    return Static.instance!
//  }
  
  override init() {
    super.init()
    populateRentalShops()
  }
  
  func populateRentalShops(){
    rentalShops = [RentalShop]()
    
    let jamesShop = RentalShop(locationName: "James' Water Sports", coordinate:CLLocationCoordinate2DMake(46.792398, -92.093845))
    
    
    let masterBoat =  Rental(name:"2014 MasterCraft Pro", rating:5, price: 330, distance: 2.3, pictures: [UIImage(named: "master1")!,UIImage(named: "master2")!, UIImage(named: "master3")!], shop: jamesShop)
    
    let skiBoat = Rental(name:"2003 Ski Nautique", rating:4.5, price: 155, distance: 2.3, pictures: [UIImage(named: "boatB")!], shop: jamesShop)
    
    let pontoon = Rental(name:"2012 Sav X Ski", rating:5.0, price: 280, distance: 2.3, pictures: [UIImage(named: "boatC")!], shop: jamesShop)
    
    jamesShop.addRental(rental: masterBoat)
    jamesShop.addRental(rental: skiBoat)
    jamesShop.addRental(rental: pontoon)
    
    let michaelsShop = RentalShop(locationName: "Michael's Water Rentals", coordinate: CLLocationCoordinate2DMake(46.776959, -92.104082))
    
    michaelsShop.addRental(rental: masterBoat)
    michaelsShop.addRental(rental: skiBoat)
    michaelsShop.addRental(rental: pontoon)
    
    let ryanShop = RentalShop(locationName: "Ryan's Shop", coordinate: CLLocationCoordinate2DMake(46.780077, -92.101092))
    
    ryanShop.addRental(rental: masterBoat)
    ryanShop.addRental(rental: skiBoat)
    ryanShop.addRental(rental: pontoon)
    
    
    rentalShops.append(jamesShop)
    rentalShops.append(michaelsShop)
    rentalShops.append(ryanShop)
  }
}
