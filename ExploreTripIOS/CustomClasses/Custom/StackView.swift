//
//  StackView.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/26/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import UIKit

class StackView: UIStackView {
    private var color: UIColor?
    override var backgroundColor: UIColor? {
        get { return color }
        set {
            color = newValue
            self.setNeedsLayout() // EDIT 2017-02-03 thank you @BruceLiu
        }
    }
    
    private lazy var backgroundLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        self.layer.insertSublayer(layer, at: 0)
        return layer
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.path = UIBezierPath(rect: self.bounds).cgPath
        backgroundLayer.fillColor = self.backgroundColor?.cgColor
    }
}
