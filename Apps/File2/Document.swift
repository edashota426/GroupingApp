//
//  Document.swift
//  File2
//
//  Created by 登坂直弥 on 2017/10/25.
//  Copyright © 2017年 super.naoya. All rights reserved.
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

//ここから、直弥が付け加えた処理
