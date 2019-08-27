//
//  CatalogTableViewCell.swift
//  Mushrooms
//
//  Created by n3deep on 08/08/2019.
//  Copyright © 2019 n3deep. All rights reserved.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mushroomNameLabel: UILabel!
    
    weak var viewModel: CatalogTableViewCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            mushroomNameLabel.text = viewModel.name
            
            //mushroomType = viewModel.type
            if viewModel.type == 2 {
                mushroomNameLabel.textColor = UIColor.systemRed
            } else {
                mushroomNameLabel.textColor = UIColor.black
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
