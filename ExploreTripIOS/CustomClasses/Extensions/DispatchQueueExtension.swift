//
//  DispatchQueueExtension.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 11/1/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
}
