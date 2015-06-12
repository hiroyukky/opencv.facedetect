//
//  ViewController.swift
//  opencv.facedetect
//
//  Created by hiroyukky on 6/13/15.
//  Copyright (c) 2015 hiroyukky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let detector = FaceDetector()
        //self.imageView = UIImageView()
        //let origImage = UIImage(named: "mikarika.jpg")
        let faceImage = detector.detectFace(self.imageView.image!)
        self.imageView.image = faceImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

