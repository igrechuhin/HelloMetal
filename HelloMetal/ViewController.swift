//
//  ViewController.swift
//  HelloMetal
//
//  Created by Илья Гречухин on 13.02.15.
//  Copyright (c) 2015 verdom. All rights reserved.
//

import UIKit
import Metal


class ViewController: UIViewController {

  var device: MTLDevice!

  override func viewDidLoad() {
    super.viewDidLoad()

    device = MTLCreateSystemDefaultDevice()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

