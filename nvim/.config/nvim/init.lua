local opt = vim.opt

opt.autochdir = true
opt.timeoutlen = 1000
opt.relativenumber = true
-- Activer le spell checking
opt.spell = true
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldenable = true
opt.foldtext = ""
-- Définir les langues du spell checking
opt.spelllang = { "en", "fr" }
opt.clipboard:append("unnamedplus")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.o.conceallevel = 1
vim.opt.conceallevel = 1
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

vim.keymap.set("n", "<C-k>", "<Cmd>wincmd k<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>wincmd j<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<Cmd>wincmd h<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>wincmd l<CR>", { noremap = true, silent = true })
-- Déplacer une ligne vers le bas
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, silent = true })
-- Déplacer une ligne vers le haut
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Split vertical avec '|'
vim.keymap.set("n", "|", ":vsplit<CR>", { noremap = true, silent = true })

-- Split horizontal avec '-'
vim.keymap.set("n", "-", ":split<CR>", { noremap = true, silent = true })

vim.wo.number = true

vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{ import = "plugins" },
	{ import = "lsp" },
	{ import = "debugging" },
})

vim.cmd([[colorscheme eldritch]])

require("config.keymaps")

-- Paste images
-- I use a Ctrl keymap so that I can paste images in insert mode
-- I tried using <C-v> but duh, that's used for visual block mode
-- so don't do it
vim.keymap.set({ "n", "v", "i" }, "<C-a>", function()
	-- The image needs to be converted to the format I use, which usually is AVIF
	-- and it takes a few seconds, a lot of time I don't know if it's being pasted
	-- or not, so I like seeing this message to know I pressed the correct keymap
	print("PROCESSING IMAGE BEFORE PASTING...")
	-- I had to add a 100ms delay because the message above was not shown
	vim.defer_fn(function()
		-- Call the paste_image function from the Lua API
		-- Using the plugin's Lua API (require("img-clip").paste_image()) instead of the
		-- PasteImage command because the Lua API returns a boolean value indicating
		-- whether an image was pasted successfully or not.
		-- The PasteImage command does not
		-- https://github.com/HakonHarnes/img-clip.nvim/blob/main/README.md#api
		local pasted_image = require("img-clip").paste_image()
		if pasted_image then
			-- "Update" saves only if the buffer has been modified since the last save
			vim.cmd("update")
			print("Image pasted and file saved")
			-- Only if updated I'll refresh the images by clearing them first
			-- I'm using [[ ]] to escape the special characters in a command
			require("image").clear()
			-- vim.cmd([[lua require("image").clear()]])
			-- Switch to the line below
			vim.cmd("normal! o")
			-- Switch back to command mode or normal mode
			vim.cmd("startinsert")
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("- ", true, false, true), "i", true)
		-- Reloads the file to reflect the changes
		-- I commented this edit because I was getting error when pasting images:
		-- msg_show E5108: Error executing lua: vim/_editor.lua:0: nvim_exec2()..DiagnosticChanged
		-- Autocommands for "*": Vim(append):Error executing lua callback:
		-- ...vim-treesitter-context/lua/treesitter-context/render.lua:270: E565: Not allowed to change text or change window
		-- vim.cmd("edit!")
		else
			print("No image pasted. File not updated.")
		end
	end, 100)
end, { desc = "[P]Paste image from system clipboard" })

-------------------------------------------------------------------------------
--                           Folding section
-------------------------------------------------------------------------------

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
	-- Move to the top of the file
	vim.cmd("normal! gg")
	-- Get the total number of lines
	local total_lines = vim.fn.line("$")
	for line = 1, total_lines do
		-- Get the content of the current line
		local line_content = vim.fn.getline(line)
		-- "^" -> Ensures the match is at the start of the line
		-- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
		-- "%s" -> Matches any whitespace character after the "#" characters
		-- So this will match `## `, `### `, `#### ` for example, which are markdown headings
		if line_content:match("^" .. string.rep("#", level) .. "%s") then
			-- Move the cursor to the current line
			vim.fn.cursor(line, 1)
			-- Fold the heading if it matches the level
			if vim.fn.foldclosed(line) == -1 then
				vim.cmd("normal! za")
			end
		end
	end
