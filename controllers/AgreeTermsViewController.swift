//
//  AgreeTermsViewController.swift
//  RentMe

import Foundation

import UIKit

class AgreeTermsViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel!
  
  @IBOutlet weak var agreeButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Term and Services"
    self.view.backgroundColor = grayColor
    agreeButton.backgroundColor = blueColor
    agreeButton.layer.cornerRadius = 100/6
    label.text = "US Coast Guard safety equipment & charts are included for free.\nThe renter must be at least 25 years of age with a valid driver’s license with boating and navigation experience and anyone born after January 1, 1988 must have a valid boaters safety card as required by law.\nThe renter is required to present a valid driver’s license and matching credit card (debit cards are accepted for payment but not for the $200.00 security deposit). We accept MasterCard, Visa or American Express.\nFuel & taxes are additional costs.\nOptional accessories available are water skis and/or tubes at $45.00/day each.\nBow riders and deck boats are equipped with a bimini top cover and center console boats have a T-Top cover.\nCancellation must be 24 hours before reservation."
    label.numberOfLines = 0
    label.sizeToFit()
    //termsTextView.fitToHeight()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func agreePressed(_ sender: UIButton) {
    
    let confirmVC = self.storyboard?.instantiateViewController(withIdentifier: "confirmationviewcontroller")
      as! ConfirmationViewController
    
    self.present(confirmVC, animated: true, completion: nil)
  }
 
}
