//
//  ArticlesTableViewCell.swift
//  NewsReader
//
//  Created by Suriya on 13/6/2564 BE.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageArticle: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
