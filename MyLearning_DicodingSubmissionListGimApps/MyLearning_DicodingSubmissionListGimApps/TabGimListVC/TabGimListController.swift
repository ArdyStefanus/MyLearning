//
//  TabGimListController.swift
//  MyLearning_DicodingSubmissionListGimApps
//
//  Created by telkom on 21/01/25.
//

import UIKit

class TabListGimVC: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewListGame: UITableView!

    let vm = TabGimListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        vm.getAvailableGameList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupView(){
        tableViewListGame.delegate = self
        tableViewListGame.dataSource = self
        tableViewListGame.register(UINib.init(nibName: NibFile.LIST_GAME_CELL, bundle: nil), forCellReuseIdentifier: NibFile.LIST_GAME_CELL)
        
        bind()
    }
    
    func bind() {
        vm.loading.bind { [weak self] loading in
            if loading { self?.loadingIndicator.startAnimating() }
            else { self?.loadingIndicator.stopAnimating() }
        }
        
        vm.arrListGameRawg.bind { [weak self] (_) in
            self?.tableViewListGame.reloadData()
        }
    }
}

extension TabListGimVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.arrListGameRawg.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NibFile.LIST_GAME_CELL, for: indexPath) as! ListGameCell
        let data = vm.arrListGameRawg.value[indexPath.row]
        cell.setupCell(data: data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailGimListVC(nibName: NibFile.DETAIL_LIST_GIM, bundle: nil)
        vc.vm.idListGame = vm.arrListGameRawg.value[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}
