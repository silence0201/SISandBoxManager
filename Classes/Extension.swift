//
//  Bundle+Extension.swift
//  SISandBoxManager
//
//  Created by Silence on 2018/11/29.
//  Copyright © 2018年 Silence. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(fileType: String) -> UIImage? {
        let bundlePath = Bundle(for: SandBoxManager.self).path(forResource: "SandBoxFileImages", ofType: "bundle") ?? ""
        let fileBundle = Bundle(path: bundlePath)
        let image = UIImage(contentsOfFile: fileBundle?.path(forResource: fileType, ofType: "png") ?? "")
        return image
    }
}
