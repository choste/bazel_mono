load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary")
load("//tools/jest:jest.bzl", "jest_test")

nodejs_binary(
    name = "app",
    chdir = package_name(),
    entry_point = ":index.js",
)

jest_test(
    name = "test",
    srcs = ["index.test.js"],
    jest_config = ":jest.config.js",
    deps = []
)