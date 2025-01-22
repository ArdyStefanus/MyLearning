//
//  DetailGimListService.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import Foundation
import Alamofire
import SwiftyJSON

class DetailGimService{
    static let shared = DetailGimService()
    
    func getDetailGim(idGame: Int, completion: @escaping (JSON, String) -> ()){
        let request: URLRequest = RESTConfig.shared.requestConfig(endpoint: RAWG_BASE_SERVER + "/\(idGame)" + "?key=\(RAWG_API_KEY)", method: RESTConfig.HTTPMethod.GET, parameters: nil)
        
        AF.request(request).response {response in
            switch response.result{
            case .success:
                let json = JSON(response.data!)
                let status = json["slug"].string ?? ""
                completion(json, status)
            case .failure:
                print(response.debugDescription)
            }
        }
    }
}
