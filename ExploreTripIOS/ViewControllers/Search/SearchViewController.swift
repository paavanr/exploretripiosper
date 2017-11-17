//
//  SearchViewController.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/9/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit
import SwiftyJSON

enum TextFiledsEnum:Int {
    case Origin = 0
    case Destination
    case Depart
    case Return
    case Traveller
}
enum TripType:Int {
    case RoundTrip = 0
    case OneWay
    case MultiCity
}
enum TravelDetails:Int {
    case Class = 0
    case Adults
    case Children
    case Infants
    static let mapper: [TravelDetails: String] = [
        .Class: "Class",
        .Adults: "Adults",
        .Children: "Children",
        .Infants:"Infants"
    ]
    var string: String {
        return TravelDetails.mapper[self]!
    }
    static var count: Int { return TravelDetails.Infants.hashValue + 1}
}
struct TravelDetailsStuct {
    var traveller:String = "E"
    var adults:Int = 1
    var children:Int = 0
    var infants:Int = 0
    var originDestinations = [OriginDestination]()
    
}

struct OriginDestination {
    var origin:String
    var destination:String
    var date:String
    var cabinClass:String
}

enum ClassDetails:Int {
    case Economy
    case Business
    case First
    case PremiumEconomy
    static let mapper: [ClassDetails: String] = [
        .Economy: "Economy",
        .Business: "Business",
        .First: "First",
        .PremiumEconomy:"Premium Economy"
    ]
    var string: String {
        return ClassDetails.mapper[self]!
    }
    
    static let shortCodes: [ClassDetails: String] = [
        .Economy: "E",
        .Business: "B",
        .First: "F",
        .PremiumEconomy:"P"
    ]
    var shortCode: String {
        return ClassDetails.shortCodes[self]!
    }
    static var count: Int { return ClassDetails.PremiumEconomy.hashValue + 1}
}

