//
//  ConfirmationViewController.swift
//  RentMe
//

import Foundation

import UIKit
import EventKit

class ConfirmationViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = grayColor
    saveToCalendarButton.backgroundColor = blueColor
    saveToCalendarButton.layer.cornerRadius = 100/6
  }
  
  @IBOutlet weak var saveToCalendarButton: UIButton!
  
  @IBAction func savePressed(_ sender: UIButton) {
    let selectVC = self.storyboard?.instantiateViewController(withIdentifier: "selectviewcontroller") as!
    SelectViewController
    
    let navigationController = UINavigationController(rootViewController: selectVC)
    
    self.present(navigationController, animated: false, completion: nil)
  }
 
}
