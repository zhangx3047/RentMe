//
//  ViewController.swift
//  RentMe

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var scrollViewWrapper: UIScrollView!
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBAction func signInPressed(_ sender: UIButton) {
    
    let selectVC = self.storyboard?.instantiateViewController(withIdentifier: "selectviewcontroller") as! SelectViewController
    let navigationController = UINavigationController(rootViewController: selectVC)
    
    self.present(navigationController, animated: true, completion: nil)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    passwordTextField.isSecureTextEntry = true
    
  }
  

}

