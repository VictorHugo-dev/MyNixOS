{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      # Core LSP & Syntax
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      
      # Completion engine
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      # AI
      copilot-vim

      # UI & Navigation
      telescope-nvim
      plenary-nvim
      lualine-nvim
      nvim-web-devicons
      gitsigns-nvim
      
      # File Tree
      neo-tree-nvim
      nui-nvim
    ];

    extraLuaConfig = ''
      -- 1. General Settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
      vim.opt.expandtab = true
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
      vim.opt.termguicolors = true
      vim.opt.updatetime = 250
      vim.g.mapleader = " "
      
      -- 2. Status Line
      require('lualine').setup {
        options = { theme = 'gruvbox' }
      }

      -- 3. Syntax Highlighting
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- 4. File Tree (Neo-tree)
      require("neo-tree").setup({
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
      })
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { silent = true })

      -- 5. Fuzzy Finder
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

      -- 6. Completion
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })

      -- 7. Git Integration
      require('gitsigns').setup()

      -- 8. Copilot
      -- No lua setup required for copilot.vim, but we can set a keymap
      -- Disabling standard tab map so it doesn't conflict with cmp if needed
      vim.g.copilot_no_tab_map = true
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })

      -- 9. LSP Configuration (Version Agnostic Fix)
      local servers = { 'pyright', 'rust_analyzer', 'ts_ls', 'lua_ls' }

      if vim.lsp.enable then
        -- Neovim 0.11+
        for _, server in ipairs(servers) do
          vim.lsp.enable(server)
        end
      else
        -- Neovim < 0.11
        local lspconfig = require('lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        for _, server in ipairs(servers) do
          lspconfig[server].setup({
            capabilities = capabilities,
          })
        end
      end
    '';
  };
}