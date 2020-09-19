load("//toolchain:glslang.bzl", "glslang")

cc_binary(
    name="game",
    srcs = [
        "Game.cpp",
        "Renderer.h",
    ],
    deps = [
        "@glfw//:glfw",
    ],
    linkopts = 
        select({
            "@bazel_tools//src/conditions:linux_x86_64": [
                "-lX11",
                "-ldl",
                "-lpthread",
                "-lvulkan"
            ],
            "@bazel_tools//src/conditions:darwin_x86_64": [
                "-lX11",
                "-ldl",
                "-lpthread",
                "-lvulkan"
            ]
        }),
    defines = [
        "GLFW_INCLUDE_VULKAN"
    ],
    data = [
        ":compileVertexShader",
        "compileFragmentShader",
    ]
)

glslang(
    name = "compileVertexShader",
    srcs = ["shaders/vertex.vert"],
    spirv_compiler = "@glslang//:glslangValidator",
)

glslang(
    name = "compileFragmentShader",
    srcs = ["shaders/fragment.frag"],
    spirv_compiler = "@glslang//:glslangValidator",
)
