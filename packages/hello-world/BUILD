load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary")

nodejs_binary(
    name = "hello-world",
    chdir = package_name(),
    entry_point = ":index.js",
)