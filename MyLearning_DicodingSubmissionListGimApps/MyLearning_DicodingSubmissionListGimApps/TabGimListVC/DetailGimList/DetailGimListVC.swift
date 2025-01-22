//
//  DetailGimListVC.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 22/01/25.
//

import UIKit
import SDWebImage
import CoreData

class DetailGimListVC: UIViewController {

    @IBOutlet weak var imageViewGame: UIImageView!
    @IBOutlet weak var nameGame: UILabel!
    @IBOutlet weak var releaseDateGame: UILabel!
    @IBOutlet weak var ratingGame: UILabel!
    @IBOutlet weak var descriptionGame: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnFavorite: UIImageView!
    
    let vm = DetailGimVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailGame()
        
        btnFavorite.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapFavoriteGame(_:))))
    }
    
    func getDetailGame(){
        self.loadingIndicator.startAnimating()
        vm.getDetailGame() { (status) in
            if status != "" {
                self.setupData()
                self.fetchGameFavorite()
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    func setupData(){
        let url = URL.init(string: vm.detailGameRawg.backgroundImage)
        imageViewGame.sd_setImage(with: url, placeholderImage: UIImage(contentsOfFile: "empty"))
        
        nameGame.text = vm.detailGameRawg.name
        releaseDateGame.text = "Released Date: \(vm.detailGameRawg.released)"
        ratingGame.text = "\(vm.detailGameRawg.rating)"
        descriptionGame.text = vm.detailGameRawg.deskripsi.convertHtmlToString
    }
    
    func fetchGameFavorite(){
        vm.coreIdGame.removeAll()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
        
        do {
            let myObjects = try managedContext.fetch(fetchRequest)
            for myObject in myObjects {
                vm.coreIdGame.append(myObject.value(forKeyPath: "id") as? Int ?? 0)
            }
            
            if vm.coreIdGame.contains(where: { $0 == vm.detailGameRawg.id }) {
                btnFavorite.image = #imageLiteral(resourceName: "tabbar favorite selected")
                vm.isAlreadyFavorite = true
            } else {
                btnFavorite.image = #imageLiteral(resourceName: "tabbar favorite")
                vm.isAlreadyFavorite = false
            }
        } catch let error as NSError {
            print("Could not fetch data. \(error), \(error.userInfo)")
        }
    }
    
    func addGameFavorite(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        
        object.setValue(vm.detailGameRawg.id, forKeyPath: "id")
        object.setValue(vm.detailGameRawg.name, forKeyPath: "name")
        object.setValue(vm.detailGameRawg.released, forKeyPath: "released")
        object.setValue(vm.detailGameRawg.rating, forKeyPath: "rating")
        object.setValue(vm.detailGameRawg.backgroundImage, forKeyPath: "backgroundImage")
        object.setValue(vm.detailGameRawg.deskripsi, forKeyPath: "deskripsi")
        
        do {
            try managedContext.save()
            fetchGameFavorite()
        } catch let error as NSError {
            print("Could not save data. \(error), \(error.userInfo)")
        }
    }
    
    func deleteGameFavorite(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == \(vm.idListGame)")

        do {
            let objectsToDelete = try managedContext.fetch(fetchRequest)
            for object in objectsToDelete {
                managedContext.delete(object as! NSManagedObject)
            }
            try managedContext.save()
            fetchGameFavorite()
        } catch let error as NSError {
            print("Could not delete data. \(error), \(error.userInfo)")
        }
    }
    
    @objc func tapFavoriteGame(_ gesture: UITapGestureRecognizer) {
        if vm.isAlreadyFavorite{
            deleteGameFavorite()
            btnFavorite.image = #imageLiteral(resourceName: "tabbar favorite")
            vm.isAlreadyFavorite = false
        } else {
            addGameFavorite()
            btnFavorite.image = #imageLiteral(resourceName: "tabbar favorite selected")
        }
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
