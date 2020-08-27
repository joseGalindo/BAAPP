//
//  DetailViewController.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 25/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    // UI
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showSummary: UITextView!
    @IBOutlet weak var showRate: UILabel!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var imdbBtn: UIButton!
    
    //
    var show: Show?
    var isFavorite : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = show?.name
        configureView()
    }
    
    private func configureView() {
        guard let mshow = show else {
            return
        }
        isFavorite = ManageDatabase.sharedInstance.isFavorite(show: mshow)
        let imgUrl = URL(string: mshow.image?.original ?? "")
        showImage.kf.setImage(with: imgUrl)
        let img =  isFavorite ? UIImage(named: "fav") : UIImage(named: "noFav")
        favBtn.image = img
        let style = "\(mshow.summary!)<style>body{font-size:'18px';}</style>"
        let data = style.data(using: .utf8, allowLossyConversion: false)
        let attrbtd = try! NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        showSummary.attributedText = attrbtd
        showRate.text = "Rate: \(mshow.rating!.average!)"
        if show!.externals?.imdb == nil {
            imdbBtn.isHidden = true
        }
    }
    
    @IBAction func showInfo(_ sender: Any) {
        if let imdb = show!.externals?.imdb,
            let link = URL(string: "https://www.imdb.com/title/\(imdb)") {
            UIApplication.shared.open(link)
        }
    }
    
    @IBAction func favSelected(_ sender: Any) {
        if isFavorite {
            ManageDatabase.sharedInstance.deleteShow(show: show!)
        } else {
            ManageDatabase.sharedInstance.addShow(show!)
        }
        isFavorite.toggle()
        let img = isFavorite ? UIImage(named: "fav") : UIImage(named: "noFav")
        favBtn.image = img
        
    }
}
