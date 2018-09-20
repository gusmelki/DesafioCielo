//
//  DetailViewController.swift
//  DesafioCielo
//
//  Created by Gustavo Melki Leal on 20/09/2018.
//  Copyright © 2018 Gustavo Melki Leal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var detailLabel: UITextView!
  @IBOutlet weak var nameLabel: UILabel!
  
  var character: Character?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.nameLabel.text = self.character?.name
    let url = URL(string: (character?.thumbnail?.path)! + "/portrait_medium." + (character?.thumbnail?._extension)!)
    self.imageView.sd_setImage(with: url!, completed: nil)
    self.detailLabel.text = self.character?.description
    if (self.character?.description?.isEmpty)! {
      self.detailLabel.text = "No Description 🙁"
    }
    
  }
}
