//
//  GimListService.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import Foundation
import Alamofire
import SwiftyJSON

class GimListService {
    static let shared = GimListService()
    
    func getAvailableListGim(completion: @escaping ([JSON]) -> ()) {
        let request: URLRequest = RESTConfig.shared.requestConfig(endpoint: RAWG_BASE_SERVER + "?key=\(RAWG_API_KEY)", method: RESTConfig.HTTPMethod.GET, parameters: nil)
        
        AF.request(request).response { response in
            switch response.result {
            case .success:
                let json = JSON(response.data!)
                let data = json["results"].array ?? []
                completion(data)
            case .failure:
                print(response.debugDescription)
            }
        }
    }
}
