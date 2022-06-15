def chart_push(name, src, **kwargs):
  """Publishes Helm Chart

  The generated to push helm charts'.
  """
  native.genrule(
    name = name,
    srcs = [src],
    outs = ["log.txt"],
    cmd = "./$(location //tools/publish:publish) $< > $@",
    tools = ["//tools/publish:publish"],
    **kwargs
  )
