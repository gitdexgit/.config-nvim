-- File: init.lua

-- --- SMART CLIPBOARD SETUP ---
-- Goal: Use a highly compatible method (OSC 52) for remote/headless sessions,
-- but rely on Neovim's auto-detection for local graphical sessions.

-- 1. Check environment variables
local is_termux = os.getenv("PREFIX") == "/data/data/com.termux/files/usr"
local display_is_unset = os.getenv("DISPLAY") == nil or os.getenv("DISPLAY") == ""

-- 2. Define the preferred clipboard provider
local preferred_clipboard_provider = nil

-- If we are in Termux OR if we are running without a graphical display (typical for SSH/TUI)
if is_termux or display_is_unset then
    -- Force OSC 52. This is the best solution for SSH/Termux/headless TUI sessions
    -- as it synchronizes with the host machine's clipboard.
    preferred_clipboard_provider = 'osc52'

    -- NOTE: If your main computer terminal (where you SSH from) does NOT support OSC 52,
    -- this will silently fail. But for modern terminals, this is the safest bet.

    -- Alternative check: You could check for $SSH_CLIENT or $TMUX here as well
    -- if those variables reliably indicate a remote session for you.
else
    -- Local machine (e.g., Mac, Linux Desktop) with a graphical environment.
    -- We leave this nil so Neovim auto-detects 'xclip', 'pbcopy', etc., which are usually
    -- faster and more reliable than OSC 52 locally.
    preferred_clipboard_provider = nil
end

-- 3. Apply the configuration
if preferred_clipboard_provider then
    -- Set the clipboard provider override
    vim.g.clipboard = preferred_clipboard_provider
end

-- Always set 'unnamedplus' to use the system clipboard registers by default
-- (This ensures yank/paste uses the system clipboard regardless of the provider)
-- Oh this is interesting... regardless of provider huh this is cool but like I don't want this no? maybe
-- vim.opt.clipboard:append("unnamedplus")

-- --- END SMART CLIPBOARD SETUP ---
