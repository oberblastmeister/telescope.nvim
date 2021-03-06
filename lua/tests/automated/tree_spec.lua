local process = require('telescope.builtin.menu').process
local process_root = require('telescope.builtin.menu').process_root

local eq = function(a, b)
  assert.are.same(a, b)
end

describe('preprocess function', function()
  it('should preprocess simple', function()
    local tree = {
      {
        "top level leaf",
        "another top level leaf",
      },
    }

    local expected = {
      {leaf = "top level leaf", conf = {}},
      {leaf = "another top level leaf", conf = {}},
    }

    local res = process(tree)
    eq(expected, res)
  end)

  it('should preprocess with configuration in the root', function()
    local tree = {
      {
        "top level leaf",
        "another top level leaf",
      },
      title = 'test menu',
      callback = print,
    }

    local expected = {
      branch_name = "root",
      branches = {
        {leaf = "top level leaf", conf = {}},
        {leaf = "another top level leaf", conf = {}},
      },
      conf = {
        title = 'test menu',
        callback = print,
      }
    }

    local res = process_root(tree)

    eq(expected, res)
  end)

  it('should preprocess with two levels', function()
    local tree = {
      {
        "top level leaf",
        "another top level leaf",
        ["a node"] = {
          {
            "second level leaf",
            "another second level leaf",
          }
        }
      },
    }

    local expected = {
        {leaf = "top level leaf", conf = {}},
        {leaf = "another top level leaf", conf = {}},
        {
          branch_name = "a node",
          branches = {
            {leaf = "second level leaf", conf = {}},
            {leaf = "another second level leaf", conf = {}},
            {leaf = "..", conf = {}},
          },
          conf = {}
        },
    }

    local res = process(tree)

    eq(expected, res)
  end)

  it('should preprocess with two levels and conf', function()
    local tree = {
      {
        "top level leaf",
        "another top level leaf",
        ["a node"] = {
          {
            "second level leaf",
            "another second level leaf",
          },
        }
      },
    }

    local expected = {
      {leaf = "top level leaf", conf = {}},
      {leaf = "another top level leaf", conf = {}},
      {
        branch_name = "a node",
        branches = {
          {leaf = "second level leaf", conf = {}},
          {leaf = "another second level leaf", conf = {}},
          {leaf = "..", conf = {}},
        },
        conf = {}
      },
    }

    local res = process(tree)

    eq(expected, res)
  end)
end)
