/*
This example shows how to combine two sets of key value pairs
*/
locals {
  script_directories = {
    base_paths = {
      host = "../scripts"
      vm   = "/opt/scripts"
    }

    suffixes = {
      base       = "/base"
      helpers    = "/helpers"
      installers = "/installers"
      toolset    = "/toolset"
    }
  }

  script_dirs = {
    for bk, bv in local.script_directories.base_paths : (bk) => {
      for sk, sv in local.script_directories.suffixes : (sk) => join("", [bv, sv])
    }
  }
}

output "example-1" {
  value = local.script_dirs
}
