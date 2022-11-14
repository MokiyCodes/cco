return function(volume)
  volume = volume or 0.5
  local speaker = peripheral.find 'speaker'
  if speaker then
    speaker.playNote('hat', volume, 1)
    sleep(0.1)
    speaker.playNote('hat', volume, 1)
    sleep(0.1)
    speaker.playNote('hat', volume, 13)
    sleep(0.2)
    speaker.playNote('hat', volume, 8)
  end
end
