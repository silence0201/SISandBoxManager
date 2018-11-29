//
//  SandBoxManager.swift
//  SISandBoxManager
//
//  Created by Silence on 2018/11/29.
//  Copyright © 2018年 Silence. All rights reserved.
//

import Foundation
import UIKit

class SandBoxManager {
    /// 单例
    static let sharedManager = SandBoxManager()
    private init(){}
    
    let videoExtension = [".avi", ".dat", ".mkv", ".flv", ".vob", ".mp4", ".m4v", ".mpg", ".mpeg", ".mpe", ".3pg", ".mov", ".swf", ".wmv", ".asf", ".asx", ".rm", ".rmvb"]
    let audioExtension = [".wav", ".aif", ".au", ".mp3", ".ram", ".wma", ".mmf", ".amr", ".aac", ".flac", ".midi", ".mp3", ".oog", ".cd", ".asf", ".rm", ".real", ".ape", ".vqf"]
    let imageExtension = [".jpg", ".png", ".jpeg", ".gif", ".bmp"]
    let documentExtension = [".txt", ".sh", ".doc", ".docx", ".xls", ".xlsx", ".pdf", ".hlp", ".wps", ".rtf", ".html", ".htm", ".iso", ".rar", ".zip", ".exe", ".mdf", ".ppt", ".pptx"]
    let systemPath = ["/tmp", "/Library/Preferences", "/Library/Caches/Snapshots", "/Library/Caches", "/Library", "/Documents"]
    
    /// 判断是否为系统文件夹
    func isSystemFile(filePath: String) -> Bool {
        for file in self.systemPath {
            if filePath.hasSuffix(file) { return true }
        }
        return false
    }
    
    /// 判断文件类型
    func fileType(filePath: String) -> FileType {
        var type = FileType.unknow
        let fileExtension = self.fileExtension(filePath: filePath)
        if videoExtension.contains(fileExtension) {
            type = .video(fileExtension)
        }else if audioExtension.contains(fileExtension) {
            type = .audio(fileExtension)
        }else if imageExtension.contains(fileExtension) {
            type = .image(fileExtension)
        }else if documentExtension.contains(fileExtension) {
            type = .document(fileExtension)
        }
        return type
    }
    
    /// 文件类型对应图标
    func fileTypeImage(filePath: String) -> UIImage? {
        var image: UIImage?
        let fileType = self.fileType(filePath: filePath)
        switch fileType {
        case .video:
            image = UIImage.image(fileType: "video")
        case .audio:
            image = UIImage.image(fileType: "audio")
        case .image:
            image = UIImage.image(fileType: "image")
        case .document(let fileExtension):
            if [".doc", ".docx"].contains(fileExtension) {
                image = UIImage.image(fileType: "doc")
            }else if [".xls", ".xlsx"].contains(fileExtension) {
                image = UIImage.image(fileType: "xls")
            }else if [".pdf"].contains(fileExtension) {
                image = UIImage.image(fileType: "pdf")
            }else if [".ppt", ".pptx"].contains(fileExtension) {
                image = UIImage.image(fileType: "ppt")
            }else {
                image = UIImage.image(fileType: "file")
            }
        case .unknow:
            image = UIImage.image(fileType: "folder")
        }
        return image
    }
    
    /// 文件后辍名
    func fileExtension(filePath: String) -> String {
        var fileExtension = ""
        let path = filePath as NSString
        let range = path.range(of: ".", options: .backwards)
        if range.location != NSNotFound {
            fileExtension = path.substring(from: range.location)
        }
        return fileExtension
    }
    
    /// 文件的大小
    class func fileSize(filePath: String) -> String {
        let size = self.fileSizeNumber(filePath: filePath)
        return self.fileSizeStrWithNumber(fileSize: size)
    }
    
    class func fileSizeNumber(filePath: String) -> Double {
        if self.isFileExists(filePath: filePath){
            let size = self.fileAttributes(filePath: filePath)?[FileAttributeKey.size] as? Double
            return size ?? 0
        }
        return 0
    }
    
    class func isFileExists(filePath: String) -> Bool{
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    class func fileAttributes(filePath: String) -> [FileAttributeKey : Any]? {
        if self.isFileExists(filePath: filePath) {
            if let fileAttribute = try?FileManager.default.attributesOfItem(atPath: filePath) {
                return fileAttribute
            }
        }
        return nil
    }
    
    class func fileSizeStrWithNumber(fileSize: Double) -> String {
        var message = "0"
        var size = fileSize
        if size > 1024 * 1024 {
            size = size / (1024 * 1024)
            message = String(format: "%.2fM", size)
        }else if size > 1024 {
            size = size / 1024
            message = String(format: "%.2fKB", size)
        }else if size > 0 {
            message = String(format: "%.2fB", size)
        }
        return message
    }
}
