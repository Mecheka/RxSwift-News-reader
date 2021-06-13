//
//  SourceTableViewCell.swift
//  NewsReader
//
//  Created by Suriya on 12/6/2564 BE.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
