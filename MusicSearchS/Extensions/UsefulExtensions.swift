//
//  UsefulExtensions.swift
//
//  Created by Carl on 6/11/19.
//  Copyright © 2019 Carl Gorringe. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

  /// Replaces the view's font with the same font that supports Dynamic Type scaling.
  /// - warning: Must call only once per view or else app may crash!
  /// - parameter recursive: true = recursively apply to subviews.

  func activateDynamicType(recursive: Bool = false) {

    let v1 = self
    if v1 is UILabel, let v2 = v1 as? UILabel {
      v2.font = UIFontMetrics.default.scaledFont(for: v2.font)
      v2.adjustsFontForContentSizeCategory = true
    }
    else if v1 is UIButton, let v2 = v1 as? UIButton, v2.titleLabel != nil {
      v2.titleLabel?.font = UIFontMetrics.default.scaledFont(for: v2.titleLabel!.font)
      v2.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    else if v1 is UITextView, let v2 = v1 as? UITextView, v2.font != nil {
      v2.font = UIFontMetrics.default.scaledFont(for: v2.font!)
      v2.adjustsFontForContentSizeCategory = true
    }
    else if v1 is UITextField, let v2 = v1 as? UITextField, v2.font != nil {
      v2.font = UIFontMetrics.default.scaledFont(for: v2.font!)
      v2.adjustsFontForContentSizeCategory = true
    }
    else if recursive {
      for v2 in v1.subviews {
        v2.activateDynamicType(recursive: recursive)
      }
    }
  }

}
