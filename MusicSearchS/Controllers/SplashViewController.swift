//
//  SplashViewController.swift
//  MusicSearchS
//
//  Created by Carl Gorringe on 7/24/18.
//  Copyright © 2018 Carl Gorringe. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

  // UI
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var enterButton: UIButton!

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupDynamicTypes()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  /// Call this only once
  func setupDynamicTypes() {
    titleLabel.font = UIFontMetrics.default.scaledFont(for: titleLabel.font)
    subtitleLabel.font = UIFontMetrics.default.scaledFont(for: subtitleLabel.font)
    authorLabel.font = UIFontMetrics.default.scaledFont(for: authorLabel.font)
    enterButton.titleLabel?.font = UIFontMetrics.default.scaledFont(for: enterButton.titleLabel!.font)
    titleLabel.adjustsFontForContentSizeCategory = true
    subtitleLabel.adjustsFontForContentSizeCategory = true
    authorLabel.adjustsFontForContentSizeCategory = true
    enterButton.titleLabel?.adjustsFontForContentSizeCategory = true
  }

}

