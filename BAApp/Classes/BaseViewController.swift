//
//  BaseViewController.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 25/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

protocol TablePopulable {
    func getShows()
}

class BaseViewController: UIViewController, TablePopulable {
    // UI
    var mTable: UITableView!
    // Properties
    var tvshows = [Show]()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .always
        }
        setUtTable()
        getShows()
    }
    
    func setUtTable() {
        let table = UITableView(frame: self.view.frame, style: .plain)
        table.dataSource = self
        table.delegate = self
        let nib = UINib.init(nibName: "TVCShow", bundle: nil)
        table.register(nib, forCellReuseIdentifier: TVCShow.IDENTIFIER)
        mTable = table
        self.view.addSubview(table)
    }
    
    func getShows() {}
    
    func showNext(show: Show) {
        performSegue(withIdentifier: "showDetail", sender: show)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.show = sender as? Show
    }
}

extension BaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvshows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TVCShow.IDENTIFIER, for: indexPath) as! TVCShow
        cell.show = tvshows[indexPath.row]
        return cell
    }
}

extension BaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TVCShow.size
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showNext(show: tvshows[indexPath.row])
    }
}
