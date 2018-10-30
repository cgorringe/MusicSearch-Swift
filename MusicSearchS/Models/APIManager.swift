//
//  APIManager.swift
//  MusicSearchS
//
//  Created by Carl Gorringe on 7/24/18.
//  Copyright © 2018 Carl Gorringe. All rights reserved.
//

import Foundation
import UIKit

class APIManager {

  init() {
    NotificationCenter.default.addObserver(self, selector: #selector(downloadImageWithNotification(_:)),
                                           name: NSNotification.Name(rawValue: "DownloadImage"),
                                           object: nil)
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - General

  /** If data passed in is of the following form, this will return corrected JSON data,
      else if data is already valid JSON, this will simply return that data:
        song = { 'key' : 'value', ... }
   */

  func fixInvalidJSONData(_ data: Data) -> Data? {

    // return if data is already valid JSON
    if (try? JSONSerialization.jsonObject(with: data, options: []) as! [String: String]) != nil {
      return data
    }

    // Step 1: Remove all characters before the first '{' for dictionaries, or '[' for arrays.
    let text = String(data: data, encoding:String.Encoding.utf8) ?? ""
    var outText = ""
    if let clipRange = text.rangeOfCharacter(from: CharacterSet(charactersIn: "{[")) {
      outText = String( text[clipRange.lowerBound ..< text.endIndex] )
    }
    else {
      return nil
    }

    // Step 2: Replace all (") with (\")
    outText = outText.replacingOccurrences(of: "\"", with: "\\\"")

    // Step 3: Replace all (') with ("), except (\') which are replaced with (')
    // uses § as a temp single quote
    outText = outText.replacingOccurrences(of: "\\'", with: "§")
    outText = outText.replacingOccurrences(of: "'", with: "\"")
    outText = outText.replacingOccurrences(of: "§", with: "'")

    return outText.data(using: String.Encoding.utf8)
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - API Calls

  func getMusic(_ query: String, completion: @escaping ([MusicModel]) -> Void) {

    // setup URL
    // "https://itunes.apple.com/search?term=\(query)"
    var components = URLComponents(string: "https://itunes.apple.com/search")!
    components.queryItems = [URLQueryItem(name: "term", value: query)]
    let url = components.url!
    print("GET: \(url.absoluteString)")

    // setup API call
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in

      var musicResults = [MusicModel]()
      if (data != nil) {
        do {
          let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: AnyObject]
          if let jsonResults = json["results"] as? [AnyObject] {
            for item in jsonResults {
              let music = MusicModel()
              music.trackName = item["trackName"] as? String ?? ""
              music.artistName = item["artistName"] as? String ?? ""
              music.albumName = item["collectionName"] as? String ?? ""
              music.albumImageUrl = item["artworkUrl100"] as? String
              musicResults.append(music)
            }
          }
          else {
            print("JSON missing 'results' key!")
          }
        } catch let error2 {
          print("JSON parsing error: \(error2.localizedDescription)")
        }
      }
      else {
        print("API error: \(error!.localizedDescription)")
      }
      DispatchQueue.main.async() {
        // run on the UI thread
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        completion(musicResults)
      }
    }
    task.resume()
  }

  func getLyrics(for artist: String, song: String, completion: @escaping (String) -> Void ) {

    // setup URL
    // "https://lyrics.wikia.com/api.php?func=getSong&artist=\(artist)&song=\(song)&fmt=json"
    var components = URLComponents(string: "https://lyrics.wikia.com/api.php")!
    components.queryItems = [ URLQueryItem(name: "func", value: "getSong"),
                              URLQueryItem(name: "artist", value: artist),
                              URLQueryItem(name: "song", value: song),
                              URLQueryItem(name: "fmt", value: "json") ]
    let url = components.url!
    print("GET: \(url.absoluteString)")

    // setup API call
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in

      var lyrics = ""
      if (data != nil) {
        do {
          // the Lyrics API returns invalid JSON, so it must first be fixed.
          let fixedData = self.fixInvalidJSONData(data!)
          let json = try JSONSerialization.jsonObject(with: fixedData!, options: []) as! [String: String]
          lyrics = json["lyrics"] ?? "Lyrics are unavailable."
        } catch let error2 {
          print("JSON parsing error: \(error2.localizedDescription)")
        }
      }
      else {
        print("API error: \(error!.localizedDescription)")
      }
      DispatchQueue.main.async() {
        // run on the UI thread
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        completion(lyrics)
      }
    }
    task.resume()
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - Notifications

  @objc func downloadImageWithNotification(_ notificaion: NSNotification) {

    guard let userInfo = notificaion.userInfo else { return }
    guard let imageView = userInfo["imageView"] as? UIImageView else { return }
    guard let imageUrl = userInfo["imageUrl"] as? String else { return }

    // download image or auto retrieve from cache
    let task = URLSession.shared.dataTask(with: URL(string:imageUrl)!) {
      (data, response, error) in

      if (data != nil) {
        if let downloadedImg = UIImage.init(data: data!) {
          DispatchQueue.main.async() {
            // run on the UI thread
            imageView.image = downloadedImg
          }
        }
        else {
          print("error: downloadedImg is nil!")
        }
      }
    }
    task.resume()
  }

}
