//
//  ListTableViewCell.swift
//  DesafioCielo
//
//  Created by Gustavo Melki Leal on 19/09/2018.
//  Copyright © 2018 Gustavo Melki Leal. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
  
  @IBOutlet weak var characterImg: UIImageView!
  @IBOutlet weak var characterLabel: UILabel!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
