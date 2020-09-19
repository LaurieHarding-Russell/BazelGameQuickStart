
cc_binary(
    name = "game",
    srcs = [
        "Game.cpp",
    ],
    deps = [
        ":initShader"
    ],
    linkopts = [
        "-lGL",
    ],
    data = [
        "shaders/fragmentShader.glsl",
        "shaders/vertexShader.glsl"
    ],
    defines = [ 
        "GL_GLEXT_PROTOTYPES"
    ],
    visibility = ["//visibility:public"]
)

cc_library(
  name = "initShader",
  hdrs = ["ShaderLoader.h"],
  linkopts = [
    "-lGL", 
  ],
  deps = [
    "@glew//:glew",
  ]
)