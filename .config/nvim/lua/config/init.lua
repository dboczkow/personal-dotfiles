-- Główny plik konfiguracyjny (entry point) dla Neovim.
-- Jego zadaniem jest załadowanie pozostałych plików konfiguracyjnych w odpowiedniej kolejności.

require("config.pmanager") -- Menedżer pluginów
require("config.appearance") -- Wygląd
require("config.options") -- Główne opcje
require("config.lsp") -- Konfiguracja LSP
require("config.filetype_detector") -- Wykrywanie typów plików
