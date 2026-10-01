# AV Access

The AV Access integration allows Home Assistant to communicate directly with supported AV Access HDMI matrix switches over the local network.

After installing the integration, AV Access devices can be configured and controlled directly through the Home Assistant user interface.

## Supported Devices

Currently developed and tested with:

- **AV Access 4KMX44-H2**

Support for additional AV Access devices may be added in the future.

## Requirements

The integration communicates directly with the matrix over its Telnet port.

No additional controller or cloud service is required. The matrix only needs to be reachable from Home Assistant over the local network.

## Adding the Integration

After the AV Access integration has been installed and Home Assistant has been restarted, go to:

**Settings → Devices & services → Add integration → AV Access**

Enter the connection details of your AV Access HDMI matrix.

| Field            | Required | Description                                                                           |
| ---------------- | -------- | ------------------------------------------------------------------------------------- |
| Host             | Yes      | Address of the AV Access HDMI matrix                                                  |
| Port             | Yes      | Telnet port of the matrix. Defaults to `23`                                           |
| Polling interval | Yes      | Seconds between queries to the matrix. Defaults to `3`, allowed range is `1` to `300` |

The integration reads information such as the model, firmware version and number of inputs and outputs directly from the matrix.

The connection settings can later be changed without losing the existing entities through:

**Settings → Devices & services → AV Access → Reconfigure**

## HDMI Routing

Each matrix output provides a select entity that can be used to choose the HDMI input routed to that output.

Changes made through Home Assistant are sent directly to the matrix.

Changes made using the matrix front panel or remote control are detected automatically during polling and reflected in Home Assistant.

## Naming Inputs and Outputs

Inputs and outputs can be assigned custom names through:

**Settings → Devices & services → AV Access → Configure**

An input name replaces the default `HDMI 1`, `HDMI 2`, etc. labels in the input selection of every output.

For example:

```text
HDMI 1 → Gaming PC
HDMI 2 → Apple TV
HDMI 3 → Blu-ray
```

Every input name must be unique.

Leaving a field empty restores the default name.

### Entity Names

Custom names are also added to entities associated with the corresponding port.

For example, an output named:

```text
Living room
```

changes:

```text
Output 2
```

to:

```text
Output 2 - Living room
```

An input named:

```text
Apple TV
```

changes entities such as:

```text
EDID - Input 1
```

to:

```text
EDID - Input 1 - Apple TV
```

and:

```text
HDCP Input 1
```

to:

```text
HDCP Input 1 - Apple TV
```

Output names are also added to the corresponding audio mute and CEC entities.

Renaming a port only changes the displayed entity name and select options. It does **not** change the entity ID.

Individual entity names and entity IDs can still be changed through the normal Home Assistant entity settings.

### Port Name Sensors

Every input and output also provides a sensor containing its configured name.

Ports without a custom name report their default name, such as:

```text
HDMI 1
```

or:

```text
Output 1
```

These sensors can be useful in dashboards and templates.

## EDID

Each input provides an EDID select entity.

The available EDID options are reported by the matrix itself and therefore cannot be renamed by the integration.

The selected EDID can be changed directly through Home Assistant.

## HDCP

Each input provides a switch for enabling or disabling HDCP support.

HDCP entities are only created when the connected matrix reports support for the corresponding HDCP commands.

Devices without supported HDCP commands therefore do not receive these entities.

## Audio Mute

Each output provides an audio mute switch.

The switch is:

- **On** when the output audio is muted
- **Off** when the output audio is active

## CEC

Each output can expose the CEC functions provided by the matrix.

### Power Controls

Two buttons are provided for sending CEC power commands to the connected display:

- Power on
- Power off

The matrix only sends these commands to the connected device. It does not report the actual power state of the display.

For this reason, these controls are represented as buttons rather than a switch.

### Automatic CEC Power

Each supported output provides a switch for the automatic CEC power function.

When enabled, the matrix can power off the connected display after the output has been without an active signal for the configured delay.

### CEC Delay

A number entity controls the automatic CEC delay.

The supported range is:

```text
1–30 minutes
```

CEC entities are only created when the matrix reports support for the corresponding CEC functions.

## State Updates

The matrix accepts a single command at a time and requires a short pause between commands.

For this reason, communication is serialized and commands are deliberately spaced out by the integration.

Sending multiple commands to the matrix back-to-back has been observed to cause the device to freeze.

### Polling

HDMI routing is polled every **3 seconds by default**.

The polling interval can be changed in the integration configuration.

EDID and HDCP require one command per input. Instead of querying every input at once, the integration reads one input per polling cycle.

Audio mute and CEC states are handled in the same way for outputs.

This reduces the number of commands sent to the matrix.

A change made directly on the matrix is therefore visible after one complete rotation over the relevant inputs or outputs at the latest.

Commands issued by Home Assistant are confirmed by the matrix and applied to the entities immediately, so they do not need to wait for the next polling cycle.

## Logbook

Changes detected during polling are assumed to have been made directly at the matrix, for example using:

- The front panel
- The matrix remote control

These changes are reported in the Home Assistant logbook as being changed at the matrix.

Changes initiated from Home Assistant continue to show the user or automation that triggered them.

## Templates

Every output provides a diagnostic sensor containing the number of the HDMI input currently routed to it.

This is the numeric counterpart of the output select entity.

The currently applicable EDID can, for example, be resolved using `state_translated`:

```jinja
{% set input = states('sensor.4kmx44_h2_output_1_input_number') %}
{{ state_translated('select.4kmx44_h2_edid_input_' ~ input) }}
```

The `4kmx44_h2` part of the entity ID is derived from the model of the matrix.

For other models, check the actual entity IDs under:

**Developer tools → States**

## Diagnostics

Diagnostic information can be downloaded through:

**Settings → Devices & services → AV Access → Download diagnostics**

The diagnostics contain device information and the current routing state.

Addresses are redacted so the diagnostic file can safely be attached to a bug report.

## Troubleshooting

If the matrix stops responding, avoid sending large numbers of Telnet commands to it in rapid succession.

The integration deliberately serializes communication and introduces pauses between commands to avoid overwhelming the matrix.

If Home Assistant cannot connect to the device, verify that:

- The matrix is reachable from the Home Assistant host
- The configured IP address or hostname is correct
- The configured Telnet port is correct
- Network communication between Home Assistant and the matrix is allowed

## Support

For bug reports, feature requests and supported-device discussions, use the main integration repository:

https://github.com/KeldorDE/Home-Assistant-AV-Access/issues

Source code and additional information:

https://github.com/KeldorDE/Home-Assistant-AV-Access

## License

The AV Access integration is licensed under the MIT License.