end

-- Keymap for folding all level 1 or higher headings (e.g., ##, ###, ####)
vim.keymap.set("n", "zh", function()
	fold_headings_of_level(1) -- Fold all level 1 and above headings (##, ###, ####)
end, { desc = "[P]Fold all level 1 and above headings" })

-- Keymap for folding all level 2 or higher headings (e.g., ##, ###, ####)
vim.keymap.set("n", "zj", function()
	fold_headings_of_level(2) -- Fold all level 2 and above headings (##, ###, ####)
end, { desc = "[P]Fold all level 2 and above headings" })

-- Keymap for folding all level 3 or higher headings (e.g., ###, ####)
vim.keymap.set("n", "zk", function()
	fold_headings_of_level(3) -- Fold all level 3 and above headings (###, ####)
end, { desc = "[P]Fold all level 3 and above headings" })

-- Keymap for folding all level 4 or higher headings (e.g., ###, ####)
vim.keymap.set("n", "zl", function()
	fold_headings_of_level(4) -- Fold all level 4 and above headings (###, ####)
end, { desc = "[P]Fold all level 4 and above headings" })

-- Function to unfold all headings of a specific level
local function unfold_headings_of_level(level)
	-- Move to the top of the file
	vim.cmd("normal! gg")
	-- Get the total number of lines
	local total_lines = vim.fn.line("$")
	for line = 1, total_lines do
		-- Get the content of the current line
		local line_content = vim.fn.getline(line)
		-- "^" -> Ensures the match is at the start of the line
		-- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
		-- "%s" -> Matches any whitespace character after the "#" characters
		-- So this will match `## `, `### `, `#### ` for example, which are markdown headings
		if line_content:match("^" .. string.rep("#", level) .. "%s") then
			-- Move the cursor to the current line
			vim.fn.cursor(line, 1)
			-- Unfold the heading if it matches the level
			if vim.fn.foldclosed(line) ~= -1 then
				vim.cmd("normal! zO")
			end
		end
	end
end

-- Keymap for unfolding all level 1 or higher headings (e.g., ##, ###, ####)
vim.keymap.set("n", "zH", function()
	unfold_headings_of_level(1) -- Unfold all level 1 and above headings (##, ###, ####)
end, { desc = "[P]Unfold all level 1 and above headings" })

-- Keymap for unfolding all level 2 or higher headings (e.g., ##, ###, ####)
vim.keymap.set("n", "zJ", function()
	unfold_headings_of_level(2) -- Unfold all level 2 and above headings (##, ###, ####)
end, { desc = "[P]Unfold all level 2 and above headings" })

-- Keymap for unfolding all level 3 or higher headings (e.g., ###, ####)
vim.keymap.set("n", "rK", function()
	unfold_headings_of_level(3) -- Unfold all level 3 and above headings (###, ####)
end, { desc = "[P]Unfold all level 3 and above headings" })

-- Keymap for unfolding all level 4 or higher headings (e.g., ###, ####)
vim.keymap.set("n", "rL", function()
	unfold_headings_of_level(4) -- Unfold all level 4 and above headings (###, ####)
end, { desc = "[P]Unfold all level 4 and above headings" })

-- Activer le pliage automatique pour les fichiers Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- Activer le mode de pliage par syntaxe
		--vim.opt_local.foldmethod = "expr"
		--vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()" -- Utilise Tree-sitter pour le pliage
		--vim.opt_local.foldenable = true  -- Activer le pliage automatiquement
		--vim.opt_local.foldlevel = 2      -- Pliage par défaut jusqu'au niveau 1

		-- Plie les niveaux spécifiques au démarrage
		vim.defer_fn(function()
			fold_headings_of_level(2) -- Appel direct à ta fonction définie précédemment
		end, 100)
	end,
})

-- Toggle le pliage avec Entrée sur un titre Markdown
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "<CR>", function()
			local line = vim.fn.getline(".") -- Récupère la ligne courante
			if line:match("^%s*#+%s") then -- Vérifie si la ligne est un titre Markdown
				vim.cmd("normal! za") -- Toggle le pliage
			else
				vim.cmd("normal! <CR>") -- Sinon, comportement normal de Entrée
			end
		end, { buffer = true, desc = "Toggle le pliage sur les titres Markdown" })
	end,
})

local function update_markdown_links(old_title, new_title)
	local workspace_path = vim.fn.getcwd() -- Récupère le chemin du dossier courant
	-- Regex améliorée pour capturer les liens avec ou sans alias
	local old_link = "%[%[" .. vim.pesc(old_title) .. "%s*|?%s*([^%]]+)%s*%]?%]%]"

	-- Récupère tous les fichiers Markdown dans le workspace
	local find_cmd = string.format("find %s -type f -name '*.md'", vim.fn.shellescape(workspace_path))
	local handle = io.popen(find_cmd)
	if not handle then
		print("❌ Impossible d'exécuter la recherche de fichiers Markdown.")
		return
	end

	local result = handle:read("*a")
	handle:close()

	if result == "" then
		print("ℹ️ Aucun fichier Markdown trouvé dans le workspace.")
		return
	end

	-- Parcourt chaque fichier Markdown
	for file in result:gmatch("[^\n]+") do
		local file_handle = io.open(file, "r")
		if file_handle then
			local content = file_handle:read("*a")
			file_handle:close()

			-- Remplacer les liens Markdown, en préservant les alias
			local updated_content, replacements = content:gsub(old_link, function(alias)
				-- Si un alias est trouvé, il sera capturé dans `alias`
				if alias and alias ~= "" then
					print("🔍 Lien trouvé avec alias : " .. alias)
					-- Remplacer le titre tout en conservant l'alias
					return "[[" .. new_title .. " |" .. alias .. "]]"
				else
					print("🔍 Lien trouvé sans alias")
					-- Si pas d'alias, simplement mettre à jour le titre
					return "[[" .. new_title .. "]]"
				end
			end)

			if replacements > 0 then
				local write_handle = io.open(file, "w")
				if write_handle then
					write_handle:write(updated_content)
					write_handle:close()
					print("✅ Liens mis à jour dans : " .. file)
				else
					print("❌ Impossible d'écrire dans le fichier : " .. file)
				end
			end
		else
			print("❌ Impossible de lire le fichier : " .. file)
		end
	end
end

-- Commande pour renommer un fichier Markdown avec mise à jour des liens
vim.api.nvim_create_user_command("ObsidianRenameFilenameAndLink", function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local in_front_matter = false
	local title = nil

	-- Trouver le premier H1 après le front matter
	for _, line in ipairs(lines) do
		if line:match("^%-%-%-$") then
			in_front_matter = not in_front_matter
		elseif not in_front_matter and line:match("^#%s+(.+)$") then
			title = line:match("^#%s+(.+)$")
			break
		end
	end

	if title then
		local sanitized_title = title
		if sanitized_title ~= "" then
			local current_file = vim.fn.expand("%:p")
			local current_buf = vim.fn.bufnr()
			local old_title = vim.fn.fnamemodify(current_file, ":t:r") -- Ancien nom du fichier (sans extension)
			local new_file = vim.fn.fnamemodify(current_file, ":h") .. "/" .. sanitized_title .. ".md"

			if current_file ~= new_file then
				vim.cmd("write")
				-- Mettre à jour les liens avant renommage
				update_markdown_links(old_title, sanitized_title)

				local success, err = os.rename(current_file, new_file)
				if success then
					vim.cmd("bdelete! " .. current_buf)
					vim.cmd("edit " .. vim.fn.fnameescape(new_file))
					print("✅ Fichier renommé en : " .. new_file)
				else
					print("❌ Erreur lors du renommage : " .. err)
				end
			end
		end
	else
		print("⚠️ Aucun titre H1 trouvé après le Front Matter.")
	end
end, { desc = "Met à jour les liens Markdown avant de renommer le fichier" })
