load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary")
load("//tools/jest:jest.bzl", "jest_test")
load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_image",
    "container_push"
)
load("@io_bazel_rules_docker//nodejs:image.bzl", "nodejs_image")

nodejs_binary(
    name = "app",
    chdir = package_name(),
    data = [
        "@npm//express",
    ],
    entry_point = ":src/index.js",
)

nodejs_image(
  name = "image",
  entry_point = "src/index.js",
  data = ["app"],
  include_node_repo_args = False,
  binary = "app",
  node_repository_name = "nodejs_linux_amd64",
  ports = ["3000"]
)

jest_test(
  name = "test",
  srcs = glob(["src/*"]),
  jest_config = ":jest.config.js",
  deps = [
    "@npm//express",
    "@npm//supertest",
  ]
)

container_push(
  name = "publish",
  format = "Docker",
  registry = "us-west1-docker.pkg.dev",
  repository = "bazel-352318/bazel/express",
  image = ":image",
  tag = "dev",
)
