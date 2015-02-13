//
//  ViewController.swift
//  HelloMetal
//
//  Created by Илья Гречухин on 13.02.15.
//  Copyright (c) 2015 verdom. All rights reserved.
//

import UIKit
import Metal
import QuartzCore

class ViewController: UIViewController {

  var device: MTLDevice!

  var metalLayer: CAMetalLayer!

  override func viewDidLoad() {
    super.viewDidLoad()

    device = MTLCreateSystemDefaultDevice()

    metalLayer = CAMetalLayer()
    metalLayer.device = device
    metalLayer.pixelFormat = .BGRA8Unorm
    metalLayer.framebufferOnly = true
    metalLayer.frame = view.layer.bounds
    view.layer.addSublayer(metalLayer)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

