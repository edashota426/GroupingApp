//
//  ViewController.swift
//  Grouping
//
//  Created by 登坂直弥 on 2017/11/30.
//  Copyright © 2017年 GroupingAppTeam. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}
//メモ：UIDDocumentVCでの変化（削除）などは全てこちらに反映される。


