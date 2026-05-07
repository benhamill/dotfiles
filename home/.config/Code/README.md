# VSCode Configuration

VSCode settings and keybindings for syncing across machines.

## Platform-specific paths

These files live in different locations per platform:

- **Linux**: `~/.config/Code/User/` (symlinked via Homesick)
- **macOS**: `~/Library/Application Support/Code/User/`
- **Windows**: `%APPDATA%\Code\User\` (e.g., `C:\Users\YourName\AppData\Roaming\Code\User\`)

## Setup

### Linux
Homesick will automatically symlink `~/.config/Code/User/` to this directory.

### macOS
After pulling dotfiles, manually symlink:
```bash
mkdir -p ~/Library/Application\ Support/Code/User
ln -sf ~/.homesick/repos/dotfiles/home/.config/Code/User/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -sf ~/.homesick/repos/dotfiles/home/.config/Code/User/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
```

### Windows
Manually copy files to `%APPDATA%\Code\User\` or use mklink:
```powershell
mklink "%APPDATA%\Code\User\settings.json" "\\wsl$\Ubuntu\home\ben\.homesick\repos\dotfiles\home\.config\Code\User\settings.json"
mklink "%APPDATA%\Code\User\keybindings.json" "\\wsl$\Ubuntu\home\ben\.homesick\repos\dotfiles\home\.config\Code\User\keybindings.json"
```
