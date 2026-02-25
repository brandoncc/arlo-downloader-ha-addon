# Arlo Downloader Home Assistant Add-on

A Home Assistant add-on wrapper around [arlo-downloader](https://github.com/diaznet/arlo-downloader) by [Jeremy Diaz](https://github.com/diaznet). All credit for the downloader itself goes to the original author.

This add-on packages arlo-downloader for easy installation and configuration through the Home Assistant UI, writing recordings to HA network storage (e.g., NFS) for long-term archival.

## Installation

1. Configure network storage in HA (Settings > System > Storage > Add Network Storage)
2. In HA: Settings > Add-ons > Add-on Store > three-dot menu > Repositories
3. Add repository URL: `https://github.com/brandoncc/arlo-downloader-ha-addon`
4. Find "Arlo Downloader" in the store and click Install
5. Configure add-on options (Arlo credentials, media path, TFA settings)
6. Start the add-on and enable "Start on boot" and "Watchdog"
