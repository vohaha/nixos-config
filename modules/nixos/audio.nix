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
  };
}
