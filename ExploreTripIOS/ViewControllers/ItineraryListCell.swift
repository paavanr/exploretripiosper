//
//  ItineraryListCell.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/10/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ItineraryListCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var flightNameLabel: UILabel!
    @IBOutlet weak var returnDurationLabel: UILabel!
    @IBOutlet weak var returnDestinationLabel: UILabel!
    @IBOutlet weak var returnOriginLabel: UILabel!
    @IBOutlet weak var departDurationLabel: UILabel!
    @IBOutlet weak var departDestinationLabel: UILabel!
    @IBOutlet weak var departOriginLabel: UILabel!
    @IBOutlet weak var totalFareLabel: UILabel!
    @IBOutlet weak var seatsLabel: UILabel!
    @IBOutlet weak var totalFareButton: UIButton!
    @IBOutlet weak var departOriginDateLabel: UILabel!
    @IBOutlet weak var returnOriginDateLable: UILabel!
    @IBOutlet weak var departDestinationDateLabel: UILabel!
    @IBOutlet weak var returnDestinationDateLabel: UILabel!
    @IBOutlet weak var returnDepartDateLabel: UILabel!
    @IBOutlet weak var originDestinationDateLabel: UILabel!
    @IBOutlet weak var originDepartDateLabel: UILabel!
    
    var item: FlightItinerary? = nil {
        didSet {
            let cityPairs = item?.cityPairs
            
            //Add values in the background and assign to label
            self.totalFareButton.setTitle("  " + (self.item?.fares.first?.currencyCode  ?? "USD") + " $\(self.item?.totalFare ?? 0.0)  ", for: .normal)
        
            
            self.totalFareButton.layer.cornerRadius = 4
            self.totalFareButton.clipsToBounds = true
            self.seatsLabel.text = "\((self.item?.noOfSeats)!) seat(s) left"
            
            let firstCity = cityPairs?.first
            let firstCityFirstSegment = firstCity?.flightSegmentsArray.first
            let firstCityLastSegment = firstCity?.flightSegmentsArray.last
    
            let secondCity = cityPairs?.last
            let secondCityFirstSegment = secondCity?.flightSegmentsArray.first
            let secondCityLastSegment = secondCity?.flightSegmentsArray.last
            
            var departOriginExtractedTime:String = "n/a"
            var departOriginExtractedDate:String = "n/a"
            //Convert in  the back ground and assign to label
            DispatchQueue.background(background: {
                departOriginExtractedTime = Date.extractedTime(date: (firstCityFirstSegment?.departureDateTime) ?? "n/a")
                departOriginExtractedDate = Date.extractedDate(date: (firstCityFirstSegment?.departureDateTime) ?? "n/a")
            }, completion:{
                self.departOriginLabel.text = ((firstCityFirstSegment?.departureLocationCode) ?? "n/a") + " | " + departOriginExtractedTime
                self.departOriginDateLabel.text = departOriginExtractedDate
            })
            
            var departDestinationExtractedTime:String = "n/a"
            var departDestinationExtractedDate:String = "n/a"

            DispatchQueue.background(background: {
                departDestinationExtractedTime = Date.extractedTime(date: (firstCityLastSegment?.departureDateTime) ?? "n/a")
                 departDestinationExtractedDate = Date.extractedDate(date: (firstCityLastSegment?.departureDateTime) ?? "n/a")
            }, completion:{
                 self.departDestinationLabel.text = ((firstCityLastSegment?.departureLocationCode) ?? "n/a") + " | " + departDestinationExtractedTime
                self.departDestinationDateLabel.text = departDestinationExtractedDate
            })
            
            
            var returnOriginExtractedTime:String = "n/a"
            var returnOriginExtractedDate:String = "n/a"

            //Convert in  the back ground and assign to label
            DispatchQueue.background(background: {
                returnOriginExtractedTime = Date.extractedTime(date: (secondCityFirstSegment?.departureDateTime) ?? "n/a")
                returnOriginExtractedDate = Date.extractedDate(date: (secondCityFirstSegment?.departureDateTime) ?? "n/a")
            }, completion:{
                self.returnOriginLabel.text = ((secondCityFirstSegment?.departureLocationCode) ?? "n/a") + " | " + returnOriginExtractedTime
                self.returnOriginDateLable.text = returnOriginExtractedDate
            })
            
            var returnDestinationExtractedTime:String = "n/a"
            var returnDestinationExtractedDate:String = "n/a"

            DispatchQueue.background(background: {
                returnDestinationExtractedTime = Date.extractedTime(date: (secondCityLastSegment?.departureDateTime) ?? "n/a")
                 returnDestinationExtractedDate = Date.extractedDate(date: (secondCityLastSegment?.departureDateTime) ?? "n/a")
            }, completion:{
                self.returnDestinationLabel.text = ((secondCityLastSegment?.departureLocationCode) ?? "n/a") + " | " + returnDestinationExtractedTime
                self.returnDestinationDateLabel.text = returnDestinationExtractedDate
            })
          

            self.departDestinationLabel.text = firstCityLastSegment?.arrivalLocationCode
            self.departDurationLabel.text = firstCity?.duration
            self.flightNameLabel.text = firstCityLastSegment?.operatingAirlineName

           self.returnOriginLabel.text = secondCityFirstSegment?.departureLocationCode
            self.returnDestinationLabel.text = secondCityLastSegment?.arrivalLocationCode
            self.returnDurationLabel.text = secondCity?.duration
            
            self.logoImageView.sd_setImage(with: URL(string:(self.item?.flightLogoURL!)!), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
