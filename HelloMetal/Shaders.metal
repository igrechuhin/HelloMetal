//
//  Shaders.metal
//  HelloMetal
//
//  Created by Илья Гречухин on 13.02.15.
//  Copyright (c) 2015 verdom. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

vertex float4 basic_vertex(const device packed_float3* vertex_array[[buffer(0)]], unsigned int vid [[vertex_id]]) {
  return float4(vertex_array[vid], 1.0);
}