let NUMBER_OF_TRAVELLERS = 10
class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: IntrinsicTableView!
    @IBOutlet weak var returnTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var departTextField: UITextField!
    @IBOutlet weak var originTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var travellersTextField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var addFlightBarButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var addFlightButton: UIButton!
    @IBOutlet weak var transparantView: UIView!

    var locationsArray = [Location]()
    var flightsArray = [OriginDestination]()
    var showFlights = false{
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var selectedTextFieldType:TextFiledsEnum = .Origin
    var selectedTripType:TripType = .RoundTrip {
        didSet{
            DispatchQueue.main.async {
                switch self.selectedTripType {
                case .OneWay:
                    self.returnTextField.isHidden = true
                    self.addFlightButton.isHidden = true
                    self.tableView.isHidden = true
                    self.showFlights = false

                case .MultiCity:
                    self.returnTextField.isHidden = true
                    self.addFlightButton.isHidden = false
                    self.tableView.isHidden = false
                    self.showFlights = true
                    self.tableView.reloadData()
                    break
                default:
                    self.returnTextField.isHidden = false
                    self.addFlightButton.isHidden = true
                    self.tableView.isHidden = true
                    self.showFlights = false

                }
            }
        }
    }
    var travellerDetails:TravelDetailsStuct = TravelDetailsStuct()
    var numberOfCities:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.addNavigationView()
        // Do any additional setup after loading the view.
        let backgroundImage = UIImageView(frame: CGRect(x: self.view.bounds.origin.x, y: self.view.bounds.origin.y, width: self.view.bounds.size.width, height: self.view.bounds.size.height/1.8 ))
        backgroundImage.image = UIImage(named: "background.jpg")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        self.tableView.backgroundColor = UIColor.clear
        self.departTextField.text = Date().toString(dateFormat: Constants.dateFormat)
        self.returnTextField.text = Date().tomorrow.toString(dateFormat: Constants.dateFormat)
        self.setRightViewIcon(icon: UIImage(named:"down-arrow.png")! , textFiled: self.travellersTextField)
        
        self.transparantView.layer.cornerRadius = 4

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        self.flightsArray.removeAll()
    }
    override func viewDidAppear(_ animated: Bool) {
        let labelWidth = self.pickerView.frame.width / CGFloat(self.pickerView.numberOfComponents)
        for index in 0..<TravelDetails.count {
            let label: UILabel = UILabel.init(frame: CGRect(x:self.pickerView.frame.origin.x + labelWidth * CGFloat(index), y:5, width:labelWidth, height:20))
            label.text = TravelDetails(rawValue: index)?.string
            label.textColor = UIColor.blue
            label.textAlignment = .center
            self.pickerView.addSubview(label)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

    @IBAction func callnowButtonClick(_ sender: Any) {
        if let url = URL(string: "tel://1-866-855-3984") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }

    }
    @IBAction func menuButtonClick(_ sender: Any) {
        //self.slideMenuController()
    }
    
    @IBAction func originEditingChanged(_ sender: Any) {
        let textField = sender as! UITextField
        self.selectedTextFieldType = .Origin
        if let text = textField.text, textField.text != "" {
            if self.selectedTripType == .MultiCity{
                self.showFlights = false
            }else{
                self.tableView.isHidden = false
            }
            let params = ["keyText":text, "locale":"en-US"]
            self.processServiceRequest(request: RestAPIRouter.getLocations(params))
        }
    }
    
    @IBAction func addFlightButtonClick(_ sender: Any) {
        if self.flightsArray.count <= 6{
            guard let origin = self.originTextField.text else { return }
            guard let destination = self.destinationTextField.text else { return }
            guard let departDate = self.departTextField.text else { return }
            let originDestination = OriginDestination(origin: origin, destination: destination, date: departDate, cabinClass: self.travellerDetails.traveller)
            self.flightsArray.append(originDestination)
            self.showFlights = true
            self.clearValues()
        }else{
            self.present(message: "You have excceded maximum number of flight.")
        }
       
    }
    @IBAction func destinationEditingChanged(_ sender: Any) {
        self.selectedTextFieldType = .Destination
        let textField = sender as! UITextField
        if let text = textField.text, textField.text != "" {
            self.tableView.isHidden = false
            let params = ["keyText":text, "locale":"en-US"]
            self.processServiceRequest(request: RestAPIRouter.getLocations(params))
        }
    }
    @IBAction func searchButtonClick(_ sender: Any) {
        self.view.endEditing(true)
        guard let origin = self.originTextField.text else {
            self.present(message: "Please enter origin.")
            return
        }
        guard let destination = self.destinationTextField.text else {
            self.present(message: "Please enter destination.")
            return
        }
        guard let departDate = self.departTextField.text else {
            self.present(message: "Please select departure date.")
            return
        }
        guard let returnDate = self.returnTextField.text else { return }
        
        guard self.travellerDetails.adults > 0 || self.travellerDetails.children > 0 ||  self.travellerDetails.infants > 0 else {
            self.present(message: "Please choose traveller details.")
            return
        }
        
        if self.selectedTripType == .RoundTrip {
            guard let fromDate = Date.date(from: departDate,format: Constants.dateFormat), let toDate = Date.date(from: returnDate,format: Constants.dateFormat) else {
                self.present(message: "Please enter valid dates")
                return
            }
            if fromDate > toDate {
                self.present(message: "Return date must be greater than depart date")
                return
            }
        }
      
        
        var originDestinations = [[String:Any]]()
        switch self.selectedTripType {
        case .RoundTrip:
           
         
            originDestinations.append(["DepartureLocationCode":origin,"ArrivalLocationCode":destination,"DepartureTime":departDate,"CabinClass":self.travellerDetails.traveller])
            originDestinations.append(["DepartureLocationCode":destination,"ArrivalLocationCode":origin,"DepartureTime":returnDate,"CabinClass":self.travellerDetails.traveller])
            
            let departDetails = OriginDestination(origin: origin, destination: destination, date: departDate, cabinClass: self.travellerDetails.traveller)
            let returnDetails = OriginDestination(origin: destination, destination: origin, date: returnDate, cabinClass: self.travellerDetails.traveller)
            
            self.flightsArray.append(departDetails)
            self.flightsArray.append(returnDetails)

        case .OneWay:
            originDestinations.append(["DepartureLocationCode":origin,"ArrivalLocationCode":destination,"DepartureTime":departDate,"CabinClass":self.travellerDetails.traveller])
            
            let departDetails = OriginDestination(origin: origin, destination: destination, date: departDate, cabinClass: self.travellerDetails.traveller)
            
            self.flightsArray.append(departDetails)

        default:
            for flight in self.flightsArray {
                originDestinations.append((["DepartureLocationCode":flight.origin,"ArrivalLocationCode":flight.destination,"DepartureTime":flight.date,"CabinClass":flight.cabinClass]))
            }
            break
        }
        
        self.travellerDetails.originDestinations = self.flightsArray
        let params = [
            "OriginDestination":originDestinations,
            "PreferredAirlines":[],
            "PaxDetails":["NoOfAdults":["count":self.travellerDetails.adults],"NoOfChildren":["count":self.travellerDetails.children,"age":"10"],"NoOfInfants":["count":self.travellerDetails.infants,"age":"2"]],
            "CurrencyInfo":["CurrencyCode":"USD"],
            "OtherInfo":["RequestedIP":"209.58.193.250","TransactionId":"123456"],
            "Incremental":"true",
            "NearLocations":true,
            "FlexibleDates":true,
            "ExtremeSearchKey":"f458d94b-5e83-409e-b954-1efd9883220d"] as [String : Any]
        self.processServiceRequest(request: RestAPIRouter.searchFlights(params))
        
    }
    @IBAction func segmentValueChanged(_ sender: Any) {
        let segmentControl = sender as? UISegmentedControl
        self.selectedTripType = TripType(rawValue: (segmentControl?.selectedSegmentIndex) ?? 0) ?? .RoundTrip
    }
    @IBAction func dataPickerValueChanged(_ sender: Any) {
        switch self.selectedTextFieldType {
        case .Depart:
            self.departTextField.text = datePicker.date.toString(dateFormat: Constants.dateFormat)
            //self.returnTextField.text = datePicker.date.tomorrow.toString(dateFormat: Constants.dateFormat)
        default:
            self.returnTextField.text = datePicker.date.toString(dateFormat: Constants.dateFormat)
        }
    }
    func dropdownButtonClick(_ sender:Any){
        
    }
    func clearValues(){
        self.originTextField.text = ""
        self.destinationTextField.text = ""
        self.departTextField.text = Date().toString(dateFormat: Constants.dateFormat)
    }
    func setRightViewIcon(icon: UIImage, textFiled:UITextField) {
        let btnView = UIButton(frame: CGRect(x: 0, y: 0, width: ((textFiled.frame.height) * 0.70), height: ((textFiled.frame.height) * 0.70)))
        btnView.setImage(icon, for: .normal)
        btnView.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        btnView.addTarget(self, action:#selector(dropdownButtonClick) , for: .touchUpInside)
        textFiled.rightViewMode = .always
        textFiled.rightView = btnView
    }
    func processServiceRequest(request:RestAPIRouter){
        RestAPIController.startRequest(request:request){ serverResponse in
            guard serverResponse.error == nil else {
                return
            }
            guard let responseDictionary = serverResponse.json else { return }
            
            //Process locations response
            if let responseArray = responseDictionary["Airports"].array {
                self.locationsArray.removeAll()
                for dictionary in responseArray{
                    let object = Location(dictionary: dictionary)
                    self.locationsArray.append(object)
                }
                DispatchQueue.main.async {
                    if self.selectedTripType == .MultiCity {
                        self.showFlights = false
                    }else{
                        self.tableView.reloadData()
                    }
                }
            }
            
            //Process search flights response
            if let array = responseDictionary["FlightItinerary"].array {
                let tripDetails = TripDetails()
                tripDetails.pollInfo = PollInfo(dictionary: responseDictionary["PollInfo"])
                for value in array{
                    let newObject = FlightItinerary(dictionary: value)
                    tripDetails.flightItenaryArray.append(newObject)
                }
                
                //Navigate
                self.navigate(tripDetails)
            }
           
        }
    }
    
    func navigate(_ tripDetails:TripDetails){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ItineraryListViewController") as! ItineraryListViewController
        nextViewController.tripdetails = tripDetails
        nextViewController.searchDetails = self.travellerDetails
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.flightsArray.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.showFlights{
            return "Flights"
        }else{
            return "Locations"
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.showFlights{
            return self.flightsArray.count
        }else{
            return self.locationsArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if self.showFlights{
            cell.textLabel?.text = "Flight \(indexPath.row + 1):  \(self.flightsArray[indexPath.row].cabinClass)"
            cell.detailTextLabel?.text = self.flightsArray[indexPath.row].origin + " " + self.flightsArray[indexPath.row].destination + " " + self.flightsArray[indexPath.row].date
        }else{
            cell.textLabel?.text = self.locationsArray[indexPath.row].code
            cell.detailTextLabel?.text = self.locationsArray[indexPath.row].airportLocation
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = self.locationsArray[indexPath.row]
        switch self.selectedTextFieldType {
        case .Origin:
            self.originTextField.text = location.code
        case .Destination:
            self.destinationTextField.text = location.code
        default:
            self.originTextField.text = location.code
        }
        
        if self.selectedTripType == .MultiCity{
            self.showFlights = true
        }else{
            self.tableView.isHidden = true
        }
    }
}
extension SearchViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        case TravelDetails.Class.rawValue:
            return ClassDetails.count
        default:
            return NUMBER_OF_TRAVELLERS
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case TravelDetails.Class.rawValue:
            return ClassDetails(rawValue: row)?.string
        default:
            return "\(row)"
        }
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.travellerDetails.traveller = ClassDetails(rawValue: self.pickerView.selectedRow(inComponent: 0))?.shortCode ?? "n/a"
        self.travellerDetails.adults = self.pickerView.selectedRow(inComponent: 1)
        self.travellerDetails.children = self.pickerView.selectedRow(inComponent: 2)
        self.travellerDetails.infants = self.pickerView.selectedRow(inComponent: 3)

        self.travellersTextField.text = "\(self.travellerDetails.traveller) Adults:\(self.travellerDetails.adults) Children:\(self.travellerDetails.children) Infants:\(self.travellerDetails.infants)"
    }
}
extension SearchViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.departTextField {
            self.selectedTextFieldType = .Depart
            textField.inputView = self.datePicker
        }
        if textField == self.returnTextField {
            self.selectedTextFieldType = .Return
            textField.inputView = self.datePicker
        }
        if textField == self.travellersTextField{
            self.selectedTextFieldType = .Traveller
            textField.inputView = self.pickerView
        }
    }
}
