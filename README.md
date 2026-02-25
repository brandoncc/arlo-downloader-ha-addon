# Arlo Downloader Home Assistant Add-on

A Home Assistant add-on wrapper around [arlo-downloader](https://github.com/diaznet/arlo-downloader) by [Jeremy Diaz](https://github.com/diaznet). All credit for the downloader itself goes to the original author.

This add-on packages arlo-downloader for easy installation and configuration through the Home Assistant UI, writing recordings to HA network storage (e.g., NFS) for long-term archival.

## Installation

### 1. Configure network storage

Go to Settings > System > Storage > Add Network Storage and configure your NFS or CIFS share:

- **Usage: Must be "Media"** — the add-on accesses storage via `/media/`, which is only available for Media-type mounts. Backup and Share mounts are not accessible.
- **Name:** Choose a name (e.g., `arlo`). This becomes the folder name under `/media/`.
- **Server:** Your NFS/CIFS server IP or hostname.
- **Remote share path:** The full export path on the server (e.g., `/var/nfs/shared/arlo`).

Once connected, your storage is available inside the add-on at `/media/<name>/`.

### 2. Install the add-on

1. In HA: Settings > Add-ons > Add-on Store > three-dot menu > Repositories
2. Add repository URL: `https://github.com/brandoncc/arlo-downloader-ha-addon`
3. Find "Arlo Downloader" in the store and click Install

### 3. Configure and start

1. Set your Arlo credentials and TFA settings
2. Set **media_directory** to the base path where recordings should be saved (e.g., `/media/arlo/videos`)
3. Set **filename_format** to control how files are organized within that directory (see below)
4. Start the add-on and enable "Start on boot" and "Watchdog"

## Configuration

### media_directory

The base path where recordings are saved. This should point to your network storage mount under `/media/`.

Example: `/media/arlo/videos`

### filename_format

Controls the directory structure and filenames within `media_directory`. The default organizes files by date and camera name:

`${Y}/${m}/${F}T${t}_${N}_${SN}`

See [pyaarlo's saving media documentation](https://github.com/twrecked/pyaarlo#saving-media) for the full list of available format variables.

## Periodic restart

The arlo-downloader process runs as a daemon, continuously monitoring for new recordings via pyaarlo's event system. It should not need restarting under normal operation. If you find it stops picking up new recordings, you can create an HA automation to restart it on a schedule:

1. Go to Settings > Automations > Create Automation
2. **Trigger:** Time pattern (e.g., daily — set hours to `0`)
3. **Action:** Call service `hassio.addon_restart` with addon `local_arlo-downloader`

You can find your exact addon ID in the URL bar when viewing the add-on in HA.
