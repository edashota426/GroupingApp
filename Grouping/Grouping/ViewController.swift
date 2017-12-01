//
//  ViewController.swift
//  Grouping
//
//  Created by Shota Eda on 2017/11/26.
//  Copyright © 2017年 GroupingAppTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//ここから書き足していったコード
    
//ファイルを選択する
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
}//icloud containerにあるcsvデータを引数に名前を表示すること
class ViewController2: UIViewController,UITableViewDataSource {
    
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
}
//

////<並び替えるグループ数を表示する画面>
class ViewController3: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var _textField: UITextField!
    
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




