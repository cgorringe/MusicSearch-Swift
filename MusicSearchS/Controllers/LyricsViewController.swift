//
//  LyricsViewController.swift
//  MusicSearchS
//
//  Created by Carl Gorringe on 7/24/18.
//  Copyright © 2018 Carl Gorringe. All rights reserved.
//

import UIKit

class LyricsViewController: UIViewController
{
  // UI
  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var albumLabel: UILabel!
  @IBOutlet weak var albumImageView: UIImageView!
  @IBOutlet weak var lyricsTextView: UITextView!

  var api: APIManager?
  var music: MusicModel?
  
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateMusic(self.music)
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////

  func updateMusic(_ music: MusicModel?) {
    self.lyricsTextView.text = ""
    if let music = music {
      self.title = music.artistName!
      self.trackLabel.text = music.trackName!
      self.artistLabel.text = music.artistName!
      self.albumLabel.text = music.albumName!
      self.albumImageView.image = UIImage(named: "music-placeholder")

      // send notification to retrieve image
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DownloadImage"),
                                      object: self,
                                      userInfo: [ "imageView": self.albumImageView!,
                                                  "imageUrl": music.albumImageUrl!] )

      // retrieve lyrics from API
      self.api!.getLyrics(for: music.artistName!, song: music.trackName!) {
        (lyrics) in
        self.lyricsTextView.text = lyrics
      }
    }
    else {
      self.title = ""
      self.trackLabel.text = ""
      self.artistLabel.text = ""
      self.albumLabel.text = ""
    }
  }

}
