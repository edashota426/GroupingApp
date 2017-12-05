//
//  DocumentViewController.swift
//  File2
//
//  Created by 登坂直弥 on 2017/10/25.
//  Copyright © 2017年 super.naoya. All rights reserved.
//

import UIKit

//<ファイル選択>
//1st Scene:ファイル選択ボタン：
class DocumentViewController: UIViewController {
    
    @IBAction func selectFile(_ sender: Any) {
    }
    @IBOutlet weak var documentNameLabel: UILabel!
    
    var document: UIDocument?//ドキュメントオブジェクトを使って、ドキュメント形式のデータ構造を生成、管理。ドキュメントクラスには、新規ドキュメントをiCloudコンテナやローカルストレージに保存する機能が組み込まれている
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // iCloud File画面への遷移
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
//UIDocumentにはアプリケーションがファイルを読み書きするためには、ファイルコーディネーションを利用する必要あり。

//apple developper programより
    //ファイル名をイニシャライズする
-init;"groupingFile"
    //iOS上にreturnする場所の指定、bundle nameを埋め込むべき
    - (NSURL *)containerURLForSecurityApplicationGroupIdentifier:(NSString *)groupIdentifier;

//ここまでapple developper programより

//iCLoud kit用のコードはこちら。上記は削除して良い
class ViewController: UIViewController, UITextFieldDelegate {
    
    let textField = UITextField()
    let textFileName = "test.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        // 保存するテキストを入力するテキストフィールド
        textField.backgroundColor = UIColor.white
        textField.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 50)
        textField.center.x = self.view.center.x
        textField.delegate = self
        textField.placeholder = "Input"
        self.view.addSubview(textField)
        
        // テキストファイルを作成して書き込む
        let button = UIButton(type: .system)
        button.setTitle("書き込み", for: .normal)
        button.addTarget(self, action: #selector(self.writeTextToiCloudContainer), for: .touchUpInside)
        button.sizeToFit()
        button.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 150)
        self.view.addSubview(button)
        
        // 保存したテキストを読み込む
        let readButton = UIButton(type: .system)
        readButton.setTitle("読み込み", for: .normal)
        readButton.addTarget(self, action: #selector(self.readTextFromiCloudContainer), for: .touchUpInside)
        readButton.sizeToFit()
        readButton.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height - 100)
        self.view.addSubview(readButton)
    }
    
    @objc func writeTextToiCloudContainer() {
        
        // 特定の iCloud Container を指定する場合
        _ = FileManager.default.url(forUbiquityContainerIdentifier: "iCloud.com.joyplot")
        
        DispatchQueue.global().async(execute: {
            
            // コンテナが一つしかない場合は nil でもOK
            if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil) {
                
                let fileURL = url.appendingPathComponent(self.textFileName)
                print("fileURL: \(fileURL)")
                
                
                do {
                    try self.textField.text?.write(to: fileURL, atomically: true, encoding: .utf8)
                } catch {
                    print("write error")
                }
            }
        })
    }
    
    @objc func readTextFromiCloudContainer() {
        
        DispatchQueue.global().async(execute: {
            
            if let url = FileManager.default.url(forUbiquityContainerIdentifier: nil) {
                
                let filePath = url.appendingPathComponent(self.textFileName)
                do {
                    let readText = try String(contentsOf: filePath)
                    
                    DispatchQueue.main.async(execute: {
                        // UILabelのテキストを更新
                        let label = UILabel()
                        label.text = readText
                        label.font = UIFont(name: "HiraMinProN-W3", size: 20)
                        label.sizeToFit()
                        label.center = self.view.center
                        self.view.addSubview(label)
                    })
                } catch {
                    print("read error")
                }
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//ここまでがicloud containerの獲得と、書き出し、読み込み、保存。

//icloudにてファイルを選択できるコードUIDocumentPickerViewController
class SampleViewController : UIViewController, UIDocumentPickerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UIDocumentPickerViewControllerを開く
        let picker = UIDocumentPickerViewController(documentTypes: [("com.apple.iwork.pages.pages" as NSString) as String], in: UIDocumentPickerMode.open)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: UIDocumentPickerDelegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        print(#function)
        print("opened url : \(url)")
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
//ここまでがicloudにてファイルを選択できるコードUIDocumentPickerViewController
//
    //テーブルビューに表示させる。
    
    class ViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        // ステータスバーの高さ
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        // チェックリストの項目とチェック状態
        var checkListItem: [String : Bool] = [
            "RISA" : true,
            "AIRI" : false,
            "KEN" : true,
            "MAI" : true,
            "TOMOKO": false
        ]
        
        let tableView = UITableView()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // UITableView の作成
            tableView.frame = CGRect(
                x: 0,
                y: statusBarHeight,
                width: self.view.frame.width,
                height: self.view.frame.height - statusBarHeight
            )
            tableView.delegate = self
            tableView.dataSource = self
            self.view.addSubview(tableView)
        }
        
        // セルの作成
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            // Dictonary のキーの配列を取得
            var keys = [String](checkListItem.keys)
            
            // キーで並び替え
            keys.sort()
            
            // キーの文字列を取得
            let cellText = keys[indexPath.row]
            
            // セルの作成とテキストの設定
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            cell.textLabel?.text = cellText
            
            // チェック状態が true なら、初めからチェック状態にする
            if self.checkListItem[cellText]! {
                cell.imageView?.image = UIImage(named: "checked")
            } else {
                cell.imageView?.image = UIImage(named: "unchecked")
            }
            
            return cell
        }
        
        // セルがタップされた時の処理
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if let cell = tableView.cellForRow(at: indexPath) {
                
                // タップしたセルのテキストを取得
                let cellText = cell.textLabel?.text
                
                // 画像を切り替えと Dictonary の値を変更
                if cell.imageView?.image == UIImage(named: "checked") {
                    
                    self.checkListItem.updateValue(false, forKey: cellText!)
                    cell.imageView?.image = UIImage(named: "unchecked")
                } else {
                    
                    self.checkListItem.updateValue(true, forKey: cellText!)
                    cell.imageView?.image = UIImage(named: "checked")
                }
                
                // 選択状態を解除
                cell.isSelected = false
            }
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 56
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.checkListItem.count
        }
    }
}
//icloud fileファイルからホーム画面へかえってくる
