### Create Custom Executable Bash Scripts & Run with CLI

1. Create a `~/bin` directory
2. Copy text: `export PATH="$PATH:$HOME/bin"` in `~/.bash_profile`
3. Move file: `<custom_script>.sh` into the `~/bin` directory
4. Give the script executable rights with: `sudo chmod +x <custom_script>.sh`
5. Run: `source ~/.bash_profile` to reload your profile with the executable script
6. Now you can run your executable script from the command line by name

#### The `mkvtoolnix` Library

  * mkvinfo
  * mkvpropedit
  * mkvmerge
  * ...