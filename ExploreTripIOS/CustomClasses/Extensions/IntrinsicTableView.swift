//
//  IntrinsicTableView.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/23/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit

class IntrinsicTableView: UITableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }

}
