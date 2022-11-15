# cco
A [CC: Tweaked](https://tweaked.cc) Operating System with a unique focus on security without sacrificing on features.

## Installation

```sh
wget run https://raw.githubusercontent.com/MokiyCodes/cco/main/install.lua
```

###### Development
Have `pnpm dev` running & want to test source modifications?<br/>
Run this instead:

```sh
wget run https://raw.githubusercontent.com/MokiyCodes/cco/main/install.lua devserver
```

*Note: This will error if you do not have a devserver running.*

## Recovering a lost password
You cannot recover a system with a lost password (if you enabled run as startup during installation), unless you somehow have access to the filesystem.

If you have access to the filesystem, simply remove startup.lua

###### Changing a password
Changing a password is possible, although it will reset any data encrypted using cco's encrytion & requires your old password.

1. Login
2. Go to the updater
3. Select No
4. Continue the rest of the setup
5. Done!