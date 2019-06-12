//
//  MusicCell.swift
//  MusicSearchS
//
//  Created by Carl Gorringe on 7/24/18.
//  Copyright © 2018 Carl Gorringe. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {

  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var albumLabel: UILabel!
  @IBOutlet weak var albumImageView: UIImageView!

  override func awakeFromNib() {
    super.awakeFromNib()
    self.activateDynamicType(recursive: true)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }

  func updateWithMusicModel(_ music: MusicModel) {
    self.trackLabel.text = music.trackName
    self.artistLabel.text = music.artistName
    self.albumLabel.text = music.albumName
    self.albumImageView.image = UIImage(named: "music-placeholder")

    // send notification to retrieve image
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DownloadImage"),
                                    object: self,
                                    userInfo: ["imageView": self.albumImageView!,
                                               "imageUrl": music.albumImageUrl!] )
  }

}
