//
//  ItineraryListViewController.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/10/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit

enum SortingEnum:Int{
    case price = 0
    case departure
    case duration
}
class ItineraryListViewController: UITableViewController {
    @IBOutlet weak var placesLabel: UILabel!
    @IBOutlet weak var passengersLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    var tripdetails:TripDetails!
    var searchDetails:TravelDetailsStuct?
    
    var sortingType:SortingEnum = .price {
        didSet {
            DispatchQueue.background(background: {
                switch self.sortingType {
                case .departure:
                    self.tripdetails.flightItenaryArray = self.tripdetails.flightItenaryArray.sorted{$0.departureDateTime ?? Date() < $1.departureDateTime ?? Date()}
                    break
                case .duration:
                    self.tripdetails.flightItenaryArray = self.tripdetails.flightItenaryArray.sorted{ $0.totalDuration < $1.totalDuration }
                    break
                default:
                    self.tripdetails.flightItenaryArray = self.tripdetails.flightItenaryArray.sorted{ $0.totalFare < $1.totalFare }
                }
            }, completion:{
                self.tableView.reloadData()
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.addNavigationView()
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl?.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        

        guard let details = self.searchDetails else {
            return
        }
        
        if details.originDestinations.count == 1{
             self.placesLabel.text = (details.originDestinations.first?.origin ?? "n/a") + " - " + (details.originDestinations.first?.destination ?? "n/a")
        }else{
             self.placesLabel.text = (details.originDestinations.first?.origin ?? "n/a") + " - " + (details.originDestinations.last?.origin ?? "n/a")
        }
       
        
        let departDate = Date.convertDateFormatter(date: (details.originDestinations.first?.date ?? "n/a"), currentFormat: Constants.dateFormat, newFormat: Constants.dateMonthFormat)
        
        let returnDate = Date.convertDateFormatter(date: (details.originDestinations.last?.date ?? "n/a"), currentFormat: Constants.dateFormat, newFormat: Constants.dateMonthFormat)
        self.datesLabel.text = departDate + " - " + returnDate 
        self.passengersLabel.text = "\(details.adults + details.infants + details.children) Passenger(s)"

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func refreshControlValueChanged(_sender: Any) {
        
        var originDestinations = [[String:Any]]()
        for flight in (self.searchDetails?.originDestinations)! {
            originDestinations.append((["DepartureLocationCode":flight.origin,"ArrivalLocationCode":flight.destination,"DepartureTime":flight.date,"CabinClass":flight.cabinClass]))
        }
        let params = [
            "OriginDestination":originDestinations,
            "PreferredAirlines":[],
            "PaxDetails":["NoOfAdults":["count":self.searchDetails?.adults as Any],"NoOfChildren":["count":self.searchDetails?.children as Any,"age":"10"],"NoOfInfants":["count":self.searchDetails?.infants as Any,"age":"2"]],
            "CurrencyInfo":["CurrencyCode":"USD"],
            "OtherInfo":["RequestedIP":"209.58.193.250","TransactionId":"123456"],
            "Incremental":"true",
            "NearLocations":true,
            "FlexibleDates":true,
            "ExtremeSearchKey":"f458d94b-5e83-409e-b954-1efd9883220d"] as [String : Any]
        self.processServiceRequest(request: RestAPIRouter.searchFlights(params))
        
        
    }
    @IBAction func modifyButtonClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func filterButtonClick(_ sender: Any) {
    }
    
    @IBAction func durationButtonClick(_ sender: Any) {
        self.sortingType = .duration
    }
    @IBAction func departureButtonClick(_ sender: Any) {
        self.sortingType = .departure
    }
    @IBAction func priceButtonClick(_ sender: Any) {
        self.sortingType = .price
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tripdetails.flightItenaryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryListCell", for: indexPath) as! ItineraryListCell

        // Configure the cell...
        cell.item = self.tripdetails.flightItenaryArray[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func processServiceRequest(request:RestAPIRouter){
        RestAPIController.startRequest(request:request){ serverResponse in
            guard serverResponse.error == nil else {
                return
            }
            guard let responseDictionary = serverResponse.json else { return }
            
            //Process search flights response
            if let array = responseDictionary["FlightItinerary"].array {
                let object = TripDetails()
                object.pollInfo = PollInfo(dictionary: responseDictionary["PollInfo"])
                for value in array{
                    let newObject = FlightItinerary(dictionary: value)
                    object.flightItenaryArray.append(newObject)
                }
                
                //Navigate
                self.tripdetails = object
                self.sortingType = .price
                
                DispatchQueue.main.async {
                    if self.refreshControl != nil {
                        self.refreshControl?.endRefreshing()
                    }
                }
            }
            
        }
    }
}
