//
//  CalanqueCell.swift
//  Les Calanques
//
//  Created by Mathias Bouillon on 18/05/2020.
//  Copyright © 2020 Mathias Bouillon. All rights reserved.
//

import UIKit

class CalanqueCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var calanqueIV: ImageRonde!
    @IBOutlet weak var monLabel: UILabel!
    
    var calanque: Calanque!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupCell(_ calanque: Calanque){
        self.calanque = calanque
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = UIColor.lightGray
        monLabel.text = self.calanque.nom
        calanqueIV.image = self.calanque.image
    }
    
    
}
