//
//  ViewController.swift
//  SISandBoxManager
//
//  Created by Silence on 2018/11/29.
//  Copyright © 2018年 Silence. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = SandBoxManager.sharedManager.fileTypeImage(filePath: "/hh/hh/gh/hh.xls")
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.view.addSubview(imageView)
        imageView.center = self.view.center
    }
    
    
}

