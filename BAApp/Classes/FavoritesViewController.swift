//
//  FavoritesViewController.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 25/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {

    var someoneElseEdit = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshShows), name: Notification.Name(Constants.DATABASE_MODIFICATED), object: nil)
    }
    
    @objc func refreshShows() {
        if someoneElseEdit {
            self.getShows()
        }
        someoneElseEdit = true
    }
    
    override func getShows() {
        self.tvshows.removeAll()
        self.tvshows.append(contentsOf: ManageDatabase.sharedInstance.getAllFavorites())
        self.mTable.reloadData()
    }
}


extension FavoritesViewController {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alertvc = UIAlertController(title: "Eliminar", message: "¿Estas seguro que deseas eliminarlo?", preferredStyle: .alert)
            alertvc.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
            alertvc.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (act) in
                self.someoneElseEdit = false
                let eliminado = self.tvshows[indexPath.row]
                self.tvshows.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                ManageDatabase.sharedInstance.deleteShow(show: eliminado)
            }))
            self.present(alertvc, animated: true, completion: nil)
        }
    }
}
