//
//  UIView+Ext.swift
//  Hit Score
//
//  Created by Hakan Türkmen on 17.04.2024.
//

import UIKit


extension UIView
{
    func addSubViews(_ views : UIView...)
    {
        for view in views
        {
            addSubview(view)
        }
    }
    func screenshot() -> UIImage {
        let size =  CGSize(width: bounds.size.width, height: bounds.size.height )
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
          drawHierarchy(in: CGRect(origin: .zero, size: size
                                  ), afterScreenUpdates: true)
        }
      }
}


