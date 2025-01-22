//
//  DetailGimListVM.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import Foundation

class DetailGimVM {
    let detailGimService = DetailGimService.shared
    var detailGameRawg: ListGameRawg!
    
    var idListGame: Int = 0
    var coreIdGame: [Int] = []
    var isAlreadyFavorite: Bool = false
    
    func getDetailGame(completion: @escaping (String) -> ()) {
        detailGimService.getDetailGim(idGame: idListGame) { [weak self] (data, status) in
            self?.detailGameRawg = (ListGameRawg.init(data: data))
            completion(status)
        }
    }
}
