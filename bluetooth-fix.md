Context: You're on WirePlumber 0.5.17, which uses SPA-JSON config files (not the old Lua format) dropped into ~/.config/wireplumber/wireplumber.conf.d/. That directory already exists and contains one file (bluetooth-a2dp-autoconnect.conf) — worth a quick look first in case it touches the same settings.

1. Check the existing config for conflicts
cat ~/.config/wireplumber/wireplumber.conf.d/bluetooth-a2dp-autoconnect.conf
Just confirms it's unrelated to codec selection (likely just handles auto-switching profiles on connect) before you add a new file.

2. Create a new config file restricting the allowed Bluetooth codecs
nvim ~/.config/wireplumber/wireplumber.conf.d/51-bluez-codec.conf
with contents:
monitor.bluez.properties = {
  bluez5.codecs = [ sbc, sbc_xq, aac ]
}
This tells WirePlumber to only ever negotiate SBC, SBC-XQ, or AAC — LDAC (and aptX/aptX HD, which your dongle also advertised in the logs and could be just as unstable) are excluded entirely, so AAC becomes the best remaining choice and gets picked automatically on every future connection.

3. Restart WirePlumber (and pipewire-pulse, to be safe) to pick up the new config
systemctl --user restart wireplumber pipewire-pulse

4. Force a fresh codec negotiation by cycling the Bluetooth connection
bluetoothctl disconnect 38:18:4C:2A:F9:F7
bluetoothctl connect 38:18:4C:2A:F9:F7
(Restarting WirePlumber alone won't retroactively renegotiate an already-connected A2DP session — the codec is chosen at connect time.)

5. Verify AAC is now the one actually negotiated
❯ pactl list sinks | grep codec
Expect api.bluez5.codec = "aac".

Let me know if you want help if any step errors out.
