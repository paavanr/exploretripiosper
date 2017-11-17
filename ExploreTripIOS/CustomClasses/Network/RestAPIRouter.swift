//
//  RestAPIRouter.swift
//  Exploretrip_task
//
//  Created by Mashesh Somineni on 10/9/17.
//  Copyright © 2017 collection.gap. All rights reserved.
//

import Foundation
import Alamofire

public enum RestAPIRouter: URLRequestConvertible {
    case searchFlights([String:Any])
    case getLocations([String:Any])
    case userLogin([String:Any])
    case userSignUp([String:Any])

    var method: HTTPMethod {
        switch self {
        case .searchFlights(_):     return .post
        case .getLocations(_):     return .get
        case .userLogin(_):         return .post
        case .userSignUp(_):         return .post
        }
    }
    var path: String {
        switch self {
        case .searchFlights(_):
            return "adapter/v2/Flights/search"
        case .getLocations(_):
            return "resources/v1/Context/locations"
        case .userLogin(_):
            return "adapter/v2/User/login"
        case .userSignUp(_):
            return "adapter/v2/User/signUp"
        }
    }
    public func asURLRequest() throws -> URLRequest {
        let url = RestAPIController.sharedInstance.baseUrl.appendingPathComponent(self.path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = self.method.rawValue
        //let emptyParams: [String:Any] = [:]

        switch self {
        case .searchFlights(let params):
        urlRequest.setValue("RjExQ0E4NzgtMDMxRC00OTYxLUFBRTMtQzMwNzFDRkY1RERBO251bGw7MTUwNzA1NzM2NTc1OQ", forHTTPHeaderField: "AccessToken")
            urlRequest.setValue("123455", forHTTPHeaderField: "DeviceUUID")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with:params)
        case .getLocations(let params):
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
        case .userLogin(let params):
            urlRequest.setValue("RjExQ0E4NzgtMDMxRC00OTYxLUFBRTMtQzMwNzFDRkY1RERBO251bGw7MTUwNzA1NzM2NTc1OQ", forHTTPHeaderField: "AccessToken")
            urlRequest.setValue("123455", forHTTPHeaderField: "DeviceUUID")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with:params)
        case .userSignUp(let params):
            urlRequest.setValue("RjExQ0E4NzgtMDMxRC00OTYxLUFBRTMtQzMwNzFDRkY1RERBO251bGw7MTUwNzA1NzM2NTc1OQ", forHTTPHeaderField: "AccessToken")
            urlRequest.setValue("123455", forHTTPHeaderField: "DeviceUUID")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with:params)
        }
        return urlRequest
    }
}
