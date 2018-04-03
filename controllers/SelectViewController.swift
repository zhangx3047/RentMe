

import Foundation

import PDTSimpleCalendar

let blueColor = UIColor(red: 0.259, green: 0.345, blue: 0.498, alpha: 1) /* #42587f */
let grayColor = UIColor(red: 0.937, green: 0.937, blue: 0.957, alpha: 1) /* #efeff4 */

class SelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UISearchResultsUpdating, PDTSimpleCalendarViewDelegate {
  
 
  @IBOutlet weak var scrollView: UIScrollView!
  
  @IBAction func goToUser(sender: UIBarButtonItem) {
//    let userVC = self.storyboard?.instantiateViewControllerWithIdentifier("userviewcontroller") as! UserViewController
//    self.presentViewController(userVC, animated: true, completion: nil)
  }
  
  var whatPrompt: UILabel!
  var locationTable = UITableView()
  var leftButtons = [UIButton]()
  var rightButtons = [UIButton]()
  
  var leftPressed = false
  var rightPressed = false
  
  var leftVehicleNames = ["yacht", "surfboard", "snowmobile", "skiboat", "sailboat", "RV"]
  var rightVehicleNames = ["pontoon", "paddleboat", "kayak", "jetski", "canoe", "ATV"]
  
  var calendarViewController: PDTSimpleCalendarViewController!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
  }
  
  let buttonDimension: CGFloat = 150
  var informationWrapper = UIView()
  var promptLabels = [UILabel]()
  var informationButtons = [UIButton]()
  var placeHolderTexts = ["Vehicle:","Location:","Time:"]
  
  func setUpViews(){
    informationWrapper = UIView(frame: CGRect(x: 0, y: self.view.frame.height-60, width: self.view.frame.width, height: 60))
    informationWrapper.backgroundColor = blueColor
    
    self.view.addSubview(informationWrapper)
    
    var centers = [self.view.frame.width/3-50, self.view.center.x, self.view.frame.width/3*2+50]
    
    for i in 0..<3 {
      let label = UILabel(frame: CGRect(x: 0, y: 5, width: 100, height: 20))
      
      label.font = UIFont.systemFont(ofSize: 12)
      label.text = placeHolderTexts[i]
      
      label.sizeToFit()
      label.center.x = centers[i]
      label.textAlignment = .center
      label.textColor = UIColor.white
      promptLabels.append(label)
      informationWrapper.addSubview(label)
      
      let informationButton = UIButton(frame: CGRect(x: 0, y: 20, width: self.view.frame.width/3, height: 25))
      informationButton.center.x = centers[i]
      informationButton.tag = i
      informationButton.setTitleColor(UIColor.white, for: UIControlState.normal)
    
      informationButtons.append(informationButton)
      informationWrapper.addSubview(informationButton)
    }
    
    whatPrompt = UILabel(frame: CGRect(x: 15, y: 20, width: 250, height: 20))
    whatPrompt.text = "What do you want to rent?"
    whatPrompt.font = UIFont.systemFont(ofSize: 20)
    whatPrompt.sizeToFit()
    whatPrompt.textColor = blueColor
    whatPrompt.center.x = self.view.center.x
    self.scrollView.addSubview(whatPrompt)
    let margin: CGFloat = 20
    for i in 0..<6 {
      
      
      let leftButton = UIButton(frame: CGRect(x: 20, y: whatPrompt.frame.maxY+20+CGFloat(i)*(buttonDimension+margin), width: buttonDimension, height: buttonDimension))
      leftButton.setTitle("\(i) button", for: .normal)
      leftButton.setImage(UIImage(named: leftVehicleNames[i]), for: .normal)
      leftButton.tag = i
      leftButton.addTarget(self, action: #selector(self.leftButtonPressed(button:)), for: .touchUpInside)
      
      let vehicleNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
      vehicleNameLabel.textColor = UIColor.white
      vehicleNameLabel.font = UIFont.systemFont(ofSize: 20)
      vehicleNameLabel.center = CGPoint(x: buttonDimension/2, y: buttonDimension/2)
      vehicleNameLabel.textAlignment = .center
      vehicleNameLabel.text = leftVehicleNames[i]
      leftButton.addSubview(vehicleNameLabel)
      leftButtons.append(leftButton)
      scrollView.addSubview(leftButton)
      
      let rightButton = UIButton(frame: CGRect(x: self.view.center.x+20, y: whatPrompt.frame.maxY+20+CGFloat(i)*(buttonDimension+margin), width: buttonDimension, height: buttonDimension))
      rightButton.setTitle("\(i) button", for: .normal)
      rightButton.tag = i
      
      let vehicleNameLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 20))
      vehicleNameLabel2.font = UIFont.systemFont(ofSize: 20)
      vehicleNameLabel2.textColor = UIColor.white
      vehicleNameLabel2.center = CGPoint(x: buttonDimension/2, y: buttonDimension/2)
      vehicleNameLabel2.text = rightVehicleNames[i]
      vehicleNameLabel2.textAlignment = .center
      rightButton.addSubview(vehicleNameLabel2)
      
      rightButton.addTarget(self, action: #selector(self.rightButtonPressed(button:)), for: .touchUpInside)
      
      rightButton.setImage(UIImage(named: rightVehicleNames[i]), for: .normal)
      rightButton.layer.cornerRadius = rightButton.frame.height/10
      rightButtons.append(rightButton)
      scrollView.addSubview(rightButton)
    }
    
    // set up table view
    locationTable = UITableView(frame: CGRect(x: 0, y: rightButtons[rightButtons.count-1].frame.maxY, width: self.view.frame.width, height: self.view.frame.height))
    locationTable.delegate = self
    locationTable.dataSource = self
    locationTable.backgroundColor = grayColor
    locationTable.isScrollEnabled = false
    locationTable.tableFooterView = UIView()//hide separator
    locationTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    setUpSearchBar()
    self.scrollView.addSubview(locationTable)
    
    //MARK: calendar part
    whenLabel = UILabel(frame: CGRect(x:15, y: locationTable.frame.maxY+10, width: self.view.frame.width, height: 20))
    whenLabel.text = "When do you want to reserve it?"
    
    whenLabel.font = UIFont.systemFont(ofSize: 20)
    whenLabel.textColor = blueColor
    whenLabel.sizeToFit()
    whenLabel.center.x = self.view.center.x
    
    scrollView.addSubview(whenLabel)
    
    calendarViewController = PDTSimpleCalendarViewController()
    calendarViewController.delegate = self
    calendarViewController.view.backgroundColor = UIColor.yellow
    self.addChildViewController(calendarViewController)
    
    calendarViewController.view.frame = CGRect(x: 0, y: whenLabel.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
  
    scrollView.addSubview(calendarViewController.view)
    calendarViewController.didMove(toParentViewController: self)
    
    scrollView.contentSize.height = calendarViewController.view.frame.maxY + 800
  }
  
  var whenLabel: UILabel!
  
  var resultSearchController: UISearchController!
  
  func setUpSearchBar() {
    resultSearchController = UISearchController(searchResultsController: nil)
    resultSearchController.searchResultsUpdater = self
    resultSearchController.dimsBackgroundDuringPresentation = false
    
    let searchBar = self.resultSearchController.searchBar
    searchBar.sizeToFit()
    searchBar.backgroundImage = UIImage()
    searchBar.barTintColor = blueColor
    searchBar.placeholder = "Where are you going?"
    resultSearchController.hidesNavigationBarDuringPresentation = false
    searchBar.searchBarStyle = UISearchBarStyle.minimal
    definesPresentationContext = true
    locationTable.tableHeaderView = searchBar
    
  }
  
  
  func updateSearchResults(for searchController: UISearchController) {
    let searchText = searchController.searchBar.text?.lowercased() as! String
    
    self.filteredLocations = self.allLocations.filter{
            (location: String) -> Bool in
      
            let stringMatch = location.lowercased().range(of: searchText)
            return (stringMatch != nil)
          }
    
    locationTable.reloadData()
  }
  
  
//  func updateSearchResultsForSearchController(searchController: UISearchController) {
//    let searchText = searchController.searchBar.text?.lowercased()
//
//      searchController.searchBar.text!.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "", options: .LiteralSearch, range: nil)
    
//
//
//  }
  
  var allLocations = ["Duluth, MN", "Minenapolis, MN", "Saint Paul, MN", "Minnetonka, MN", "Detroit Lakes, MN","Apple Valley, MN","Rochester, MN","Bloomington, MN", "Brooklyn Park, MN", "St. Butt, MN", "Mankato, MN","Woodbury, MN", "Eagan, MN", "Eden Prairie, MN", "Blaine, MN", "Lakeville, MN", "St Louis. Park, MN", "Burnsville, MN", "Coon rapids, MN", "MapleWood, MN", "Shakopee, MN", "Cottage Grove, MN", "Roseville, MN", "Inver Grove Heights, MN", "Andover, MN", "Wiona, MN", "Savage, MN", "Oakdale, MN", "Richfield, MN", "Ramsey, MN", "White Bear Lake, MN"]
  
  var filteredLocations = [String]()
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredLocations.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
    cell.textLabel?.text = filteredLocations[indexPath.row]
    return cell
  }

  var theChosenLocation = ""
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    theChosenLocation = ""
    theChosenLocation = filteredLocations[indexPath.row]
    informationButtons[1].setTitle("", for: .normal)
    UIView.animate(withDuration: 0.5, animations: {
      self.scrollView.contentOffset = CGPoint(x: 0, y: self.whenLabel.frame.origin.y-64)
    })
    if resultSearchController.isActive {
      resultSearchController.isActive = false
    }
    informationButtons[1].setTitle(theChosenLocation, for: .normal)
    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
  }
 

  
  @objc func leftButtonPressed(button: UIButton) {
    
    if leftPressed {
      for view in leftButtons[button.tag].subviews {
        if view.tag == button.tag + 50 {
          view.removeFromSuperview()
        }
      }
      informationButtons[0].setTitle("", for: .normal)
      leftPressed = false
    } else { // not pressed
      
      let image = UIImageView(frame: CGRect(x: 0, y: 0, width: buttonDimension, height: buttonDimension))
      image.image = UIImage(named: "selection")
      image.tag = button.tag + 50
      
      leftButtons[button.tag].addSubview(image)
      leftPressed = true
      informationButtons[0].setTitle(leftVehicleNames[button.tag], for: .normal)
      UIView.animate(withDuration: 0.5, animations: {
        self.scrollView.contentOffset = CGPoint(x: 0, y: self.locationTable.frame.origin.y-64)
      })
    }
  }
  
  @objc func rightButtonPressed(button: UIButton) {
    if rightPressed {
      for view in rightButtons[button.tag].subviews {
        if view.tag == button.tag + 50 {
          view.removeFromSuperview()
        }
      }
      informationButtons[0].setTitle("", for: .normal)
      rightPressed = false
    } else {
      let image = UIImageView(frame: CGRect(x: 0, y: 0, width: buttonDimension, height: buttonDimension))
      image.image = UIImage(named: "selection")
      image.tag = button.tag + 50
      
      rightButtons[button.tag].addSubview(image)
      rightPressed = true
      informationButtons[0].setTitle(rightVehicleNames[button.tag], for: .normal)
      UIView.animate(withDuration: 0.5, animations: {
        self.scrollView.contentOffset = CGPoint(x: 0, y: self.locationTable.frame.origin.y-64)
      })
    }
  }
  
  //MARK: Calendar delegate
  func simpleCalendarViewController(_ controller: PDTSimpleCalendarViewController!, didSelect date: Date!) {
        informationButtons[2].setTitle("", for: .normal)
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = outputFormatter.string(from: date as Date as Date)
    
        print(selectedDate)
        informationButtons[2].setTitle(selectedDate, for: .normal)
    
    let mapVC = self.storyboard?.instantiateViewController(withIdentifier: "mapviewcontroller")
    as! MapViewController
    
    self.show(mapVC, sender: nil)
  }
}
