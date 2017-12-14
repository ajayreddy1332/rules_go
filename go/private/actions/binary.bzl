# Copyright 2014 The Bazel Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load("@io_bazel_rules_go//go/private:common.bzl",
    "declare_file",
)

def emit_binary(ctx, go_toolchain,
    name="",
    source = None,
    gc_linkopts = [],
    x_defs = {},
    wrap = None):
  """See go/toolchains.rst#binary for full documentation."""

  if name == "": fail("name is a required parameter")

  archive = go_toolchain.actions.archive(ctx, go_toolchain, source)
  executable = declare_file(ctx, name=name, ext=go_toolchain.data.extension, mode=source.mode)
  go_toolchain.actions.link(ctx,
      go_toolchain = go_toolchain,
      archive=archive,
      executable=executable,
      gc_linkopts=gc_linkopts,
      x_defs=x_defs,
  )

  return archive, executable
