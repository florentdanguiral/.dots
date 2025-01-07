return {
  'L3MON4D3/LuaSnip',
  version = "v2.*",
  config = function()
    local ls = require("luasnip")
    local t = ls.text_node
    local i = ls.insert_node
    local s = ls.snippet

    -- Helper function to create code block snippets
    local function create_code_block_snippet(lang)
      return s({
        trig = lang,
        name = "Codeblock",
        desc = lang .. " codeblock",
      }, {
        t({ "```" .. lang, "" }),
        i(1),
        t({ "", "```" }),
      })
    end

    -- Define languages for code blocks
    local languages = {
      "txt",
      "lua",
      "sql",
      "go",
      "regex",
      "bash",
      "markdown",
      "markdown_inline",
      "yaml",
      "json",
      "jsonc",
      "cpp",
      "csv",
      "java",
      "javascript",
      "python",
      "dockerfile",
      "html",
      "css",
      "templ",
      "php",
    }

    -- Generate snippets for all languages
    local code_block_snippets = {}
    for _, lang in ipairs(languages) do
      table.insert(code_block_snippets, create_code_block_snippet(lang))
    end

    -- Add code block snippets to markdown filetype
    ls.add_snippets("markdown", code_block_snippets)

    -- Custom snippets
    ls.add_snippets("markdown", {
      s("figure", {
        t({
          "<figure>",
          '<img src="" loading="lazy" />',
          "<figcaption>",
          "<center>",
        }),
        i(1, "Lorem"),
        t({
          "</center>",
          "</figcaption>",
          "</figure>",
        }),
      }),
    })

  end,
}

