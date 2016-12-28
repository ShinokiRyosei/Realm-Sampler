//
//  CategoryViewController.swift
//  Realm-Sampler
//
//  Created by ShinokiRyosei on 2016/06/14.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UIViewController {
    
    @IBOutlet var categoryTable: UITableView! // CategoryModelのデータを表示するためのTableView
    
    var categories: [CategoryModel] = [] // TableViewで表示する配列
    
    var updatingCategory: CategoryModel! // 更新するCategoryModel
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.read()
    }
    
    // Addボタンの処理
    @IBAction func didSelectAdd() {
        self.transition()
    }
    
    // CategoryModelを全件取得する
    func read() {
        categories = CategoryModel.loadAll()
        categoryTable.reloadData()
    }
    
    // 該当のCategoryを削除する
    func deleteModel(index id: Int) {
        try! realm.write {
            realm.delete(categories[id])
        }
    }
    
    func transition() {
        self.performSegue(withIdentifier: "toAddCategory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddCategory" {
            let addCategory = segue.destination as! AddCategoryViewController
            addCategory.mode = .Update
            addCategory.updatingCategory = self.updatingCategory
        }
    }
}