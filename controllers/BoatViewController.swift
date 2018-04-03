//
//  BoatViewController.swift
//  RentMe
//


import UIKit

class BoatViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
  

  var theRental: Rental!
  
  @IBOutlet weak var boatNameLabel: UILabel!
  
  @IBOutlet weak var priceLabel: UILabel!
  
  @IBOutlet weak var descriptionTextView: UITextView!
  
  @IBOutlet weak var rentButton: UIButton!
  
  var imageViewController: BoatImageViewController!
  
  var pageVC: UIPageViewController!
  
  @IBAction func rentPressed(_ sender: UIButton) {
    
    let termsVC = self.storyboard?.instantiateViewController(withIdentifier: "agreetermsviewcontroller") as! AgreeTermsViewController
    
    self.show(termsVC, sender: nil)
  }
 
  override func viewDidLoad() {
    super.viewDidLoad()
    setupPages()
    
    self.view.backgroundColor = grayColor
    descriptionTextView.backgroundColor = grayColor
    
    title = theRental.name
    rentButton.backgroundColor = blueColor
    rentButton.layer.cornerRadius = rentButton.frame.height/6
    
    //boatImage.image = theRental.pictures.last! as UIImage
    boatNameLabel.text = theRental.name
    priceLabel.text = "$\(theRental.price)/day"
    
    descriptionTextView.isEditable = false
    
    descriptionTextView.text = "Feature: 13' fiber glass hull. Six Passenger capacity. Dual 250 HP outboard motos. Can tow 3 water skiiers and 2 boats at the same time. Sun Shade. Big american flag included."
    
  }
  
  
  func setupPages() {
    pageVC = UIPageViewController(
      transitionStyle: .scroll,
      navigationOrientation: .horizontal,
      options: nil)
    
    pageVC.view.frame = CGRect(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height/3 + 50)
    
    pageVC.delegate = self
    pageVC.dataSource = self
    
    let startVC = self.viewControllerAtIndex(index: 0) as UIViewController
    let allViewControllers = [startVC]
    
    self.pageVC.setViewControllers(allViewControllers, direction: .forward, animated: true, completion: nil)
    
    addChildViewController(pageVC!)
    self.view.addSubview(pageVC!.view)
    pageVC.didMove(toParentViewController: self)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! BoatImageViewController
        var index = vc.pageIndex
    
        if index == 0 || index == NSNotFound {
          return nil
        }
    
        index-=1
    return self.viewControllerAtIndex(index: index)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    let vc = viewController as! BoatImageViewController
        var index = vc.pageIndex
        if (index == NSNotFound){
          return nil
        }
    
        index+=1
        if (index == self.theRental.pictures.count){
          return nil
        }
    return self.viewControllerAtIndex(index: index)
  }
  
  
  func viewControllerAtIndex(index:Int) -> BoatImageViewController {
    if ((self.theRental.pictures.count == 0 ) || (index >= self.theRental.pictures.count)){
      return BoatImageViewController() //suppose to return nil here
    }
    imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "boatimageviewcontroller") as! BoatImageViewController
    
    imageViewController.pageIndex = index
    imageViewController.theImage = theRental.pictures[index]
    return imageViewController
  }

  
}

