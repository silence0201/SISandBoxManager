//
//  FileModel.swift
//  SISandBoxManager
//
//  Created by Silence on 2018/11/29.
//  Copyright © 2018年 Silence. All rights reserved.
//

import Foundation

// MARK: - 文件的格式
enum FileType {
    case unknow
    case video(String)
    case audio(String)
    case image(String)
    case document(String)
}

struct FileModel {
    var filePath = ""
    var fileName = ""
    var fileType = FileType.unknow
}
