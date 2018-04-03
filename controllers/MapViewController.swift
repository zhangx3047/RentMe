//
//  MapViewController.swift
//  RentMe
//
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  
  var mapView: MKMapView!
  let regionRadius: CLLocationDistance = 4000
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
    self.view.addSubview(mapView)
    
    mapView.delegate = self
    // set initial location in Duluth Only
    let initialLocation = CLLocation(latitude: 46.784587, longitude:  -92.118190)
    centerMapOnLocation(location: initialLocation)
    
    for shop in RentalShopManager.sharedInstance.rentalShops {
      DispatchQueue.main.async(){
        self.mapView.addAnnotation(shop)
      }
    }
    mapView.delegate = self
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius * 2.0, regionRadius * 2.0)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if let annotation = annotation as? RentalShop {
      let identifier = "pin"
      var view: MKPinAnnotationView
      
      if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        as? MKPinAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
      } else {
        
        view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        
        view.image = UIImage(named: "boaticon")
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        
        let goToButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        goToButton.setImage(UIImage(named: "rightarrow"), for: .normal)
        goToButton.addTarget(self, action: #selector(self.goToShop(button:)), for: .touchUpInside)
        view.rightCalloutAccessoryView = goToButton as UIView
      }
      return view
    }
    return nil
  }
 

  @objc func goToShop(button: UIButton){

    let shopVC = self.storyboard?.instantiateViewController(withIdentifier: "shopviewcontroller") as! ShopViewController

    shopVC.theShop = RentalShopManager.sharedInstance.rentalShops[0]
    self.show(shopVC, sender: nil)
  }
}

