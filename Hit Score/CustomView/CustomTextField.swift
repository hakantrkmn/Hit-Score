//
//  CustomTextField.swift
//  Hit Score
//
//  Created by Hakan Türkmen on 17.04.2024.
//

import UIKit

class CustomTextField: UITextField
{
    
    override init(frame: CGRect)
    {
        super.init(frame: .zero)
        configure(fontSize: 30 , haveUnderline: false)
    }
    
    func configure(fontSize : CGFloat , haveUnderline : Bool)
    {
        textAlignment = .center
        adjustsFontSizeToFitWidth = true
        font = UIFont.systemFont(ofSize: fontSize)
       
        tintColor = .clear
        if haveUnderline
        {
            self.layer.addSublayer(underlineLayer)
        }
    }
    
    init(fontSize : CGFloat , haveUnderline : Bool)
    {
        super.init(frame: .zero)
        configure(fontSize: fontSize , haveUnderline: haveUnderline)
        
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    let underlineLayer = CALayer()
    
    func setupUnderlineLayer() {
        var frame = self.bounds
        frame.origin.y = frame.size.height - 1
        frame.size.height = 2
        
        underlineLayer.frame = frame
        underlineLayer.backgroundColor = UIColor.systemGreen.cgColor
    }
    
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUnderlineLayer()
    }
    
    
}
