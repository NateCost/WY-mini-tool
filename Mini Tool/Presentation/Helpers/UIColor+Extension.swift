//
//  Created by Ilya Sakalou on 6/20/20.
//  Copyright © 2020 Nirma. All rights reserved.
//

import UIKit

func uicolor(with hex: String) -> UIColor {
  var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
  
  if cString.hasPrefix("#") {
    cString.remove(at: cString.startIndex)
  }
  
  if cString.count != 6 { return .gray }
  
  var rgbValue: UInt64 = 0
  Scanner(string: cString).scanHexInt64(&rgbValue)
  
  return UIColor(
    red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
    green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
    blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
    alpha: CGFloat(1.0)
  )
}
