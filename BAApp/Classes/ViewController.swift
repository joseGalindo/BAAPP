//
//  ViewController.swift
//  BAApp
//
//  Created by Jose Galindo martinez on 24/08/20.
//  Copyright © 2020 JCG. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TV Shows"
    }
    
    override func getShows() {
        tvshows.removeAll()
        ApiService.shared.getShows { (result: Result<[Show], ApiService.APIError>) in
            switch result {
            case let .success(response):
                self.tvshows.append(contentsOf: response)
                self.mTable.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension ViewController {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let show = tvshows[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .destructive,
                                                title: "Delete") { (action, indexPath) in
                                                    let alertvc = UIAlertController(title: "Eliminar", message: "¿Estas seguro que deseas eliminarlo?", preferredStyle: .alert)
                                                    alertvc.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
                                                    alertvc.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (act) in
                                                        self.tvshows.remove(at: indexPath.row)
                                                        tableView.deleteRows(at: [indexPath], with: .fade)
                                                        ManageDatabase.sharedInstance.deleteShow(show: show)
                                                    }))
                                                    self.present(alertvc, animated: true, completion: nil)
        }
        
        let favoriteAction = UITableViewRowAction(style: .normal,
                                                  title: "Favorite") { (action, indexPath) in
                                                    ManageDatabase.sharedInstance.addShow(show)
        }
        favoriteAction.backgroundColor = .green
        var actions = [favoriteAction]
        if ManageDatabase.sharedInstance.isFavorite(show: show) {
            actions.append(deleteAction)
        }
        return actions
    }
}

