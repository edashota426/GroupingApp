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

//11/18 test 始まり
class ViewController: UIViewController,UITableViewDataSource {
    @IBOutlet weak var testTableView: UITableView!
    //hsdGroupingTest.csv
    var dataList:[String] = []
    
    
    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            //CSVファイルのパスを取得する。
            let csvPath = Bundle.main.path(forResource: "hsdGroupingTest", ofType: "csv")
            
            //CSVファイルのデータを取得する。
            let csvData = try String(contentsOfFile:csvPath!, encoding:String.Encoding.utf8)
            
            //改行区切りでデータを分割して配列に格納する。
            dataList = csvData.components(separatedBy: "\n")
            
        } catch {
            print(error)
        }
    }
    
    
    //データを返すメソッド
    func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        
        //セルを取得する。
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for:indexPath) as UITableViewCell
        
        //カンマでデータを分割して配列に格納する。
        let dataDetail = dataList[indexPath.row].components(separatedBy: ",")
        
        //セルのラベルにsex,skill,Region,Presen,JFを設定する。
        cell.textLabel?.text = dataDetail[5]
        cell.detailTextLabel?.text = "Sex：" + String(dataDetail[1])
        
        return cell
    }
    
    
    //データの個数を返すメソッド
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return dataList.count
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
//<並び替えるグループ数を表示する画面>

    
    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}




