# AV Access

Install the **AV Access Home Assistant integration** directly from the Home Assistant App Store.

This app provides an easy installation method for Home Assistant OS users and installs the AV Access integration into Home Assistant.

## Features

- Easy installation through the Home Assistant App Store
- No HACS installation required
- Installs the AV Access integration into Home Assistant
- Supports AV Access HDMI Matrix devices supported by the integration

## Installation

1. Install the **AV Access** app.
2. Start the app.
3. Wait until the installation has completed.
4. Restart Home Assistant if required.
5. Go to:

    **Settings → Devices & services → Add Integration**

6. Search for **AV Access** and configure your device.

## Integration

The actual Home Assistant integration is maintained separately:

https://github.com/KeldorDE/Home-Assistant-AV-Access

This app only provides an alternative installation method for the integration.

## Support

For issues related to the AV Access integration or supported devices, please use:

https://github.com/KeldorDE/Home-Assistant-AV-Access/issues

# AV Access for Home Assistant

Integrate and control supported AV Access HDMI matrix switches directly from Home Assistant.

This app installs the **AV Access Home Assistant integration** and provides an easy installation method for Home Assistant OS users without requiring HACS or manual installation.

![Showcase Quick Profiles](https://raw.githubusercontent.com/KeldorDE/Home-Assistant-AV-Access/refs/heads/main/docs/images/showcase-quick-profiles.png)

![Showcase EDID Select](https://raw.githubusercontent.com/KeldorDE/Home-Assistant-AV-Access/refs/heads/main/docs/images/showcase-edid-select.png)

## Features

- HDMI input selection for each output
- EDID selection and management
- HDCP support toggle for each input
- Audio mute toggle for each output
- CEC control for each output:
    - Manual power on/off
    - Automatic power function
    - Configurable delay time
- Custom names for inputs and outputs
- Input and output names available as sensors
- Native Home Assistant entities
- Configuration through the Home Assistant UI
- Local communication with the matrix
- Support for multiple AV Access devices
- No HACS installation required

![Entities](https://raw.githubusercontent.com/KeldorDE/Home-Assistant-AV-Access/refs/heads/main/docs/images/entities.webp)

## Supported Devices

Currently developed and tested with:

- **AV Access 4KMX44-H2**

Support for additional AV Access devices may be added in the future.

## Requirements

The integration communicates directly with the matrix over its Telnet port.

No additional controller or cloud service is required. The AV Access matrix only needs to be reachable from Home Assistant over the local network.

## Installation

1. Install the **AV Access** app.
2. Start the app to install the integration.
3. Restart Home Assistant.
4. Go to **Settings → Devices & services → Add integration**.
5. Search for **AV Access**.
6. Enter the address of your AV Access HDMI matrix.

The integration is then configured and managed directly through the Home Assistant UI.

## Configuration

The integration supports configuration of:

| Field            | Description                                                 |
| ---------------- | ----------------------------------------------------------- |
| Host             | Address of the AV Access HDMI matrix                        |
| Port             | Telnet port of the matrix, default `23`                     |
| Polling interval | Interval between queries to the matrix, default `3` seconds |

Model, firmware version, number of inputs and outputs, and the link to the matrix web interface are read directly from the device.

Connection settings can later be changed through:

**Settings → Devices & services → AV Access → Reconfigure**

Input and output names can be configured through:

**Settings → Devices & services → AV Access → Configure**

Custom names are automatically reflected in the corresponding Home Assistant entities and input selections.

## State Updates

Communication with the matrix is serialized because the device accepts a single command at a time and requires a short pause between commands.

Routing is polled every 3 seconds by default. Changes made directly on the matrix, using its front panel or remote control, are automatically detected by Home Assistant.

EDID, HDCP, audio mute and CEC states are queried progressively to avoid sending too many commands to the matrix at once.

Commands issued by Home Assistant are confirmed by the matrix and applied to the corresponding entities immediately.

Changes detected directly on the matrix are also reported in the Home Assistant logbook.

![Log Book](https://raw.githubusercontent.com/KeldorDE/Home-Assistant-AV-Access/main/docs/images/logbook.webp)

## Integration Project

The actual Home Assistant integration is developed and maintained separately:

https://github.com/KeldorDE/Home-Assistant-AV-Access

This app provides an alternative installation method for the same integration.

## Support

For bug reports, feature requests and supported-device discussions, please use the issue tracker of the integration project:

https://github.com/KeldorDE/Home-Assistant-AV-Access/issues

## License

This project is licensed under the MIT License.
