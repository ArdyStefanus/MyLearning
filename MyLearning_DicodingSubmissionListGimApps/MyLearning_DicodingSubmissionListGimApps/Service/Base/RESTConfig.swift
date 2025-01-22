//
//  RESTConfig.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: -DONT CHANGE

struct RESTConfig{
    static let shared = RESTConfig()
    
    enum HTTPMethod: String {
        case POST = "POST"
        case GET = "GET"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    func requestConfig(endpoint: String, method: HTTPMethod, parameters: [String:Any]?) -> URLRequest {
        var request = URLRequest(url: NSURL.init(string: endpoint)! as URL)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        if parameters != nil {
            request.httpBody = try! JSONSerialization.data(withJSONObject: parameters!, options: [])
        }
        
        return request
    }
}
