
cc_library(
    name = "glew",
    includes = ["include"],
    srcs = [
        "src/glew.c",
    ],
    hdrs = [
        "include/GL/glew.h",
        "include/GL/eglew.h",
        "include/GL/glxew.h",
        "include/GL/wglew.h",

    ],
    defines = [
        "GLEW_STATIC",
    ],
    visibility = ["//visibility:public"],
)