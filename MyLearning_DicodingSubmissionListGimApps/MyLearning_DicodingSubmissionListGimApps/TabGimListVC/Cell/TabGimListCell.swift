//
//  TabGimListCell.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import UIKit
import SDWebImage

class ListGameCell: UITableViewCell {

    @IBOutlet weak var imageViewGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var releaseGame: UILabel!
    @IBOutlet weak var ratingGame: UILabel!
    
    func setupCell(data: ListGameRawg){
        let url = URL.init(string: data.backgroundImage)
        imageViewGame.sd_setImage(with: url, placeholderImage: UIImage(contentsOfFile: "empty"))
        nameGame.text = data.name
        releaseGame.text = "Released Date: \(data.released)"
        ratingGame.text = "\(data.rating)"
    }
}
