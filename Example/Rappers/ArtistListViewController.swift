//
//  ArtistListViewController.swift
//

import UIKit

class ArtistListViewController: UITableViewController {
    
    let artists = ["2Pac", "Del tha Funkee Homosapien", "E-40", "Keak Da Sneak", "Lil Dicky", "Luniz", "Lyrics Born", "MC Hammer", "Pep Love", "Richie Rich", "Spice 1", "Too $hort", "Yukmouth"]
    private var artistViewControllers: [String : ArtistViewController] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Artists"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        
//        prefetch("Luniz")
//        prefetch("Lyrics Born")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(UITableViewCell.self), forIndexPath: indexPath)
        cell.textLabel?.text = artists[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let artist = artists[indexPath.row]
        
        if let artistViewController = artistViewControllers[artist] {
            navigationController?.pushViewController(artistViewController, animated: true)
        } else {
            let artistViewController = ArtistViewController()
            artistViewController.artist = artist
            navigationController?.pushViewController(artistViewController, animated: true)
            artistViewControllers[artist] = artistViewController
        }
    }
    
//    private func prefetch(artist: String) {
//        let vc = ArtistViewController()
//        vc.artist = artist
//        artistViewControllers[artist] = vc
//    }
}

import WebKit

private class ArtistViewController: UIViewController {
    let webView = WKWebView()
    var artist: String?
    
    private func loadContents() {
        if let url = url {
            let request = NSURLRequest(URL: url)
            webView.loadRequest(request)
        }
    }
    
    private override func loadView() {
        view = webView
    }
    
    private override func viewDidLoad() {
        super.viewDidLoad()
        title = artist
        
        loadContents()
    }
    
    var url: NSURL? {
        guard let artist = artist, let encodedArtist = artist.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) else {
            return nil
        }
        
        return NSURL(string: "https://www.google.com/search?tbm=isch&q=\(encodedArtist)")
    }
}
