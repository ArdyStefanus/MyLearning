//
//  DetailFavoritGimVC.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import UIKit

class DetailFavoritVC: UIViewController {
    
    @IBOutlet weak var imageViewGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var releaseDateGame: UILabel!
    @IBOutlet weak var ratingGame: UILabel!
    @IBOutlet weak var descriptionGame: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let vm = DetailGimVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailGame()
    }
    
    func getDetailGame(){
        self.loadingIndicator.startAnimating()
        vm.getDetailGame() { (status) in
            if status != "" {
                self.setupData()
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func setupData(){
        let url = URL.init(string: vm.detailGameRawg.backgroundImage)
        imageViewGame.sd_setImage(with: url, placeholderImage: UIImage(contentsOfFile: "empty"))
        
        nameGame.text = vm.detailGameRawg.name
        releaseDateGame.text = "Released Date: \(vm.detailGameRawg.released)"
        ratingGame.text = "\(vm.detailGameRawg.rating)"
        descriptionGame.text = vm.detailGameRawg.deskripsi.convertHtmlToString
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
