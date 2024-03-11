//
//  NewsCell.swift
//  ToDoshka
//
//  Created by Bhavananda Das on 10.03.2024.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var descriptionLable: UILabel!
    
    @IBOutlet weak var imageURL: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
