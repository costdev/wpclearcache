# WP Clear Cache

- **Description:** Frees reclaimable slab objects (includes dentries and inodes) when WordPress updates a plugin or theme.
- **Author:**      WordPress Core Contributors
- **Author URI:**  https://make.wordpress.org/core
- **License:**     GPLv3 or later
- **Version:**     1.0.0

## Overview

Howdy!

The extension adds a Must-Use plugin to the WordPress installation, and runs a watcher script that frees reclaimable slab objects (includes dentries and inodes) when WordPress updates a plugin or theme.

This extension was created by WordPress Core Contributors to resolve a filesystem issue within VirtualBox after using the PHP native `rename()` function.

## Installation

1. Add the following to your `config.yaml` file:

```yaml
extensions:
    - https://github.com/costdev/chassis-wpclearcache.git
```

2. Run `vagrant provision`.

3. You should now see a new Must-Use plugin at:
> http://vagrant.local/wp/wp-admin/plugins.php?plugin_status=mustuse

4. Run the following commands and confirm that `/bin/sh /etc/init.d/wpclearcache.sh` is in the list.

```sh
vagrant ssh
htop
```

5. Press F10 to exit `htop`.

If any of these steps fail, please see the **Support** section below.

## Support

Please [check existing issues](https://github.com/costdev/chassis-wpclearcache/issues) to find out if this has already been reported.
- If so, please continue the discussion, test an existing PR or submit a new one in the existing issue.
- If not, go ahead and [open a new issue](https://github.com/costdev/chassis-wpclearcache/issues/new/choose).

## Contribute

Please [check existing enhancement requests](https://github.com/costdev/chassis-wpclearcache/labels/enhancement) to find out if this has already been requested.
- If so, feel free to submit a PR or test an existing one.
- If not, go ahead and [open a new issue](https://github.com/costdev/chassis-wpclearcache/issues/new/choose).