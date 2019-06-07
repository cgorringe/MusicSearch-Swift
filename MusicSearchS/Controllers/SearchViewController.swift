//
//  SearchViewController.swift
//  MusicSearchS
//
//  Created by Carl Gorringe on 7/24/18.
//  Copyright © 2018 Carl Gorringe. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
  UISearchBarDelegate, UIScrollViewDelegate
{

  @IBOutlet weak var resultsTableView: UITableView!
  var searchController: UISearchController = UISearchController()
  var api: APIManager?
  var resultsList = [MusicModel]()

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - View Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    // init vars
    self.api = APIManager()

    // setup search controller & search bar
    self.searchController = UISearchController.init(searchResultsController: nil)
    self.searchController.dimsBackgroundDuringPresentation = false
    self.searchController.hidesNavigationBarDuringPresentation = false
    self.searchController.searchBar.delegate = self
    self.searchController.searchBar.placeholder = "Search Music"
    self.navigationItem.titleView = self.searchController.searchBar
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "idLyricsSegue" {
      let lvc = segue.destination as! LyricsViewController
      lvc.api = self.api
      lvc.music = self.resultsList[(self.resultsTableView.indexPathForSelectedRow?.row)!]

      // replace 'Back' button with empty text on pushed view controller
      self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: nil, style: UIBarButtonItem.Style.plain, target: self, action: nil)
    }
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - General

  func searchMusic(_ query: String) {
    self.api!.getMusic(query, completion: {
      (music: [MusicModel]) in
      self.resultsList = music
      self.resultsTableView.reloadData()
    })
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - UITableViewDataSource

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.resultsList.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "idMusicCell", for: indexPath) as! MusicCell
    cell.updateWithMusicModel(self.resultsList[indexPath.row])
    return cell
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - UITableViewDelegate

  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return indexPath
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - UISearchBarDelegate

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    // do nothing
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchMusic(searchBar.text ?? "")
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////
  // MARK: - UIScrollViewDelegate

  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.searchController.searchBar.resignFirstResponder()
  }

}
