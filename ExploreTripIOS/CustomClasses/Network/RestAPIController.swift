//
//  RestAPIController.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/9/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import EZLoadingActivity

internal var CurrentBaseUrl: URL = RestAPIController.defaultBaseUrl

class RestAPIController {
    public static let sharedInstance = RestAPIController()
    public static let defaultBaseUrl = URL(string: "https://www.exploretrip.com/")!
    public var baseUrl: URL {
        get {
            return CurrentBaseUrl
        }
        set {
            CurrentBaseUrl = newValue
            
            // Perform notificaiton
            let note = NotificationCenter.default
            let meta : [String:Any] = [
                RestAPIController.NotificationMetaKey.url.rawValue : CurrentBaseUrl
            ]
            note.post(name: .serviceUrlDidChange,
                      object: self,
                      userInfo: meta)
        }
    }
    //Private properties
    fileprivate var af: Alamofire.SessionManager
    fileprivate var opQueue: OperationQueue
    fileprivate var bgOpQueue: OperationQueue
    
    public init() {
        let config = URLSessionConfiguration.default
        self.af = Alamofire.SessionManager(configuration: config)
        self.opQueue = OperationQueue()
        self.opQueue.name = "RCKService OpQ"
        
        
        //Add any default background operations
        self.bgOpQueue = OperationQueue()
        self.bgOpQueue.name = "RCKService BgOpQ"
        
    }
    
    /// Execute a network request with thes erver
    ///
    /// - Parameter request; URLRequset to make
    /// - Parameter completion: a completion block containing the rseponse data, JSON data (on success) and any error codes.  This completion block wil run on runQueue, the same DispatchQueue that the state machine execute son.
    class func startRequest(request:RestAPIRouter, completion: @escaping (_ response: ServerResponse)->Void = { _ in }) {
        
        EZLoadingActivity.show("Please wait", disableUI: true)
        let af = RestAPIController.sharedInstance.af
        
        //print("Server Request: \(method) \(url)")
        af.request(request)
            .validate(statusCode: 200..<600)
            .validate(contentType: ["application/json","text/plain"])
            .responseJSON { response in
                let serverResponse: ServerResponse
                
                switch response.result {
                case .success(let value ):
                    serverResponse = ServerResponse(json: JSON(value),
                                                    error: nil,
                                                    response: response)
                case .failure(let error):
                    serverResponse = ServerResponse(json: nil,
                                                    error: error,
                                                    response: response)
                    
                    let body: String
                    if let data = response.data {
                        body = String(data: data, encoding: .utf8)!
                    } else {
                        body = "(no body)"
                    }
                    print("Server ERROR: \(error.localizedDescription)\n\(body)\n")
                }
                
                EZLoadingActivity.hide()
                completion(serverResponse)
        }
    }
    
}
public struct ServerResponse {
    let json: JSON?
    let error: Error?
    let response: DataResponse<Any>
}
public enum ServerError: Error {
    case generalError(String)
}

// MARK: Notification Events
extension RestAPIController {
    enum NotificationMetaKey : String {
        case url
    }
}
extension Notification.Name {
    static let serviceUrlDidChange = Notification.Name("service.url.didChange")
}


