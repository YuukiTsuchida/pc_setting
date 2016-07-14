#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set option.mousekeys_mode_uio2click 1
/bin/echo -n .
$cli set option.mousekeys_mode_wer2click 1
/bin/echo -n .
$cli set remap.jis_commandR2commandR_toggle_kana_eisuu 1
/bin/echo -n .
$cli set remap.mouse_keys_mode_holding_m 1
/bin/echo -n .
$cli set remap.vimode_holding_v 1
/bin/echo -n .
$cli set repeat.initial_wait 400
/bin/echo -n .
$cli set repeat.wait 40
/bin/echo -n .
/bin/echo
