//
//  BoutonArrondi.swift
//  Les Calanques
//
//  Created by Mathias Bouillon on 19/05/2020.
//  Copyright © 2020 Mathias Bouillon. All rights reserved.
//

import UIKit

class BoutonArrondi: UIButton {

    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        layer.cornerRadius = 10
    }
    
    
}
