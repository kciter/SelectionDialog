//
//  UIImageExtension.swift
//  Sample
//
//  Created by LeeSunhyoup on 2015. 10. 9..
//  Copyright © 2015년 KCSelectionView. All rights reserved.
//

import UIKit

extension UIImage {
    class func createImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}