//
//  CustomLabel.swift
//  Hit Score
//
//  Created by Hakan Türkmen on 17.04.2024.
//

import UIKit

class CustomLabel: UILabel 
{

    override init(frame: CGRect) 
    {
        super.init(frame: .zero)
    }
    
    init(fontSize : CGFloat , weight : UIFont.Weight, text : String)
    {
        super.init(frame: .zero)
        textAlignment = .center
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
