//
//  TVCShow.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 26/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit
import Kingfisher

class TVCShow: UITableViewCell {
    
    static let IDENTIFIER = String(describing: TVCShow.self)
    static let size : CGFloat = 80.0
    
    @IBOutlet weak var showImg: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    
    var taskImg: DownloadTask?
    
    var show : Show? {
        didSet {
            showTitle.text = show?.name
            if let imgUrl = URL(string: show?.image?.medium ?? "") {
                taskImg = showImg.kf.setImage(with: imgUrl)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        taskImg?.cancel()
    }
    
}
