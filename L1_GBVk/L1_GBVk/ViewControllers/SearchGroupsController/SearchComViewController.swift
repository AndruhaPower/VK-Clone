//
//  SearchComViewController.swift
//  L1_GBVk
//
//  Created by Andrew on 18/05/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit
import RealmSwift

final class SearchComViewController: UITableViewController {

    var searchGroups: [RGroup] = []
    private let vkServices = VKServices()
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveGroupsData()
        self.tableViewConfig()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchGroups.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomGroupCell.reuseId, for: indexPath) as? CustomGroupCell
            , let photo = self.searchGroups[indexPath.row].photo else { return UITableViewCell() }
        
        cell.groupNameLabel.text = self.searchGroups[indexPath.row].name
        cell.indexPath = indexPath
        let operationQueue = OperationQueue()
        let operation = LoadImageOperation()
        operation.url = URL(string: photo)
        operationQueue.addOperation(operation)
        operation.completion = { image in
            if cell.indexPath == indexPath {
                cell.groupAvatarImage.image = image
            }
        }
        return cell
    }
    
    private func saveGroupsData() {
        self.vkServices.getSearchGroups { [weak self] (isFinished) in
            do {
                guard let self = self else { return }
                let realm = try Realm()
                let resultGroups = realm.objects(RGroup.self).filter("isMember == 0")
                self.searchGroups = Array(resultGroups)
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func tableViewConfig() {
        self.title = "Поиск групп"
        self.tableView.register(UINib(nibName: "CustomGroupCell", bundle: nil), forCellReuseIdentifier: CustomGroupCell.reuseId)
        self.tableView.dataSource = self
    }
}
