//
//  TabGimListVM.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import Foundation

class TabGimListVM {
    let listGimService = GimListService.shared
    var loading: Observable<Bool> = Observable(false)
    var arrListGameRawg: Observable<[ListGameRawg]> = Observable([])
    
    func getAvailableGameList() {
        self.loading.value = true
        listGimService.getAvailableListGim { [weak self] (data) in
            self?.arrListGameRawg.value = []
            for i in 0 ..< data.count {
                self?.arrListGameRawg.value.append(ListGameRawg.init(data: data[i]))
            }
            self?.loading.value = false
        }
    }
}
