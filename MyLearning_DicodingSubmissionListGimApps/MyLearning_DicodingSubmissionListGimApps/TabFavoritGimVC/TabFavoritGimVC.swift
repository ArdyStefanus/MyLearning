//
//  TabFavoritGimVC.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import UIKit
import CoreData

class TabFavoritVC: UIViewController {

    @IBOutlet weak var tableViewFavorite: UITableView!
    
    let vm = TabFavoritVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchCoreDataArray()
    }
    
    func setupView(){
        tableViewFavorite.delegate = self
        tableViewFavorite.dataSource = self
        tableViewFavorite.register(UINib.init(nibName: NibFile.LIST_GAME_CELL, bundle: nil), forCellReuseIdentifier: NibFile.LIST_GAME_CELL)
        
        bind()
    }
    
    func bind() {
        vm.favoriteData.bind { [weak self] (_) in
            self?.tableViewFavorite.reloadData()
        }
    }
    
    func fetchCoreDataArray(){
        vm.favoriteData.value.removeAll()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let result = try context.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                let id = data.value(forKeyPath: "id") as? Int ?? 0
                let name = data.value(forKeyPath: "name") as? String ?? ""
                let rilis = data.value(forKeyPath: "released") as? String ?? ""
                let backgroundImage = data.value(forKeyPath: "backgroundImage") as? String ?? ""
                let rating = data.value(forKeyPath: "rating") as? Double ?? 0.0
                let deskripsi = data.value(forKeyPath: "deskripsi") as? String ?? ""
                vm.favoriteData.value.append(ListGameRawg.init(id: id, name: name, rilis: rilis, rating: rating, backgroundImage: backgroundImage, deskripsi: deskripsi))
            }
        } catch {
            print("Error fetching data from Core Data: \(error)")
        }
    }
}

extension TabFavoritVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.favoriteData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NibFile.LIST_GAME_CELL, for: indexPath) as! ListGameCell
        let data = vm.favoriteData.value[indexPath.row]
        cell.setupCell(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailFavoritVC(nibName: NibFile.DETAIL_LIST_GIM_FAVORIT, bundle: nil)
        vc.vm.idListGame = vm.favoriteData.value[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}


