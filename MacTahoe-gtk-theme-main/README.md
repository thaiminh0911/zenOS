<img src="Tahoe.png" alt="Tahoe" align="right" /> MacTahoe GTK Theme
======

A macOS Tahoe like theme for Linux GTK Desktops

Based on WhiteSur GTK Theme:
[https://github.com/vinceliuice/WhiteSur-gtk-theme](https://github.com/vinceliuice/WhiteSur-gtk-theme)







### screenshot
<p align="center"> <img src="screenshot01.jpeg"/> </p>

## Donate

If you like my project, you can buy me a coffee, many thanks ❤️ !

<span class="paypal"><a href="https://www.paypal.me/vinceliuice" title="Donate to this project using Paypal"><img src="https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png" alt="PayPal donate button" /></a></span>

# Installation is easy!
<details> <summary> Required dependencies <b>(click to open)</b> </summary>

### "Install from source" deps
- sassc
- libglib2.0-dev-bin     `ubuntu 20.04`
- libglib2.0-dev         `ubuntu 18.04` `debian 10.03` `linux mint 19`
- libxml2-utils          `ubuntu 18.04` `debian 10.03` `linux mint 19`
- glib2-devel            `Fedora` `Redhat`

### Misc deps
- imagemagick            `(optional for GDM theme tweak)`
- dialog                 `(optional for installation in dialog mode)`
- optipng                `(optional for asset rendering)`
- inkscape               `(optional for asset rendering)`

Don't worry, MacTahoe installer already provides all of those dependencies.
</details>

<details> <summary> Recommended GNOME Shell extensions <b>(click to open)</b> </summary>

- [user-themes](https://extensions.gnome.org/extension/19/user-themes/) to enable gnome-shell theme (and not just the application theme)
- [dash-to-dock](https://extensions.gnome.org/extension/307/dash-to-dock)
- [blur-my-shell](https://extensions.gnome.org/extension/3193/blur-my-shell)

</details>

## Quick install

### Installing from source

1. Run `git clone https://github.com/vinceliuice/MacTahoe-gtk-theme.git --depth=1`

2. Run `./install.sh` to install the default MacTahoe GTK theme pack.

### Uninstall

- uninstall Gtk themes: `./install.sh -r`
- uninstall GDM theme: `sudo ./tweaks.sh -g -r`
- uninstall Firefox theme: `./tweaks.sh -f -r`
- uninstall Flatpak Gtk themes: `./tweaks.sh -F -r`

## There's so many customizations you can do!
Usage:  `./install.sh [OPTIONS...]`

<details> <summary> Options <b>(click to open)</b> </summary>

```bash

OPTIONS:
  -d, --dest DIR
   Set destination directory. Default is '/home/[USER_NAME]/.themes'

  -n, --name NAME
   Set theme name. Default is 'MacTahoe'

  -o, --opacity [normal|solid]
   Set theme opacity variants. Repeatable. Default is all variants

  -c, --color [light|dark]
   Set theme color variants. Repeatable. Default is all variants

  -a, --alt [normal|alt|all]
   Set window control buttons variant. Repeatable. Default is 'normal'

  -t, --theme [default|blue|purple|pink|red|orange|yellow|green|grey|all]
   Set theme accent color. Repeatable. Default is Tahoe-like theme

  -s, --scheme [standard|nord]
   Set theme colorscheme style. Repeatable. Default is 'standard'

  -b, --blur 
   Install blur verison (more transparent). Blur-my-shell extension required

  -l, --libadwaita 
   Install theme into gtk4.0 config for libadwaita. Default is dark version

  -f, --fixed 
   Install fixed accent color version. Default is adaptive version

  -HD, --highdefinition 
   Set to High Definition size. Default is laptop size

  --shell, --gnomeshell 
   Tweaks for gnome-shell. Options:

     1. -i, -icon [apple|simple|gnome|ubuntu|tux|arch|manjaro|fedora|debian|void|opensuse|popos|mxlinux|zorin|budgie|gentoo]
     Set gnome-shell panel 'Activities' icon. Default is 'standard'

     2. -p, -panelopacity [default|30|45|60|75]
     Set gnome-shell panel transparency. Default is 15%

     3. -h, -panelheight [default|smaller|bigger]
     Set gnome-shell panel height size. Default is 32px

     4. -sf, -smallerfont 
     Set gnome-shell font size to smaller (10pt). Default is 11pt

     5. normal, -normal 
     Set gnome-shell show apps button style to normal. Default is macOS icon

  --round, --roundedmaxwindow 
   Set maximized window to rounded. Default is square

  --darker, --darkercolor 
   Install darker 'MacTahoe' dark themes. 

  --silent-mode 
   Meant for developers: ignore any confirm prompt and params become more strict. 

  -r, --remove, -u, --uninstall 
   Remove all installed MacTahoe themes. 

  -h, --help 
   Show this help. 

```

</details>

## Fix for libadwaita (not perfect)

<details> <summary> Details <b>(click to open)</b> </summary>

  Since the release of `Gnome 43.0`, more and more built-in apps use `libadwaita` now, and libadwaita does not support custom themes, which means we cannot change the appearance of app using libadwaita through `gnome-tweaks` or `dconf-editor`. For users who love custom themes, it’s really sucks!

  Anyway if anybody who still want to custom themes we can only do this way:

  that is to use the `theme file` to overwrite the `gtk-4.0 configuration file`. The result is that only Fixed making all gtk4 apps use one theme and cannot be switched (even can not switch to dark mode) If you want to change a theme, you can only re-overwrite the `gtk-4.0 configuration file` with a new theme, I know this method is not perfect, But at the moment it is only possible to continue using themes for libadwaita's apps ...

</details>

Run this command to install `MacTahoe` into `gtk-4.0 configuration folder` ($HOME/.config/gtk-4.0)

```bash
./install.sh -l                # Default is the normal dark theme
./install.sh -l -c light       # install light theme for libadwaita
```

## <p align="center"> <b> Change theme color and accent </b> </p>
<p align="center"> <img src="https://github.com/vinceliuice/WhiteSur-gtk-theme/blob/pictures/pictures/colors-themes.png"/> </p>

#### - Install theme accent
Parameter: `--theme` `-t` (repeatable)

Example:

```bash
./install.sh -t red            # install red theme accent only
./install.sh -t red -t green   # install red and green theme accents
./install.sh -t all            # install all available theme accents
```

## <p align="center"> <b> Blur my shell version </b> </p>

#### - My blur-my-shell settings

<p align="center"> <img src="blur-my-shell.png"/> </p>


NOTE: If you have issues with blur, then:
1. Make sure you have the correct Blur My Shell settings
2. Disable ALL extensions except for Blur My Shell, Dash-To-Dock and User Themes, and see if it works.
3. If it works, the problem is an incompatibility with one of your other extensions. Enable them one-by-one to see the culprit.
4. If it still doesn't, make sure HDR is disabled. This is a known issue with Blur-My-Shell
5. If you still have problems, open an issue. Do NOT open it in Blur My Shell's repository unless confirmed it's a problem with the extension!

The following extensions are known to be incompatible (as of now):
- Rounded Window Corners (reborn)
- Desaturate Windows
- "AppIndicator and KStatusNotifierItem Support"

#### - Install blur-my-shell version

[blur-my-shell](https://extensions.gnome.org/extension/3193/blur-my-shell)

Parameter: `--blur` `-b` (repeatable)

Example:

```bash
./install.sh -b -l            # install blur verison of libadwaita
```

<p align="center"> <img src="screenshot02.jpeg"/> </p>

## <p align="center"> <b> Explore more customization features! </b> </p>
You can run `./install.sh -h` to explore more customization features we have
like changing panel opacity, theme opacity (normal and solid variant), window
control button variant, etc.

# <p align="center"> <b> Let's tweak! </b> </p>
Usage:  `./tweaks.sh [OPTIONS...]`

<details> <summary> Options <b>(click to open)</b> </summary>

```bash

 Tweaks for GDM theme. options

  -g, --gdm    Without options default GDM theme will install... 

      1. -i, -icon [apple|simple|gnome|ubuntu|tux|arch|manjaro|fedora|debian|void|opensuse|popos|mxlinux|zorin|budgie|gentoo]   Set GDM panel 'Activities' icon Default is 'standard'

      2. -b, -background [default|blank|IMAGE_PATH]   Set GDM background image Default is MacOS wallpaper

      3. -p, -panelopacity [default|30|45|60|75]   Set GDM panel transparency Default is 15%

      4. -h, -panelheight [default|smaller|bigger]   Set GDM panel height size Default is 32px

      5. -sf, -smallerfont    Set GDM font size to smaller (10pt) Default is 11pt

      6. -nd, -nodarken    Don't darken 'MacTahoe' GDM theme background image 

      7. -nb, -noblur    Don't blur 'MacTahoe' GDM theme background image 

      8.  -o, --opacity [normal|solid]   Set 'MacTahoe' GDM theme opacity variants Default is 'normal'

      9.  -c, --color [Light|Dark]   Set 'MacTahoe' GDM theme color variants Default is 'dark'

      10. -t, --theme [default|blue|purple|pink|red|orange|yellow|green|grey]   Set 'MacTahoe' GDM theme accent color Default is 'blue'

      11. -s, --scheme [standard|nord]   Set 'MacTahoe' GDM theme colorscheme style Default is 'standard'

   
 Tweaks for firefox. options

  -f, --firefox         [default|adaptive]   Without options default theme will install...   Options:

      1. default       default version  

      2. adaptive       Adaptive color version   You need install adaptive-tab-bar-colour plugin first   https://addons.mozilla.org/firefox/addon/adaptive-tab-bar-colour/

  -e, --edit-firefox [default|adaptive]
   Edit 'MacTahoe' theme for Firefox settings and also connect the theme to the current Firefox profiles. 

   
 Others. options

  -F, --flatpak Support options: [-o, -c, -t...]   Connect 'MacTahoe' theme to Flatpak Without options will only install default themes

      1.  -o, --opacity [normal|solid]   Set 'MacTahoe' flatpak theme opacity variants Default is 'normal'

      2.  -c, --color [Light|Dark]   Set 'MacTahoe' flatpak theme color variants Default is 'light'

      3.  -t, --theme [default|blue|purple|pink|red|orange|yellow|green|grey]   Set 'MacTahoe' flatpak theme accent color Default is 'blue'

      4.  -s, --scheme [standard|nord]   Set 'MacTahoe' flatpak theme colorscheme style Default is 'standard'

  -d, --dash-to-dock 
   Fixed Dash to Dock theme issue. 

  -r, --remove, --revert 
   Revert to the original themes, do the opposite things of install and connect. 

  --silent-mode 
   Meant for developers: ignore any confirm prompt and params become more strict. 

  -h, --help 
   Show this help. 

```

</details>

## <p align="center"> <b> Other recommended stuff </b> </p>
### <p align="center"> <b> MacTahoe Icon Theme </b> </p>
<p align="center"> <a href="https://github.com/vinceliuice/MacTahoe-icon-theme">
  <img src="https://github.com/vinceliuice/MacTahoe-icon-theme/blob/main/preview.png"/>
</a> </p>
<br>
<p align="center"> <a href="https://github.com/vinceliuice/MacTahoe-icon-theme">
  <img src="https://github.com/vinceliuice/WhiteSur-gtk-theme/blob/pictures/pictures/download-button.svg"/>
</a> </p>
<br>

### <p align="center"> <b> MacTahoe Wallpapers </b> </p>
<p align="center"> <a href="https://github.com/vinceliuice/MacTahoe-gtk-theme/tree/main/wallpaper">
  <img class="image" src="https://github.com/vinceliuice/MacTahoe-gtk-theme/blob/main/wallpaper/MacTahoe-day.jpeg"/>
</a> </p>
<br>
<p align="center"> <a href="https://github.com/vinceliuice/MacTahoe-gtk-theme/tree/main/wallpaper">
  <img src="https://github.com/vinceliuice/WhiteSur-gtk-theme/blob/pictures/pictures/download-button.svg"/>
</a> </p>
<br>

## There's more themes you can try!
### <p align="center"> <b> Install and edit Firefox theme </b> </p>

<p align="center"> <a href="other/firefox">
<img src="other/firefox/preview.png"/>
</a> </p>

#### - [Install Firefox theme](other/firefox)
Parameter: `--firefox` `-f`

Example: `./tweaks.sh -f`

#### - Edit Firefox theme
Parameter: `--edit-firefox` `-e`

Example:

```bash
./tweaks.sh -e           # edit the installed Firefox theme
./tweaks.sh -f -r        # remove installed Firefox theme
./tweaks.sh -f monterey  # install Monterey Firefox theme
```

##

### <p align="center"> <b> Install and customize GDM theme </b> </p>
<p align="center"> <img src="gdm-theme.png"/> </p>

#### - Install GDM theme
Parameter: `--gdm` `-g` (requires to be run as root)

Example: `sudo ./tweaks.sh -g`

#### - Change the background
Parameter: `--background` `-b`

Example:

```bash
sudo ./tweaks.sh -g -b "my picture.jpg" # use the custom background
sudo ./tweaks.sh -g -b default          # use the default background
sudo ./tweaks.sh -g -b blank            # make it blank
```

#### - Don't darken the background
Parameter: `--nodarken` `-nd`

Example:

```bash
sudo ./tweaks.sh -g -nd                          # darken the default background
sudo ./tweaks.sh -g -nd -b "wallpapers/snow.jpg" # darken the custom background
```

#### - Don't blur the background
Parameter: `--noblur` `-nb`

Example:

```bash
sudo ./tweaks.sh -g -nb                           # don't blur the default background
sudo ./tweaks.sh -g -nb -b "wallpapers/rocks.jpg" # don't blur the custom background
```

#### - Do more GDM customizations
You can do [the similar customization features in `./install.sh`](#theres-so-many-customizations-you-can-do)
like changing theme color (dark and light variant) and accent, GNOME Shell
'Activities' icon, etc. related to GDM. Run `./tweaks.sh -h` to explore!

##

### <p align="center"> <b> Fix for Flatpak </b> </p>

#### 1. Run command to fix it

```sh
sudo flatpak override --filesystem=xdg-config/gtk-3.0 && sudo flatpak override --filesystem=xdg-config/gtk-4.0
```

If you use flatpak apps, you can run this to fix theme issue

#### 2. Connect MacTahoe theme to Flatpak (gtk 3.0) (Snap not support)

Parameter: `--flatpak` `-F`

Example: `./tweaks.sh -F`

## Technical details and getting involved
Please go read [CONTRIBUTING.md](.github/CONTRIBUTING.md) for more info
