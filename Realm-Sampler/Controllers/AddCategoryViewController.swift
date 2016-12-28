//
//  AddCategoryViewController.swift
//  Realm-Sampler
//
//  Created by ShinokiRyosei on 2016/06/14.
//  Copyright © 2016年 ShinokiRyosei. All rights reserved.
//

import UIKit
import RealmSwift

class AddCategoryViewController: UIViewController { // AddCategoryViewControllerにUITextFieldDelegateを継承
    
    @IBOutlet var categoryTextField: UITextField! // カテゴリーの内容を記入するUITextField
    
    var updatingCategory: CategoryModel! // 更新の際のデータ
    
    var mode: RLMSaveMode = .Create // 更新か作成か
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 更新の際に、更新前のカテゴリーをUITextFieldに表示
        if mode == .Update {
            categoryTextField.text = updatingCategory.category
        }
    }
    
    // Saveボタンの処理
    @IBAction func didSelectSave() {
        // categoryTextFieldに文字が記入されているかチェック
        guard let text = categoryTextField.text else { return }
        
        // 更新か作成かで呼び出すメソッドを切り替え
        switch mode {
        case .Create:
            // categoryTextFieldの内容を使って、データを作成
            self.create(categoryContent: text)
        case .Update:
            // categoryTextFieldの内容を使って、データを更新
            self.update(categoryContent: text)
        }
        // 画面遷移
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func create(categoryContent text: String) {
        // CategoryModelのcreateメソッドを使って保存するためのデータを作成
        let category = CategoryModel.create(newCategory: text)
        // 作成したデータを保存
        category.save()
        
    }
    
    func update(categoryContent text: String) {
        // CategoryModelのupdateメソッドを使ってデータを更新
        CategoryModel.update(model: updatingCategory, content: text)
    }
}


extension AddCategoryViewController: UITextFieldDelegate {
    
    // Returnキーでキーボードを下げる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}