//: Playground - noun: a place where people can play

import UIKit

//CSVファイルの読み込みメソッド。引数にファイル名、返り値にString型の配列。
func loadCSV("sample":String)->[String]{
    //CSVファイルを格納するための配列を作成
    var csvArray:[String] = []
    //CSVファイルの読み込み
    let csvBundle = Bundle.main.path(forResource: "sample", ofType: "csv")
    
    do {
        //csvBundleのパスを読み込み、UTF8に文字コード変換して、NSStringに格納
        let csvData = try String(contentsOfFile: csvBundle!,
                                 encoding: String.Encoding.utf8)
        //改行コードが"\r"で行なわれている場合は"\n"に変更する
        let lineChange = csvData.replacingOccurrences(of: "\r", with: "\n")
        //"\n"の改行コードで区切って、配列csvArrayに格納する
        csvArray = lineChange.components(separatedBy: "\n")
    }
    catch {
        print("エラー")
    }
    return csvArray
}

print(loadCSV)
