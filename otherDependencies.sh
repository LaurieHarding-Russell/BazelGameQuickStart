oggVorboisBuild="""
cc_library(
    name = "OggVorbois",
    hdrs = ["@OggVorbois//file"],
    visibility = ["//visibility:public"],
    strip_include_prefix = "/external/OggVorbois/file",
    include_prefix = "OggVorbois",
    linkstatic = True,
)
"""

oggVorboisWorkspace="""
http_file(
    name = "OggVorbois",
    downloaded_file_path = "OggVorbois.h",
    urls = ["https://raw.githubusercontent.com/nothings/stb/master/stb_vorbis.c"],
    sha256 = "4f4fcc760b4fe6961ea528f2a8ba9d91a888ab0e44dc1bdb779dae8efae0ebcd"
)
"""

OpenFBXWorspace="""
http_archive(
    name = "OpenFBX",
    urls = ["https://github.com/nem0/OpenFBX/archive/f94fcb1ab0ee618c3c9ca105836ed52102bbcd7c.zip"],
    strip_prefix = "OpenFBX-f94fcb1ab0ee618c3c9ca105836ed52102bbcd7c",
    build_file = "OpenFBX.BUILD",
    sha256 = "8502ddcabfdbfb9f7099a8f4cbb073ce851e25cf35322f7df716d814c741d09f"
)
"""

OpenFBXWorspaceBUILD="""
cc_library(
    name = "openFBX",
    srcs = [
        "src/miniz.c",
        "src/ofbx.cpp",
        "src/miniz.h",
        "src/ofbx.h",
    ],
    includes = ["src"],
    linkopts = ["-lGL", "-lGLU"],
    visibility = ["//visibility:public"]
)
"""