# AV Access Home Assistant App

This repository provides the Home Assistant App for the **AV Access** integration.

The app is intended to provide an easy installation method for Home Assistant OS users without requiring HACS or manual installation of custom components.

## About

The actual Home Assistant integration is maintained separately:

https://github.com/KeldorDE/Home-Assistant-AV-Access

This repository only contains the Home Assistant App packaging and installation logic.

The integration source code is not maintained separately in this repository. App builds use the integration from the main AV Access repository to avoid maintaining duplicate code.

## Installation

### Add the App Repository

In Home Assistant, go to:

**Settings → Apps → App Store → ⋮ → Repositories**

Add:

```text
https://github.com/KeldorDE/Home-Assistant-AV-Access-App
```

The **AV Access** app should then appear in the App Store.

### Install the App

1. Open the **AV Access** app.
2. Click **Install**.
3. Start the app.
4. Follow the instructions shown by the app.
5. Restart Home Assistant if required.
6. Add the **AV Access** integration through:

    **Settings → Devices & services → Add Integration → AV Access**

## Supported Home Assistant Installations

This app is intended for installations that support Home Assistant Apps, primarily:

- Home Assistant OS

Users of Home Assistant Container can install the integration directly through HACS or manually.

## Development

The repository contains the Home Assistant App definition under:

```text
av_access/
```

For local development, the repository can be opened using the Home Assistant Apps development container.

```text
.devcontainer/
```

This allows the app to be tested locally with Home Assistant Supervisor without copying files to a separate Home Assistant OS installation.

## Related Project

Main integration repository:

https://github.com/KeldorDE/Home-Assistant-AV-Access

## License

See the repository license for details.
