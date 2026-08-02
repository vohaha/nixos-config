# PipeWire audio stack.
{ ... }:

{
  # Realtime scheduling for the audio thread; avoids xruns/crackling.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # 32-bit games/wine
    pulse.enable = true; # PulseAudio client compatibility
    # jack.enable = true;  # uncomment for pro-audio clients

    # AirPlay: auto-discover receivers via mDNS and expose them as PipeWire
    # sinks (upstream ships this as pipewire.conf.avail/50-raop.conf, disabled
    # by default -- this re-enables it as a drop-in).
    extraConfig.pipewire."10-raop" = {
      "context.modules" = [
        {
          name = "libpipewire-module-raop-discover";
        }
      ];
    };
  };
}
