workspace(
    name = "bazel-experiments",
    managed_directories = {"@npm": ["node_modules"]},
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
# Nodejs rules
http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "0fad45a9bda7dc1990c47b002fd64f55041ea751fafc00cd34efb96107675778",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.5.0/rules_nodejs-5.5.0.tar.gz"],
)

load("@build_bazel_rules_nodejs//:repositories.bzl", "build_bazel_rules_nodejs_dependencies")

build_bazel_rules_nodejs_dependencies()

load("@rules_nodejs//nodejs:repositories.bzl", "nodejs_register_toolchains")

nodejs_register_toolchains(
  name = "nodejs",
  use_nvmrc = "//:.nvmrc",
)

load("@build_bazel_rules_nodejs//:index.bzl", "npm_install")

npm_install(
    name = "npm",
    package_json = "//:package.json",
    package_lock_json = "//:package-lock.json",
)

# Docker rules
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "27d53c1d646fc9537a70427ad7b034734d08a9c38924cc6357cc973fed300820",
    strip_prefix = "rules_docker-0.24.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.24.0/rules_docker-v0.24.0.tar.gz"],
)
load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load(
    "@io_bazel_rules_docker//nodejs:image.bzl",
    _nodejs_image_repos = "repositories",
)

_nodejs_image_repos()
