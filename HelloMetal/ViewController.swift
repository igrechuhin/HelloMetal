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

  let vertexData: [Float] = [
     0.0,  1.0, 0.0,
    -1.0, -1.0, 0.0,
     1.0, -1.0, 0.0
  ]
  var vertexBuffer: MTLBuffer!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    device = MTLCreateSystemDefaultDevice()

    metalLayer = CAMetalLayer()
    metalLayer.device = device
    metalLayer.pixelFormat = .BGRA8Unorm
    metalLayer.framebufferOnly = true
    metalLayer.frame = view.layer.bounds
    view.layer.addSublayer(metalLayer)

    let dataSize = vertexData.count * sizeofValue(vertexData[0])
    vertexBuffer = device.newBufferWithBytes(vertexData, length: dataSize, options: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

