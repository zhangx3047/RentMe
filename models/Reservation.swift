

import Foundation

class Reservation: NSObject {
  
  var rental: Rental
  var time: NSDate
  var isCompleted: Bool!
  

  init(rental: Rental, time: NSDate) {
    self.rental = rental
    self.time = time
    self.isCompleted = false
    super.init()
  }
}
