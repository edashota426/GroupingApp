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
    
    var document: UIDocument?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // iCloud File画面への繊維
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
//アプリ内にファイルを保存する
    //サンドボックスの場所を得る
        let documentsPath = NSSewarchPathForDirectoriesInDomains(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            .DocumentDirectory
            .UserDomainMask,
            true)[0] as! String
print("documentsPath",: \(documentsPath))
    //UIDocumentサブクラスの概要
class USDocument: UIdocument {
    
    //各データに対応したstatic定数を宣言する
    struct USFileWrapperKeys {
        static let IMG = "USDocument.img"
        static let PLACE = "USDocument.place"
        static let DATE = "USDocument.date"
        static let DETAIL = "USDocument.detail"
    }
    //記録したい内容を保持するメンバ変数を宣言します
    var img:UIImage?
    var place:String?
    var date:NSDate?
    var detail:String?
    //上記の内容をひとまとめにパッケージするNSFileWrapperも、
    //メンバ変数として宣言する
    var fileWrapper:FileWrapper?
    
    //MARK:読み出し、書きこみ用のメソッド
    override func loadFromContents(contents: AnyObject,
        ofType TypeName:String,
        error outError:NSErrorPointer) -> Bool {
        ...}
    override func contentsForType(typeName: String,
                                  error outError: NSErrorPointer) -> Bool {
        ...}
}
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
        // let url = FileManager.default.url(forUbiquityContainerIdentifier: "iCloud.com.joyplot")
        
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

//11/18 test 始まり
//<ドキュメントファイルからrowを読み込み、UITableViewに表示させるメソッド> ->どこからファイル持ってくるのか指定する必要あり。
class ViewController: UIViewController,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBOutlet weak var testTableView: UITableView!
    //hsdGroupingTest.csv
    var dataList:[String] = []
    
    

    }
// 11/18test
    
//<並び替える項目を選択・削除する画面>
    
    //ボタン押下時に呼ばれるメソッド:：編集モード内においては、セルの削除や並び替えやができるようにする
    @IBAction func changeMode(_ sender: Any) {
    }
    @IBAction func changeMode(sender: AnyObject) {
        //通常モードと編集モードを切り替える。。
        if(testTableView.isEditing == true) {
            testTableView.isEditing = false
        } else {
            testTableView.isEditing = true
        }
    }
    
    //テーブルビュー編集時に呼ばれるメソッド:編集モード時に、項目を削除することができる
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        //削除の場合、配列からデータを削除する。
        if( editingStyle == UITableViewCellEditingStyle.delete) {
            dataList.remove(at: indexPath.row)
        }
        
        //テーブルの再読み込み
        tableView.reloadData()
    }
    
    //並び替え時に呼ばれるメソッド：編集モード時に、並び替えることができる
    private func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: IndexPath, toIndexPath destinationIndexPath: IndexPath){
        
        //移動されたデータを取得する。
        let moveData = tableView.cellForRow(at: sourceIndexPath)?.textLabel!.text
        
        //元の位置のデータを配列から削除する。
        dataList.remove(at: sourceIndexPath.row)
        
        //移動先の位置にデータを配列に挿入する。
        dataList.insert(moveData!, at:destinationIndexPath.row)
    }
//<並び替えるグループ数を表示する画面>：icloud containerの獲得時に最初から指定できているのか？実装した時に確認
    class ViewController: UIViewController, UITextFieldDelegate {
        
        private var myTextField: UITextField!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // UITextFieldを作成する.
            myTextField = UITextField(frame: CGRectMake(0,0,200,30))
            
            // 表示する文字を代入する.
            myTextField.text = "Hello Swift!!"
            
            // Delegateを設定する.
            myTextField.delegate = self
            
            // 枠を表示する.
            myTextField.borderStyle = UITextBorderStyle.roundedRect
            
            // UITextFieldの表示する位置を設定する.
            myTextField.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
            
            // Viewに追加する.
            self.view.addSubview(myTextField)
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
        
        /*
         UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
         */
        func textFieldDidBeginEditing(_ textField: UITextField){
            print("textFieldDidBeginEditing:" + textField.text!)
        }
        
        /*
         UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
         */
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            print("textFieldShouldEndEditing:" + textField.text!)
            
            return true
        }
        
        /*
         改行ボタンが押された際に呼ばれるデリゲートメソッド.
         */
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
        }
        
    }
//＜グルーピング開始ボタン押下時に呼ばれるメソッド:：グルーピングの裏の処理開始と、画面遷移＞
    //ファイルに、「カテゴリ」「グループ数」を外部引数として飛ばす。
    
    //並び替えが終了した時に、次の画面遷移
    //失敗した時の画面移動しない
    
    //<並び替えた結果を表示する画面>
        //<並び替えた結果をTableViewに表示する>＝<ドキュメントファイルからrowを読み込み、UITableViewに表示させるメソッド>
class ViewController: UIViewController,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBOutlet weak var testTableView: UITableView!
    //hsdGroupingTest.csv
    var dataList:[String] = []

    
    //<保存ボタンを押下時に、呼ばれるメソッド：データをcsvファイルとしてicloudに保存する>
        //<並び替えた結果を>
    
    //<>
    //

    
//最初からあるメソッド
func viewDidLoad() {
        super.viewDidLoad()
    }





