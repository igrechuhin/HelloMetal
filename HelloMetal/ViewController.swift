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

  var timer: CADisplayLink!
  
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

    timer = CADisplayLink(target: self, selector: Selector("gameloop"))
    timer.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func render() {
    let drawable = metalLayer.nextDrawable()
    let renderPassDescriptor = MTLRenderPassDescriptor()
    let colorAttachment = renderPassDescriptor.colorAttachments[0]
    colorAttachment.texture = drawable.texture
    colorAttachment.loadAction = .Clear
    colorAttachment.clearColor = MTLClearColor(red: 0.0, green: 104.0/255.0, blue: 5.0/255.0, alpha: 1.0)

    let commandBuffer = commandQueue.commandBuffer()

    if let renderEncoder = commandBuffer.renderCommandEncoderWithDescriptor(renderPassDescriptor) {
      renderEncoder.setRenderPipelineState(pipelineState)
      renderEncoder.setVertexBuffer(vertexBuffer, offset: 0, atIndex: 0)
      renderEncoder.drawPrimitives(.Triangle, vertexStart: 0, vertexCount: 3, instanceCount: 1)
      renderEncoder.endEncoding()
    }
  }

  func gameloop() {
    autoreleasepool {
      self.render()
    }
  }
}

