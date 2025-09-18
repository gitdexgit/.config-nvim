    require("project_nvim").setup {
      -- By default, this is: { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" }
      -- Let's add more patterns for different project types!
      patterns = {
        ".git",
        "Makefile",
        "package.json",
        "requirements.txt", -- Python
        "Cargo.toml",       -- Rust
        "go.mod",           -- Go
        "pom.xml",          -- Maven/Java
      },
    }
