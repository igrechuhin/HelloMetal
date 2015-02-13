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

  var pipelineState: MTLRenderPipelineState!

  var commandQueue: MTLCommandQueue!
  
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

    let defaultLibrary = device.newDefaultLibrary()
    let vertexProgram = defaultLibrary!.newFunctionWithName("basic_vertex")
    let fragmentProgram = defaultLibrary!.newFunctionWithName("basic_fragment")

    let pipelineStateDescriptor = MTLRenderPipelineDescriptor()
    pipelineStateDescriptor.vertexFunction = vertexProgram
    pipelineStateDescriptor.fragmentFunction = fragmentProgram
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = .BGRA8Unorm

    var error: NSError?
    pipelineState = device.newRenderPipelineStateWithDescriptor(pipelineStateDescriptor, error: &error)
    if pipelineState == nil {
      println("Failed to create pipeline state, error = \(error)")
    }

    commandQueue = device.newCommandQueue()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

