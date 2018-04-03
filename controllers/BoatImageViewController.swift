//
//  BoatImageViewController.swift
//  RentMe
//
import UIKit

class BoatImageViewController: UIViewController {
  
  var theImage: UIImage!
  
  var pageIndex = 0
  
  @IBOutlet weak var boatImage: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    boatImage.image = theImage
    boatImage.contentMode = UIViewContentMode.scaleToFill
  }
  
}

