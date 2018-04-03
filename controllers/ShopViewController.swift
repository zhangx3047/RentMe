//
//  ShopViewController.swift
//  RentMe
//

import UIKit

class ShopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var buttonContainer: UIView!
  var theShop: RentalShop!
  @IBOutlet weak var shopTable: UITableView!
  @IBOutlet weak var priceSortButton: UIButton!
  
  var unsortedBoats = [Rental]()
  
  var priceSortState = SortState.None
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = theShop.locationName
    self.automaticallyAdjustsScrollViewInsets = false
    sortArrow.isHidden = true
    buttonContainer.backgroundColor = blueColor
    // Do any additional setup after loading the view
    
    unsortedBoats = theShop.rentals
    
  }
  @IBOutlet weak var sortArrow: UIImageView!
  
  enum SortState: String {
    case None = "None", Up = "Up", Down = "Down"
  }
  
  @IBAction func sortPressed(_ sender: Any) {
    if priceSortState == .None {
      sortArrow.isHidden = false
      print("sort by acsending price")
      sortArrow.image = UIImage(named: "downarrow")
      priceSortState = .Up
      
      theShop.rentals =  theShop.rentals.sorted( by: {
        (boatA, boatB) in
        if boatA.price > boatB.price {
          return true
        }
        return false
      })
      
    } else if priceSortState == .Up {
      print("sort by descending price")
      priceSortState = .Down
      sortArrow.isHidden = false
      sortArrow.image = UIImage(named: "uparrow")
      theShop.rentals = theShop.rentals.sorted(by: {
        (boatA, boatB) in
        if boatA.price < boatB.price {
          return true
        }
        return false
      })
    } else if priceSortState == .Down {
      print("sort by none")
      sortArrow.isHidden = true
      theShop.rentals = unsortedBoats
      priceSortState = .None
    }
    shopTable.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return theShop.rentals.count
  
  }
 
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "boatcell", for: indexPath) as! BoatCell
    
    cell.boatImage.image = theShop.rentals[indexPath.row].pictures[0]
    cell.boatNameLabel.text = theShop.rentals[indexPath.row].name
    cell.priceLabel.text = "$\(theShop.rentals[indexPath.row].price)/day"
    cell.distanceLabel.text = "\(theShop.rentals[indexPath.row].distance) miles"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let boatVC = self.storyboard?.instantiateViewController(withIdentifier: "boatviewcontroller")
     as! BoatViewController

    boatVC.theRental = theShop.rentals[indexPath.row]
    self.show(boatVC, sender: nil)
    tableView.deselectRow(at: indexPath, animated: false)
    
  }
 
}
